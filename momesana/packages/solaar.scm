(define-module (momesana packages solaar)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (gnu packages gnome)
  #:use-module ((gnu packages admin) #:prefix upstream:))

;; Guix's solaar (since commit 6605d4dc5f, PR #9262) replaces the standard
;; 'wrap phase with one that only sets GI_TYPELIB_PATH, so bin/solaar loses
;; GUIX_PYTHONPATH and fails with "No module named 'solaar'" unless Python
;; is installed in the same profile.  This variant keeps the standard 'wrap
;; phase and sets GI_TYPELIB_PATH after it.  It also adds libnotify, without
;; which Solaar reports "Namespace Notify not available" and shows no
;; notifications; its notification tests then run and need a display.
(define-public solaar
  (package
    (inherit upstream:solaar)
    (arguments
     (list #:test-flags
           #~(list "--ignore=tests/logitech_receiver/test_desktop_notifications.py"
                   "--ignore=tests/solaar/ui/test_desktop_notifications.py")
           #:phases
           #~(modify-phases %standard-phases
               (add-after 'wrap 'wrap-typelib-path
                 (lambda _
                   (wrap-program (string-append #$output "/bin/solaar")
                     `("GI_TYPELIB_PATH" = (,(getenv "GI_TYPELIB_PATH")))))))))
    (inputs (modify-inputs (package-inputs upstream:solaar)
              (append libnotify)))))
