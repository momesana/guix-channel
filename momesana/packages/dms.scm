(define-module (momesana packages dms)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system go)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages golang-build)
  #:use-module (gnu packages golang-check)
  #:use-module (gnu packages golang-compression)
  #:use-module (gnu packages golang-vcs)
  #:use-module (gnu packages golang-web)
  #:use-module (gnu packages golang-xyz)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages window-management)
  #:use-module (momesana packages golang))

(define %dms-version "1.6.2")

(define %tailscale-stub "\
package tailscale

import \"github.com/AvengeMedia/DankMaterialShell/core/internal/server/models\"

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

func HandleRequest(conn *models.Conn, req models.Request, manager *Manager) {
	models.RespondError(conn, req.ID, \"Tailscale support is not built in\")
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
             (url "https://github.com/AvengeMedia/DankMaterialShell")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0yqg92yxfwsflsxy393fww2m1rndr5kvlyq80yd8wpm2g3gigxil"))
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
     (list #:go go-1.26
           #:import-path "github.com/AvengeMedia/DankMaterialShell/core/cmd/dms"
           #:unpack-path "github.com/AvengeMedia/DankMaterialShell"
           #:install-source? #f
           #:tests? #f
           #:build-flags
           #~(list (string-append "-ldflags=-X main.Version=v" #$%dms-version))))
    (inputs
     (list go-github-com-avengemedia-dankgo
           go-github-com-avengemedia-dgop
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
           go-github-com-nadim147c-material-v3
           go-github-com-pilebones-go-udev
           go-github-com-sblinch-kdl-go
           go-github-com-spf13-afero
           go-github-com-spf13-cobra
           go-github-com-wifx-gonetworkmanager-v2
           go-github-com-yeqown-go-qrcode-v2
           go-github-com-yeqown-go-qrcode-writer-standard
           go-github-com-yuin-goldmark
           go-go-etcd-io-bbolt
           go-golang-org-x-image
           go-golang-org-x-text))
    (home-page "https://github.com/AvengeMedia/DankMaterialShell")
    (synopsis "Command-line backend for DankMaterialShell")
    (description
     "This package provides @command{dms}, the command-line tool and backend
server of DankMaterialShell.  The QML shell calls it for brightness control,
monitor configuration, keybindings, session locking and other tasks that
cannot be done from QML.  Tailscale support is not included.")
    (license license:expat)))

(define-public dank-material-shell-qml
  (package
    (name "dank-material-shell-qml")
    (version %dms-version)
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/AvengeMedia/DankMaterialShell")
             (commit (string-append "v" version))
             (recursive? #t)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0pg0wwi0kw955p9ifx00xs0nlvl5mc1hdy84rgqbal28bd2zyl2k"))))
    (build-system copy-build-system)
    (arguments
     ;; quickshell/DankCommon is a symlink into the dank-qml-common submodule,
     ;; so both directories have to be installed side by side.
     (list #:install-plan
           #~'(("quickshell" "share/dms/quickshell")
               ("dank-qml-common" "share/dms/dank-qml-common"))))
    (propagated-inputs
     (list quickshell qtwayland))
    (home-page "https://github.com/AvengeMedia/DankMaterialShell")
    (synopsis "Quickshell-based desktop shell for Wayland compositors")
    (description
     "This package provides the QML part of DankMaterialShell, a desktop
suite for Wayland compositors such as niri, Hyprland and Sway.  Run it with
@code{dms run -c @var{prefix}/share/dms/quickshell}.")
    (license license:expat)))
