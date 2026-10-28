(define-module (momesana packages host)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module ((gnu packages freedesktop) #:prefix upstream:)
  #:use-module ((gnu packages linux) #:prefix upstream:)
  #:use-module ((gnu packages polkit) #:prefix upstream:)
  #:use-module ((gnu packages window-management) #:prefix upstream:)
  #:use-module ((momesana packages dms) #:select (dank-material-shell-qml))
  #:export (with-host-integration))

;;; Make Guix's authentication stack work on a foreign distribution whose init
;;; system is systemd, without changing anything on Guix System.
;;;
;;; Three assumptions in the Guix packages only hold on Guix System:
;;;
;;;   1. polkit's session tracking goes through elogind, whose
;;;      sd_pid_get_session() reads elogind's own flat "/SESSION" cgroup
;;;      hierarchy.  Under systemd-logind, sessions live in
;;;      "/user.slice/user-UID.slice/session-ID.scope", so elogind answers
;;;      "user.slice" and polkitd rejects the agent with "Passed session and
;;;      the session the caller is in differs".
;;;
;;;   2. The polkit agent authenticates by executing the setuid helper in
;;;      /run/setuid-programs, which only Guix System installs.
;;;
;;;   3. pam_unix, when not running as root, checks passwords by executing
;;;      the setuid helper /run/privileged/bin/unix_chkpwd, which again only
;;;      Guix System installs.  Without it every password is rejected, e.g.
;;;      by a screen locker.
;;;
;;; All fixes are no-ops on Guix System: the session lookup keeps its flat
;;; parsing as a fallback, and both helpers are still executed from their
;;; Guix System locations whenever those exist.

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

;; On a foreign distribution the host's unix_chkpwd is setuid or setgid, and it
;; speaks the same argv/stdin protocol, since it comes from linux-pam as well.
(define %host-unix-chkpwd-helpers
  '("/usr/sbin/unix_chkpwd" "/sbin/unix_chkpwd"))

(define linux-pam/host
  ;; Name and version are unchanged so this can serve as a graft.
  (package
    (inherit upstream:linux-pam)
    (arguments
     (substitute-keyword-arguments (package-arguments upstream:linux-pam)
       ((#:phases phases #~%standard-phases)
        #~(modify-phases #$phases
            (add-after 'unpack 'fall-back-to-host-unix-chkpwd
              (lambda _
                ;; execve() only returns on failure, so each further call
                ;; is reached only when the previous helper is missing.
                (substitute* '("modules/pam_unix/support.c"
                               "modules/pam_unix/pam_unix_acct.c")
                  (("execve\\(CHKPWD_HELPER, (.*)\\);" all rest)
                   (string-append
                    all
                    (apply string-append
                           (map (lambda (helper)
                                  (string-append
                                   "\n\targs[0] = \"" helper "\";"
                                   "\n\texecve(args[0], " rest ");"))
                                '#$%host-unix-chkpwd-helpers)))))))))))))

;; Registering these as replacements rather than as inputs keeps the
;; derivations of all dependents untouched: applying the variants to a package
;; costs a handful of grafts instead of rebuilding Qt, GTK+ and friends.
(define elogind/grafted
  (package (inherit upstream:elogind) (replacement elogind/host)))

(define polkit/grafted
  (package (inherit upstream:polkit) (replacement polkit/host)))

(define linux-pam/grafted
  (package (inherit upstream:linux-pam) (replacement linux-pam/host)))

(define with-host-integration
  ;; Rewrite PKG so that it talks to the host's logind, polkit helper and
  ;; unix_chkpwd.
  (package-input-rewriting/spec
   `(("elogind" . ,(const elogind/grafted))
     ("polkit" . ,(const polkit/grafted))
     ("linux-pam" . ,(const linux-pam/grafted)))))

(define-public quickshell-host
  ;; Note: dank-material-shell-qml propagates quickshell, so installing this
  ;; one next to it makes both land in the profile and collide over
  ;; bin/quickshell.  With Dux Shell (DankMaterialShell), use
  ;; dank-material-shell-qml-host below instead.
  (package
    (inherit (with-host-integration upstream:quickshell))
    (name "quickshell-host")))

(define-public dank-material-shell-qml-host
  ;; The quickshell this propagates keeps its name and derivation and is merely
  ;; grafted, so only this package itself is rebuilt.  Install it instead of
  ;; dank-material-shell-qml, and drop any separate quickshell entry from the
  ;; profile: two differing quickshells would collide over bin/quickshell.
  (package
    (inherit (with-host-integration dank-material-shell-qml))
    (name "dank-material-shell-qml-host")))
