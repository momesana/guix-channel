(define-module (momesana packages kubernetes)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:))

;; Upstream release binaries: they are statically linked, so they run
;; unmodified on Guix System.  Building from source would mean packaging
;; several hundred Go modules for each.

;; Guix's kubectl lags behind: kubectl only supports API servers within
;; one minor version, so it must follow the cluster's Kubernetes version.
(define-public kubectl
  (package
    (name "kubectl")
    (version "1.36.6")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://dl.k8s.io/release/v" version
                           "/bin/linux/amd64/kubectl"))
       (file-name name)
       (sha256
        (base32 "0d16ia3620kngka5vgiqwwjpf0ldap870x1hjav654nw55kqp099"))))
    (build-system copy-build-system)
    (arguments
     (list #:install-plan ''(("kubectl" "bin/"))
           #:phases
           #~(modify-phases %standard-phases
               (add-after 'install 'make-executable
                 (lambda _
                   (chmod (string-append #$output "/bin/kubectl") #o555))))))
    (supported-systems '("x86_64-linux"))
    (home-page "https://kubernetes.io")
    (synopsis "Command-line tool for Kubernetes")
    (description
     "@command{kubectl} runs commands against Kubernetes clusters: it deploys
applications, inspects and manages cluster resources and shows logs.  This
package installs the statically linked binary published by the Kubernetes
project.")
    (license license:asl2.0)))

;; Guix's "helm" is a synthesizer.
(define-public kubernetes-helm
  (package
    (name "kubernetes-helm")
    (version "4.3.2")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://get.helm.sh/helm-v" version
                           "-linux-amd64.tar.gz"))
       (sha256
        (base32 "10rrlpd0gz8khmhxwz2pisx48s90vjrzal3y5mc7kaxy8s6jgh6i"))))
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

(define-public cilium-cli
  (package
    (name "cilium-cli")
    (version "0.20.3")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://github.com/cilium/cilium-cli/releases/download/v"
                           version "/cilium-linux-amd64.tar.gz"))
       (file-name (string-append name "-" version "-linux-amd64.tar.gz"))
       (sha256
        (base32 "1my73rzd53dl7vpdzv0k8yv9f7hxsjyaffjmjvyd642k346sv1xr"))))
    (build-system copy-build-system)
    (arguments
     (list #:install-plan ''(("cilium" "bin/"))))
    (supported-systems '("x86_64-linux"))
    (home-page "https://github.com/cilium/cilium-cli")
    (synopsis "Command-line tool for Cilium")
    (description
     "@command{cilium} installs and manages Cilium, the eBPF-based network
plugin for Kubernetes, and checks a cluster's status and connectivity.  This
package installs the statically linked binary published by the Cilium
project.")
    (license license:asl2.0)))
