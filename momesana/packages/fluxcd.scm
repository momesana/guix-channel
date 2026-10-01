(define-module (momesana packages fluxcd)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:))

;; The upstream release binary: it is statically linked, so it runs
;; unmodified on Guix System.  Building from source would mean packaging
;; several hundred Go modules.
(define-public fluxcd
  (package
    (name "fluxcd")
    (version "2.9.6")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://github.com/fluxcd/flux2/releases/download/v"
                           version "/flux_" version "_linux_amd64.tar.gz"))
       (sha256
        (base32 "1ia2in7fwp2m0kc447i9xpf8a0097gpskwc1i1ibsv14x5rjdlml"))))
    (build-system copy-build-system)
    (arguments
     (list #:install-plan ''(("flux" "bin/"))))
    (supported-systems '("x86_64-linux"))
    (home-page "https://fluxcd.io")
    (synopsis "Command-line tool for Flux, the GitOps toolkit for Kubernetes")
    (description
     "@command{flux} bootstraps and manages Flux, which keeps Kubernetes
clusters in sync with configuration in Git repositories.  This package
installs the statically linked binary published by the Flux project.")
    (license license:asl2.0)))
