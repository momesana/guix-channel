(define-module (momesana packages golang)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system go)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages golang-build)
  #:use-module (gnu packages golang-check)
  #:use-module (gnu packages golang-compression)
  #:use-module (gnu packages golang-web)
  #:use-module (gnu packages golang-xyz))

;; Go libraries needed by the dms command-line tool that Guix does not
;; package, or packages in a version that is too old.  They were generated
;; with "guix import go -r" and then adjusted: names carry the module's major
;; version, libraries without Go files at their repository root skip the
;; build phase, and tests that need the network, a local time zone or data
;; that upstream does not ship are skipped.

(define-public go-github-com-duxlabs-dev-dux-go
  (package
    (name "go-github-com-duxlabs-dev-dux-go")
    ;; The commit dux-files 2.1.2 pins.  dux-shell 2.1.2 pins 699311e, two
    ;; commits earlier; only a trash fix and CI changes are in between.  The
    ;; module path has no /v2, so Go knows it by this pseudo-version.
    (version "1.6.3-0.20261106152240-dc9b388fdc6f")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/duxlabs-dev/dux-go")
             (commit (go-version->git-ref version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "165qlf5ws37l94lvwqcslnf5dnrp6pvsn9hk9zkzz9vbg3gkivq5"))
       ;; cmd/go-wayland-scanner, upstream's code generator for the Wayland
       ;; protocol bindings, needs a newer gofumpt; neither DMS nor its
       ;; libraries use it.
       (modules '((guix build utils)))
       (snippet
        #~(begin
            (delete-file-recursively "cmd")
            ;; The bubblewrap sandbox for external thumbnailers binds /usr
            ;; and /nix but not the store, so tools from Guix fail in it.
            ;; Guix System need not have /usr at all.
            (substitute* "files/thumbsandbox.go"
              (("\"/nix\", ")
               "\"/nix\", \"/gnu/store\", ")
              (("\"--ro-bind\", \"/usr\"")
               "\"--ro-bind-try\", \"/usr\""))
            ;; Tools found on PATH are profile symlinks under $HOME, which
            ;; the sandbox does not bind; run their store file instead.
            (substitute* "files/thumbnailers.go"
              (("^\t\treturn path\n")
               "\t\tif real, err := filepath.EvalSymlinks(path); err == nil {
\t\t\treturn real
\t\t}
\t\treturn path\n"))))))
    (build-system go-build-system)
    (arguments
     (list
      #:go go-1.27
      #:skip-build? #t
      #:test-flags
      #~(list "-skip"
              (string-append
               "^("
               (string-join
                (list
                 ;; These need a socket under XDG_RUNTIME_DIR, which
                 ;; the build environment does not provide.
                 "TestHandshakeAndPing"
                 "TestClientCallCustomHandler"
                 "TestSubscribeAndPublish"
                 "TestSubscribeHandlerOverride"
                 "TestFindRunningSocket"
                 ;; Their socket path under the build directory is
                 ;; longer than a Unix socket address allows.
                 "TestMux"
                 "TestCallUI"
                 ;; These run scripts starting with #!/bin/sh, which
                 ;; the build environment does not have.
                 "TestExternalThumbnailerProducesCachedThumbnail"
                 "TestExternalThumbnailerFailureAndTimeoutLeaveMarker"
                 "TestUserThumbnailerOverridesNativeImageDecode"
                 "TestCommandSource"
                 "TestCommand"
                 "TestCommandTimeoutKillsProcessGroup")
                "|")
               ")$"))
      #:import-path "github.com/duxlabs-dev/dux-go"))
    (propagated-inputs (list go-github-com-charmbracelet-lipgloss
                             go-github-com-charmbracelet-log
                             go-github-com-danielgtaylor-huma-v2
                             go-github-com-fsnotify-fsnotify
                             go-github-com-go-chi-chi-v5
                             go-github-com-godbus-dbus-v5
                             go-github-com-gorilla-schema
                             go-github-com-mattn-go-isatty
                             go-github-com-muesli-termenv
                             go-github-com-spf13-cobra
                             go-github-com-stretchr-testify
                             go-golang-org-x-image
                             go-golang-org-x-sync
                             go-golang-org-x-sys
                             go-golang-org-x-text
                             go-gopkg-in-yaml-v3))
    (home-page "https://github.com/duxlabs-dev/dux-go")
    (synopsis "Common Go modules of Dux Shell and its companion tools")
    (description
     "This package provides Go modules shared by Dux Shell (formerly
DankMaterialShell) and the other Dux tools: logging, paths, IPC, Material
color generation and more.")
    (license license:expat)))

(define-public go-github-com-duxlabs-dev-dux-gop
  (package
    (name "go-github-com-duxlabs-dev-dux-gop")
    ;; The commit dux-shell 2.1.2 pins.
    (version "1.6.3-0.20261104203851-b2331e7fc9b7")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/duxlabs-dev/dux-gop")
             (commit (go-version->git-ref version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "174k3bnm5fix5738vqig6d66gw4m3rxpif8l0g4idb07rx5ig5a8"))))
    (build-system go-build-system)
    (arguments
     (list
      #:go go-1.27
      #:skip-build? #t
      ;; It expects uid 0 to be "root", but the build environment's
      ;; /etc/passwd does not list root.
      #:test-flags #~(list "-skip" "^TestProcReader_Basics$")
      #:import-path "github.com/duxlabs-dev/dux-gop"))
    (propagated-inputs (list go-github-com-caarlos0-env-v11
                             go-github-com-charmbracelet-bubbles
                             go-github-com-charmbracelet-bubbletea
                             go-github-com-charmbracelet-lipgloss
                             go-github-com-danielgtaylor-huma-v2
                             go-github-com-duxlabs-dev-dux-go
                             go-github-com-fsnotify-fsnotify
                             go-github-com-go-chi-chi-v5
                             go-github-com-shirou-gopsutil-v4
                             go-github-com-spf13-cobra
                             go-github-com-stretchr-testify
                             go-golang-org-x-sync
                             go-golang-org-x-sys))
    (home-page "https://github.com/duxlabs-dev/dux-gop")
    (synopsis "System monitoring library and tool")
    (description
     "dux-gop (formerly dgop) is a system monitoring tool with a CLI and a
REST API, built in Go.  Dux Shell uses it as a library.")
    (license license:expat)))

(define-public go-github-com-dlclark-regexp2-v2
  (package
    (name "go-github-com-dlclark-regexp2-v2")
    (version "2.9.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/dlclark/regexp2")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0p6mm2nzq09m5lqknlkdadx2c942h8a20jgg8630ry5ad6vmvljr"))))
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

(define-public go-github-com-srwiley-rasterx
  (package
    (name "go-github-com-srwiley-rasterx")
    (version "0.0.0-20220730225603-2ab79fcdd4ef")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/srwiley/rasterx")
             (commit (go-version->git-ref version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1bwb986i3l35yghss002xbbbn4mqg8w9dbvib55s2zvyy89r4ygx"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/srwiley/rasterx"))
    (propagated-inputs (list go-golang-org-x-image))
    (home-page "https://github.com/srwiley/rasterx")
    (synopsis "Vector rasterizer in Go")
    (description
     "Package rasterx implements a rasterizer in Go.  By default it renders
images with @code{ScannerGV}, which uses the rasterizer of the
@code{golang.org/x/image/vector} package.")
    (license license:bsd-3)))

(define-public go-github-com-srwiley-oksvg
  (package
    (name "go-github-com-srwiley-oksvg")
    (version "0.0.0-20221011165216-be6e8873101c")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/srwiley/oksvg")
             (commit (go-version->git-ref version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0add9sgvgnjlr5admgwj6hq3cwki2c2gjllwyrqkmb74q5izm5lm"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/srwiley/oksvg"))
    (propagated-inputs (list go-github-com-srwiley-rasterx
                             go-golang-org-x-image
                             go-golang-org-x-net))
    (home-page "https://github.com/srwiley/oksvg")
    (synopsis "SVG rasterizer in Go")
    (description
     "oksvg is a rasterizer for a partial implementation of the SVG 2.0
specification in Go.")
    (license license:bsd-3)))

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

;; Guix has go-udev 0.9.1; DMS uses UEventConn's ReceiveBufferSize and
;; MonitorWithContext, which came with this release.
(define-public go-github-com-pilebones-go-udev-0.10
  (package
    (inherit go-github-com-pilebones-go-udev)
    (version "0.10.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/pilebones/go-udev")
             (commit (string-append "v" version))))
       (file-name (git-file-name "go-github-com-pilebones-go-udev" version))
       (sha256
        (base32 "1b1fn4dbcic6pvriwfriibr7vnkcwnwsw6s2cig30lq2yfi5f85a"))))))

(define-public go-github-com-nwaples-rardecode-v2-2.4
  (package
    (inherit go-github-com-nwaples-rardecode-v2)
    (version "2.4.5")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nwaples/rardecode")
             (commit (string-append "v" version))))
       (file-name (git-file-name "go-github-com-nwaples-rardecode-v2" version))
       (sha256
        (base32 "177s0qnchp2i092wq2vdr2hfvygj6fqb8r9widf565ndrligmsjj"))))))
