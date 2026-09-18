(define-module (momesana packages golang)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system go)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages golang-build)
  #:use-module (gnu packages golang-check)
  #:use-module (gnu packages golang-web)
  #:use-module (gnu packages golang-xyz))

;; Go libraries needed by the dms command-line tool that Guix does not
;; package, or packages in a version that is too old.  They were generated
;; with "guix import go -r" and then adjusted: names carry the module's major
;; version, libraries without Go files at their repository root skip the
;; build phase, and tests that need the network, a local time zone or data
;; that upstream does not ship are skipped.

(define-public go-github-com-avengemedia-dankgo
  (package
    (name "go-github-com-avengemedia-dankgo")
    (version "1.6.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/AvengeMedia/dankgo")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0319dmrbhbycw46k7x138vxb1730871m9blji700wh1p5garxkz5"))))
    (build-system go-build-system)
    (arguments
     (list
      #:go go-1.26
      #:skip-build? #t
      ;; These need a socket under XDG_RUNTIME_DIR, which the build
      ;; environment does not provide.
      #:test-flags
      #~(list "-skip" (string-join (list "TestHandshakeAndPing"
                                         "TestClientCallCustomHandler"
                                         "TestSubscribeAndPublish"
                                         "TestSubscribeHandlerOverride"
                                         "TestFindRunningSocket")
                                   "|"))
      #:import-path "github.com/AvengeMedia/dankgo"))
    (propagated-inputs (list go-github-com-charmbracelet-lipgloss
                             go-github-com-charmbracelet-log
                             go-github-com-danielgtaylor-huma-v2
                             go-github-com-go-chi-chi-v5
                             go-github-com-godbus-dbus-v5
                             go-github-com-gorilla-schema
                             go-github-com-iancoleman-strcase
                             go-github-com-mattn-go-isatty
                             go-github-com-muesli-termenv
                             go-github-com-spf13-cobra
                             go-github-com-stretchr-testify
                             go-golang-org-x-crypto
                             go-golang-org-x-sync
                             go-golang-org-x-sys
                             go-golang-org-x-tools
                             go-mvdan-cc-gofumpt))
    (home-page "https://github.com/AvengeMedia/dankgo")
    (synopsis "dankgo")
    (description
     "Common Go modules used by DMS & the Dank Linux suite (dankcalendar, dgop,
danksearch, and whatever comes next).")
    (license license:expat)))

