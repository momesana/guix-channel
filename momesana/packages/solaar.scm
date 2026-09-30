(define-module (momesana packages solaar)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module ((gnu packages admin) #:prefix upstream:))

;; Guix's solaar replaces the standard 'wrap phase with one that only sets
;; GI_TYPELIB_PATH, so bin/solaar finds its Python modules only when Python
;; itself is installed in the same profile (which exports GUIX_PYTHONPATH).
;; Add the Python search path to the wrapper as the standard phase would.
(define-public solaar
  (package
    (inherit upstream:solaar)
    (arguments
     (substitute-keyword-arguments (package-arguments upstream:solaar)
       ((#:phases phases)
        #~(modify-phases #$phases
            (add-after 'wrap 'wrap-python-path
              (lambda* (#:key inputs outputs #:allow-other-keys)
                (wrap-program (string-append #$output "/bin/solaar")
                  `("GUIX_PYTHONPATH" prefix
                    (,(site-packages inputs outputs)
                     ,@(search-path-as-string->list
                        (getenv "GUIX_PYTHONPATH")))))))))))))
