(define-module (momesana packages solaar)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (gnu packages gnome)
  #:use-module ((gnu packages admin) #:prefix upstream:))

;; Guix's solaar replaces the standard 'wrap phase with one that only sets
;; GI_TYPELIB_PATH, so bin/solaar finds its Python modules only when Python
;; itself is installed in the same profile (which exports GUIX_PYTHONPATH).
;; Add the Python search path to the wrapper as the standard phase would.
;; Also add libnotify, without which Solaar cannot show notifications
;; ("Namespace Notify not available").
(define-public solaar
  (package
    (inherit upstream:solaar)
    (inputs (modify-inputs (package-inputs upstream:solaar)
              (append libnotify)))
    (arguments
     (substitute-keyword-arguments
         (ensure-keyword-arguments
          (package-arguments upstream:solaar)
          ;; With libnotify available these tests run and need a display.
          (list #:test-flags
                #~(list "--ignore=tests/logitech_receiver/test_desktop_notifications.py"
                        "--ignore=tests/solaar/ui/test_desktop_notifications.py")))
       ((#:phases phases)
        #~(modify-phases #$phases
            (add-after 'wrap 'wrap-python-path
              (lambda* (#:key inputs outputs #:allow-other-keys)
                (wrap-program (string-append #$output "/bin/solaar")
                  `("GUIX_PYTHONPATH" prefix
                    (,(site-packages inputs outputs)
                     ,@(search-path-as-string->list
                        (getenv "GUIX_PYTHONPATH"))))
                  `("GI_TYPELIB_PATH" prefix
                    (,(dirname
                       (search-input-file
                        inputs "lib/girepository-1.0/Notify-0.7.typelib")))))))))))))
