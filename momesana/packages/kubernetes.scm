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

(define-public k9s
  (package
    (name "k9s")
    (version "0.51.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://github.com/derailed/k9s/releases/download/v"
                           version "/k9s_Linux_amd64.tar.gz"))
       (file-name (string-append name "-" version "-linux-amd64.tar.gz"))
       (sha256
        (base32 "1mqx2v46ybskjx3ljlp6p3jd192mdvmlx7412fhiah2s3bajlxf3"))))
    (build-system copy-build-system)
    (arguments
     (list #:install-plan ''(("k9s" "bin/"))))
    (supported-systems '("x86_64-linux"))
    (home-page "https://k9scli.io")
    (synopsis "Terminal user interface for Kubernetes clusters")
    (description
     "@command{k9s} is a terminal user interface for navigating, observing and
managing the resources of a Kubernetes cluster.  This package installs the
statically linked binary published by the project.")
    (license license:asl2.0)))