(define-public go-github-com-avengemedia-dgop
  (package
    (name "go-github-com-avengemedia-dgop")
    (version "1.6.1-0.20260916132520-8a12dbc6e287")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/AvengeMedia/dgop")
             (commit (go-version->git-ref version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0m6y7vxyhli8hcj427vjjjiwq4lx56q016i69707jk64p4sw3s1r"))))
    (build-system go-build-system)
    (arguments
     (list
      #:go go-1.26
      #:skip-build? #t
      #:import-path "github.com/AvengeMedia/dgop"))
    (propagated-inputs (list go-github-com-avengemedia-dankgo
                             go-github-com-caarlos0-env
                             go-github-com-charmbracelet-bubbles
                             go-github-com-charmbracelet-bubbletea
                             go-github-com-charmbracelet-lipgloss
                             go-github-com-danielgtaylor-huma-v2
                             go-github-com-fsnotify-fsnotify
                             go-github-com-go-chi-chi-v5
                             go-github-com-shirou-gopsutil-v4
                             go-github-com-spf13-cobra
                             go-github-com-stretchr-testify
                             go-golang-org-x-sync
                             go-golang-org-x-sys))
    (home-page "https://github.com/AvengeMedia/dgop")
    (synopsis "dgop")
    (description
     "System monitoring tool with CLI and REST API built in Go.  Fast, single binary,
JSON output, @code{OpenAPI} spec.")
    (license license:expat)))

(define-public go-github-com-nadim147c-material-v3
  (package
    (name "go-github-com-nadim147c-material-v3")
    (version "3.1.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Nadim147c/material")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1g7czr154pcbnzhchkqqclq70s5ym09lm691r8kbri9z5dv544pn"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/Nadim147c/material/v3"))
    (home-page "https://github.com/Nadim147c/material")
    (synopsis "Material")
    (description
     "This package provides a pure go implementation of without any external
dependencies.")
    (license license:asl2.0)))

(define-public go-github-com-dlclark-regexp2-v2
  (package
    (name "go-github-com-dlclark-regexp2-v2")
    (version "2.5.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/dlclark/regexp2")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1xld5hb2v2ih8sjjz8n0x38fv0d4xdwykhfl94yfdjc7f6ym7vik"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/dlclark/regexp2/v2"))
    (home-page "https://github.com/dlclark/regexp2")
    (synopsis "regexp2 - full featured regular expressions for Go")
    (description
     "Package regexp2 is a regexp package that has an interface similar to Go's
framework regexp engine but uses a more feature full regex engine behind the
scenes.")
    (license license:expat)))

(define-public go-github-com-yeqown-reedsolomon
  (package
    (name "go-github-com-yeqown-reedsolomon")
    (version "1.0.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/yeqown/reedsolomon")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1a7nwx3zw72f330jddklc7na941d2zdyahswifwdjk4giycyzasm"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/yeqown/reedsolomon"))
    (home-page "https://github.com/yeqown/reedsolomon")
    (synopsis #f)
    (description #f)
    (license #f)))

(define-public go-github-com-yeqown-go-qrcode-v2
  (package
    (name "go-github-com-yeqown-go-qrcode-v2")
    (version "2.2.5")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/yeqown/go-qrcode")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "02131hnls752nh62lzndwsq2b003bk0h9jr1cs89ibhmxyqcz0v8"))))
    (build-system go-build-system)
    (arguments
     (list
      ;; cmd/qrcode pulls in modules that are not packaged, and it depends
      ;; on writer/standard, which in turn depends on this package.
      #:test-subdirs #~(list "")
      #:import-path "github.com/yeqown/go-qrcode/v2"))
    (propagated-inputs (list go-github-com-stretchr-testify
                             go-github-com-yeqown-reedsolomon))
    (home-page "https://github.com/yeqown/go-qrcode")
    (synopsis "go-qrcode")
    (description "Package qrcode ...  encoder.go working for data encoding.")
    (license license:expat)))

(define-public go-github-com-yeqown-go-qrcode-writer-standard
  (package
    (name "go-github-com-yeqown-go-qrcode-writer-standard")
    (version "1.3.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/yeqown/go-qrcode")
             (commit (go-version->git-ref version
                                          #:subdir "writer/standard"))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1ng6ppg6m5a0ydyznlpq3dzwq8ll96nz1dvwdkl92p7ba2cy2zkv"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/yeqown/go-qrcode/writer/standard"
      #:unpack-path "github.com/yeqown/go-qrcode"
      ;; The tests write their output into a directory that upstream does
      ;; not ship.
      #:phases
      #~(modify-phases %standard-phases
          (add-before 'check 'create-testdata-directory
            (lambda _
              (mkdir-p (string-append
                        "src/github.com/yeqown/go-qrcode/writer/standard"
                        "/testdata")))))))
    (propagated-inputs (list go-github-com-fogleman-gg
                             go-github-com-pkg-errors
                             go-github-com-stretchr-testify
                             go-github-com-yeqown-go-qrcode-v2
                             go-golang-org-x-image))
    (home-page "https://github.com/yeqown/go-qrcode")
    (synopsis "Standard Writer")
    (description
     "Standard Writer is a writer that is used to draw QR Code image into
@@code{io.Writer}, normally a file.")
    (license license:expat)))

(define-public go-github-com-sblinch-kdl-go
  (package
    (name "go-github-com-sblinch-kdl-go")
    (version "0.0.0-20260121213736-8b7053306ca6")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/sblinch/kdl-go")
             (commit (go-version->git-ref version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1flr5sxvglajiw9nh65flpzc8c17nzgisqx8y284f53a80x00ja9"))))
    (build-system go-build-system)
    (arguments
     (list
      ;; The parser and tokenizer conformance tests read their test cases
      ;; from a checkout of the kdl-org/kdl repository that upstream expects
      ;; next to this one, so only the other packages are tested.
      #:test-subdirs #~(list "" "document" "internal/marshaler")
      ;; The marshaling tests assert a fixed ordering of Go map keys, which
      ;; the runtime randomizes, and TestUnmarshalMapTimes expects a local
      ;; time zone, which the build environment does not have.
      #:test-flags
      #~(list "-skip" (string-join (list "TestMarshalSuite"
                                         "TestBug3"
                                         "TestUnmarshalMapTimes")
                                   "|"))
      #:import-path "github.com/sblinch/kdl-go"))
    (home-page "https://github.com/sblinch/kdl-go")
    (synopsis "KDLv1 Library for Go")
    (description
     "kdl-go is a Go library for @@url{https://kdl.dev/spec-v1/,version 1} of the
@@url{https://kdl.dev/,KDL Document Language}.  It supports encoding and
decoding KDL documents, marshaling and unmarshaling them into Go structs.")
    (license license:expat)))

;; Guix has chroma 2.20.0, which still uses regexp2 v1.  DMS needs this
;; release, the first one built against regexp2 v2.
(define-public go-github-com-alecthomas-chroma-v2-2.27
  (package
    (name "go-github-com-alecthomas-chroma-v2")
    (version "2.27.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/alecthomas/chroma")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "18p9inwlwkbsgi9frqhxhqqwdymnwm02iqpjdgk7dg8sa0ab92w8"))
       ;; The command-line tools need modules that are not packaged; the
       ;; library does not.  Guix's own chroma package drops them too.
       (modules '((guix build utils)))
       (snippet #~(delete-file-recursively "cmd"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/alecthomas/chroma/v2"))
    (propagated-inputs (list go-github-com-alecthomas-assert-v2
                             go-github-com-alecthomas-repr
                             go-github-com-dlclark-regexp2-v2))
    (home-page "https://github.com/alecthomas/chroma")
    (synopsis "A general purpose syntax highlighter in pure Go")
    (description
     "Package chroma takes source code and other structured text and converts it into
syntax highlighted HTML, ANSI- coloured text, etc.")
    (license license:expat)))
