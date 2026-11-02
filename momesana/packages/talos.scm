(define-module (momesana packages talos)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:))

;; The upstream release binary: it is statically linked, so it runs
;; unmodified on Guix System.  Building from source would mean packaging
;; several hundred Go modules.
(define-public talosctl
  (package
    (name "talosctl")
    (version "1.14.5")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://github.com/siderolabs/talos/releases/download/v"
                           version "/talosctl-linux-amd64"))
       (file-name name)
       (sha256
        (base32 "0zbx9mqrsgkq5rnwvp5hjr8js8ylrsi0hfjnkjvfc2b7k1l2nhzz"))))
    (build-system copy-build-system)
    (arguments
     (list #:install-plan ''(("talosctl" "bin/"))
           #:phases
           #~(modify-phases %standard-phases
               (add-after 'install 'make-executable
                 (lambda _
                   (chmod (string-append #$output "/bin/talosctl") #o555))))))
    (supported-systems '("x86_64-linux"))
    (home-page "https://www.talos.dev")
    (synopsis "Command-line tool for Talos Linux")
    (description
     "@command{talosctl} configures and manages Talos Linux, an immutable
operating system for Kubernetes nodes.  This package installs the statically
linked binary published by the Talos project.")
    (license license:mpl2.0)))
