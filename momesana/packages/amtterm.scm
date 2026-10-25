(define-module (momesana packages amtterm)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system meson)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages perl-web)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages tls))

;; Upstream publishes 1.8 only as a git tag; kraxel.org's tarballs stop at
;; 1.7.  The GTK frontend gamt is built only when gtk+ and vte are inputs.
;; 1.8's -P option (no TLS) closes every connection; the patch, upstream MR
;; !3, fixes that.
(define-public amtterm
  (package
    (name "amtterm")
    (version "1.8")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/kraxel/amtterm")
             (commit (string-append "amtterm-" version "-1"))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1a39v32mnw9n78ljngfybyr6xq995qfg5wvaa8gd0vi0jim5prs5"))
       (patches (list (local-file "amtterm-plain-connection.patch")))))
    (build-system meson-build-system)
    (arguments
     (list #:tests? #f                  ;no test suite
           #:phases
           #~(modify-phases %standard-phases
               ;; amttool is a Perl script using SOAP::Lite.
               (add-after 'install 'wrap-amttool
                 (lambda _
                   (wrap-program (string-append #$output "/bin/amttool")
                     `("PERL5LIB" ":" prefix (,(getenv "PERL5LIB")))))))))
    (native-inputs (list pkg-config))
    ;; glib is only needed by gamt, but meson.build requires it regardless.
    (inputs (list glib gnutls perl perl-soap-lite))
    (home-page "https://github.com/kraxel/amtterm")
    (synopsis "Serial-over-LAN and IDE redirection client for Intel AMT")
    (description
     "amtterm connects to the serial-over-LAN (SOL) port of machines with
Intel Active Management Technology (vPro), optionally over TLS.  The package
also provides amtider for IDE redirection and amttool, which queries and
power-controls machines through AMT's legacy SOAP interface.")
    (license license:gpl2+)))
