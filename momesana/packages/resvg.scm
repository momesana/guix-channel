(define-module (momesana packages resvg)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system cargo)
  #:use-module ((guix licenses) #:prefix license:))

(define-public resvg
  (package
    (name "resvg")
    (version "0.48.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "resvg" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1gcn2590qwl3hzs3qqz1j96j00l1gb8csvkwpw6fi6drjwzq1qv7"))))
    (build-system cargo-build-system)
    (arguments
     (list #:install-source? #f))
    (inputs (cargo-inputs 'resvg #:module '(momesana packages rust-crates)))
    (home-page "https://github.com/linebender/resvg")
    (synopsis "SVG rendering tool")
    (description
     "resvg renders SVG images to PNG.  It implements the static subset of
SVG, including text, and needs no system graphics libraries.")
    (license (list license:asl2.0 license:expat))))
