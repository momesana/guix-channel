(define-module (momesana packages dms)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system go)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages golang-build)
  #:use-module (gnu packages golang-check)
  #:use-module (gnu packages golang-compression)
  #:use-module (gnu packages golang-vcs)
  #:use-module (gnu packages golang-web)
  #:use-module (gnu packages golang-xyz)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages virtualization)
  #:use-module (gnu packages window-management)
  #:use-module (momesana packages golang))

(define %dms-version "2.0.0")

(define %tailscale-stub "\
package tailscale

import \"github.com/duxlabs-dev/dux-go/ipc\"

type TailscaleState struct{}

type Manager struct{}

func NewManager(socketPath string) *Manager { return &Manager{} }

func (m *Manager) IsAvailable() bool { return false }

func (m *Manager) SetAvailabilityCallback(cb func(bool)) {}

func (m *Manager) GetState() TailscaleState { return TailscaleState{} }

func (m *Manager) Subscribe(clientID string) chan TailscaleState {
	return make(chan TailscaleState)
}

func (m *Manager) Unsubscribe(clientID string) {}

func (m *Manager) Close() {}

func HandleRequest(conn *ipc.ConnWriter, req ipc.Request, manager *Manager) {
	conn.RespondError(req.ID, \"Tailscale support is not built in\")
}
")

(define-public dms
  (package
    (name "dms")
    (version %dms-version)
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/duxlabs-dev/dux-shell")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1bsd6ydqm5mc1jygih69rpb4ir6jl0xf3ipmqq4pn6cfrip9s9c7"))
       (modules '((guix build utils)))
       ;; The Tailscale integration is the only user of the tailscale.com Go
       ;; module, which is not packaged in Guix.  Replace it with a stub that
       ;; reports Tailscale as unavailable; callers already guard for that.
       (snippet
        #~(begin
            (for-each delete-file
                      (find-files "core/internal/server/tailscale" "\\.go$"))
            (call-with-output-file "core/internal/server/tailscale/stub.go"
              (lambda (port)
                (display #$%tailscale-stub port)))))))
    (build-system go-build-system)
    (arguments
     ;; Built without the "withshell" tag: the QML stays in
     ;; dank-material-shell-qml and is passed with "dms run -c".
     (list #:go go-1.27
           #:import-path "github.com/duxlabs-dev/dux-shell/core/cmd/dms"
           #:unpack-path "github.com/duxlabs-dev/dux-shell"
           #:install-source? #f
           #:tests? #f
           #:build-flags
           #~(list (string-append "-ldflags=-X main.Version=v" #$%dms-version))))
    (inputs
     (list go-github-com-duxlabs-dev-dux-go
           go-github-com-duxlabs-dev-dux-gop
           go-github-com-alecthomas-chroma-v2-2.27
           go-github-com-charmbracelet-bubbles
           go-github-com-charmbracelet-bubbletea
           go-github-com-charmbracelet-lipgloss
           go-github-com-charmbracelet-log
           go-github-com-dlclark-regexp2-v2
           go-github-com-fsnotify-fsnotify
           go-github-com-go-git-go-git-v6
           go-github-com-godbus-dbus-v5
           go-github-com-holoplot-go-evdev
           go-github-com-klauspost-compress
           go-github-com-lucasb-eyer-go-colorful
           go-github-com-mattn-go-isatty
           go-github-com-pilebones-go-udev-0.10
           go-github-com-sblinch-kdl-go
           go-github-com-spf13-afero
           go-github-com-spf13-cobra
           go-github-com-spf13-pflag
           go-github-com-srwiley-oksvg
           go-github-com-srwiley-rasterx
           go-github-com-wifx-gonetworkmanager-v2
           go-github-com-yeqown-go-qrcode-v2
           go-github-com-yeqown-go-qrcode-writer-standard
           go-github-com-yuin-goldmark
           go-go-etcd-io-bbolt
           go-golang-org-x-image
           go-golang-org-x-sys
           go-golang-org-x-text
           go-gopkg-in-yaml-v3))
    (home-page "https://github.com/duxlabs-dev/dux-shell")
    (synopsis "Command-line backend for Dux Shell")
    (description
     "This package provides @command{dms}, the command-line tool and backend
server of Dux Shell (formerly DankMaterialShell).  The QML shell calls it
for brightness control, monitor configuration, keybindings, session locking
and other tasks that cannot be done from QML.  Tailscale support is not
included.")
    (license license:expat)))

(define-public dank-material-shell-qml
  (package
    (name "dank-material-shell-qml")
    (version %dms-version)
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/duxlabs-dev/dux-shell")
             (commit (string-append "v" version))
             (recursive? #t)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1fddn2psb7v12g4lkqd7sp58m60irjrsfwrm2m715i15njnz9djc"))))
    (build-system copy-build-system)
    (arguments
     ;; quickshell/DCommon is a symlink into the dux-qml-common submodule,
     ;; so both directories have to be installed side by side.
     (list #:install-plan
           #~'(("quickshell" "share/dms/quickshell")
               ("dux-qml-common" "share/dms/dux-qml-common"))))
    (propagated-inputs
     (list quickshell qtwayland))
    (home-page "https://github.com/duxlabs-dev/dux-shell")
    (synopsis "Quickshell-based desktop shell for Wayland compositors")
    (description
     "This package provides the QML part of Dux Shell (formerly
DankMaterialShell), a desktop suite for Wayland compositors such as niri,
Hyprland and Sway.  Run it with @code{dms run -c
@var{prefix}/share/dms/quickshell}.")
    (license license:expat)))

(define-public dux-files
  (package
    (name "dux-files")
    (version "2.0.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/duxlabs-dev/dux-files")
             (commit (string-append "v" version))
             (recursive? #t)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1jjnanzlxnj1s51a7gn1rgj39b3wlmrp2r5ghwq8pw2pczbcfzj4"))))
    (build-system go-build-system)
    (arguments
     (list #:go go-1.27
           #:import-path "github.com/duxlabs-dev/dux-files/core/cmd/dfiles"
           #:unpack-path "github.com/duxlabs-dev/dux-files"
           #:install-source? #f
           #:tests? #f
           #:build-flags
           #~(list "-tags=withshell"
                   (string-append "-ldflags=-X main.Version=" #$version))
           #:phases
           #~(modify-phases %standard-phases
               ;; What upstream's sync-shell target does: go:embed rejects
               ;; symlinks, so the DCommon submodule link is dereferenced.
               (add-after 'unpack 'embed-shell
                 (lambda* (#:key unpack-path #:allow-other-keys)
                   (with-directory-excursion (string-append "src/" unpack-path)
                     (let ((dist "core/internal/shellembed/dist"))
                       (copy-recursively "quickshell" dist
                                         #:follow-symlinks? #t)
                       (with-directory-excursion dist
                         (for-each delete-file-recursively
                                   (filter file-exists?
                                           '("translations/extract_translations.py"
                                             "scripts" "tests" ".claude"
                                             ".qmlls.ini"))))))))
               (add-after 'install 'install-data
                 (lambda* (#:key unpack-path #:allow-other-keys)
                   (let ((dfiles (string-append #$output "/bin/dfiles"))
                         (share (string-append #$output "/share")))
                     (with-directory-excursion
                         (string-append "src/" unpack-path "/assets")
                       (install-file "dev.duxlabs.files.svg"
                                     (string-append
                                      share "/icons/hicolor/scalable/apps"))
                       (install-file "dev.duxlabs.files.desktop"
                                     (string-append share "/applications"))
                       (install-file "dev.duxlabs.files.metainfo.xml"
                                     (string-append share "/metainfo"))
                       (install-file "dev.duxlabs.files.policy"
                                     (string-append share "/polkit-1/actions"))
                       (install-file "portal/dfiles.portal"
                                     (string-append
                                      share "/xdg-desktop-portal/portals"))
                       (for-each
                        (lambda (file)
                          (substitute* file
                            (("/usr/bin/dfiles") dfiles))
                          (install-file file
                                        (string-append share "/dbus-1/services")))
                        (find-files "dbus" "\\.service$"))
                       (substitute* "systemd/dfiles.service"
                         (("/usr/bin/dfiles") dfiles))
                       (install-file "systemd/dfiles.service"
                                     (string-append share "/systemd/user"))))))
               ;; dux-go runs "qs" and the thumbnail sandbox's "bwrap" from
               ;; PATH.  Ones already there, such as the quickshell Dux Shell
               ;; propagates or a foreign distribution's bwrap, come first.
               (add-after 'install-data 'wrap
                 (lambda* (#:key inputs #:allow-other-keys)
                   (wrap-program (string-append #$output "/bin/dfiles")
                     `("PATH" suffix
                       ,(map (lambda (file)
                               (dirname (search-input-file inputs file)))
                             '("bin/qs" "bin/bwrap")))))))))
    (inputs
     (list bash-minimal
           bubblewrap
           quickshell
           go-github-com-duxlabs-dev-dux-go
           go-github-com-bodgit-sevenzip
           go-github-com-cavaliergopher-cpio
           go-github-com-fsnotify-fsnotify
           go-github-com-go-git-go-billy-v5
           go-github-com-go-git-go-git-v5
           go-github-com-godbus-dbus-v5
           go-github-com-klauspost-compress
           go-github-com-nwaples-rardecode-v2-2.4
           go-github-com-sorairolake-lzip-go
           go-github-com-spf13-cobra
           go-github-com-ulikunitz-xz
           go-golang-org-x-image
           go-golang-org-x-sys))
    (home-page "https://github.com/duxlabs-dev/dux-files")
    (synopsis "File manager for the Dux desktop")
    (description
     "Dux Files is a Quickshell-based file manager for Wayland with tabs, split
panes, list, grid and column views, recursive search, file operations with
undo, archive handling, udisks2 devices and gvfs network shares.  It can serve
the desktop portal's file chooser and owns
@code{org.freedesktop.FileManager1}.  It takes its colors from Dux Shell when
that runs.")
    (license license:expat)))
