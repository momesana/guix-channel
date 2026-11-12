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

;; Also a statically linked upstream release binary, like talosctl.
(define-public talhelper
  (package
    (name "talhelper")
    (version "3.1.17")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://github.com/budimanjojo/talhelper/releases/download/v"
                           version "/talhelper_linux_amd64.tar.gz"))
       (file-name (string-append name "-" version "-linux-amd64.tar.gz"))
       (sha256
        (base32 "0172bfwqsw2llwiwlbxyzg3zn3wvj06h5i22m2v3fih0d4jidyfz"))))
    (build-system copy-build-system)
    (arguments
     (list #:install-plan ''(("talhelper" "bin/"))))
    (supported-systems '("x86_64-linux"))
    (home-page "https://budimanjojo.github.io/talhelper/")
    (synopsis "Generate Talos Linux machine configurations")
    (description
     "@command{talhelper} generates the machine configuration of every node in
a Talos Linux cluster from one @file{talconfig.yaml} and a SOPS-encrypted
secrets file, so the cluster's Talos configuration can be kept in Git.  This
package installs the statically linked binary published by the project.")
    (license license:bsd-3)))
