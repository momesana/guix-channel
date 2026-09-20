(define-module (momesana packages polkit)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module ((gnu packages freedesktop) #:prefix upstream:)
  #:use-module ((gnu packages polkit) #:prefix upstream:)
  #:use-module ((gnu packages window-management) #:prefix upstream:)
  #:use-module ((momesana packages dms) #:select (dank-material-shell-qml))
  #:export (with-host-polkit))

;;; Make Guix's polkit agent stack work on a foreign distribution whose init
;;; system is systemd, without changing anything on Guix System.
;;;
;;; Two assumptions in the Guix packages only hold on Guix System:
;;;
;;;   1. polkit's session tracking goes through elogind, whose
;;;      sd_pid_get_session() reads elogind's own flat "/SESSION" cgroup
;;;      hierarchy.  Under systemd-logind, sessions live in
;;;      "/user.slice/user-UID.slice/session-ID.scope", so elogind answers
;;;      "user.slice" and polkitd rejects the agent with "Passed session and
;;;      the session the caller is in differs".
;;;
;;;   2. The agent authenticates by executing the setuid helper in
;;;      /run/setuid-programs, which only Guix System installs.
;;;
;;; Both fixes are no-ops on Guix System: the session lookup keeps its flat
;;; parsing as a fallback, and the helper bridge simply executes the setuid
;;; helper when it exists.

(define elogind/host
  ;; Name and version are unchanged so this can serve as a graft.
  (package
    (inherit upstream:elogind)
    (source
     (origin
       (inherit (package-source upstream:elogind))
       (patches
        (append (origin-patches (package-source upstream:elogind))
                (list (local-file "elogind-session-on-systemd-hosts.patch"))))))))

(define polkit/host
  (package
    (inherit upstream:polkit)
    (inputs (modify-inputs (package-inputs upstream:polkit)
              (replace "elogind" elogind/host)))
    (arguments
     (substitute-keyword-arguments (package-arguments upstream:polkit)
       ((#:phases phases)
        #~(modify-phases #$phases
            (add-after 'unpack 'use-agent-helper-bridge
              (lambda _
                (substitute* "src/polkitagent/polkitagentsession.c"
                  (("\"/run/setuid-programs/polkit-agent-helper-1\"")
                   (string-append "\"" #$output
                                  "/libexec/polkit-agent-helper-bridge\"")))))
            (add-after 'install 'install-agent-helper-bridge
              (lambda _
                (let ((libexec (string-append #$output "/libexec")))
                  (mkdir-p libexec)
                  (invoke "gcc" "-O2" "-Wall" "-o"
                          (string-append libexec "/polkit-agent-helper-bridge")
                          #$(local-file "polkit-agent-helper-bridge.c")))))))))))

;; Registering these as replacements rather than as inputs keeps the
;; derivations of all dependents untouched: applying the variants to a package
;; costs a handful of grafts instead of rebuilding Qt, GTK+ and friends.
(define elogind/grafted
  (package (inherit upstream:elogind) (replacement elogind/host)))

(define polkit/grafted
  (package (inherit upstream:polkit) (replacement polkit/host)))

(define with-host-polkit
  ;; Rewrite PKG so that it talks to the host's logind and polkit helper.
  (package-input-rewriting/spec
   `(("elogind" . ,(const elogind/grafted))
     ("polkit" . ,(const polkit/grafted)))))

(define-public quickshell-host-polkit
  ;; Note: dms propagates quickshell, so installing this one next to dms makes
  ;; both land in the profile and collide over bin/quickshell.  With dms, use
  ;; dms-host-polkit below instead.
  (package
    (inherit (with-host-polkit upstream:quickshell))
    (name "quickshell-host-polkit")))

(define-public dank-material-shell-qml-host-polkit
  ;; The quickshell this propagates keeps its name and derivation and is merely
  ;; grafted, so only this package itself is rebuilt.  Install it instead of
  ;; dank-material-shell-qml, and drop any separate quickshell entry from the
  ;; profile: two differing quickshells would collide over bin/quickshell.
  (package
    (inherit (with-host-polkit dank-material-shell-qml))
    (name "dank-material-shell-qml-host-polkit")))
