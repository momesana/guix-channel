(define-module (momesana packages kubernetes)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:))

;; Upstream release binaries: they are statically linked, so they run
;; unmodified on Guix System.  Building from source would mean packaging
;; several hundred Go modules for each.

;; Guix's "helm" is a synthesizer.
(define-public kubernetes-helm
  (package
    (name "kubernetes-helm")
    (version "4.3.1")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://get.helm.sh/helm-v" version
                           "-linux-amd64.tar.gz"))
       (sha256
        (base32 "0jz5gwszb4irkmmxldhpb2kzw8bp1187nim220dx24q9wa5ah0q4"))))
    (build-system copy-build-system)
    (arguments
     (list #:install-plan ''(("helm" "bin/"))))
    (supported-systems '("x86_64-linux"))
    (home-page "https://helm.sh")
    (synopsis "Package manager for Kubernetes")
    (description
     "@command{helm} installs and upgrades applications on Kubernetes from
charts, which are templated sets of Kubernetes resources.  This package
installs the statically linked binary published by the Helm project.")
    (license license:asl2.0)))
