# momesana guix channel

Personal Guix channel, module namespace `(momesana ...)`.

    guix build -L ~/repos/guix/channel PACKAGE     # without pulling

or in `~/.config/guix/channels.scm`:

    (cons (channel
            (name 'momesana)
            (url "ssh://git@git.momesana.io/momesana/guix-channel.git"))
          %default-channels)

## `(momesana packages dms)`

DankMaterialShell: the `dms` Go CLI and `dank-material-shell-qml`, the QML part
installed under `share/dms/quickshell`.

## `(momesana packages brave)`

`brave`, the Brave browser, repackaged from Brave's official `.deb` with
nonguix's `chromium-binary-build-system`, like nonguix's
`google-chrome-stable`. The channel therefore depends on nonguix
(`.guix-channel`).

Brave publishes a stable release about every five days. To update:

    etc/update-brave            # update brave.scm and build it
    etc/update-brave --commit   # ... and commit the update (signed)

It takes the newest version from Brave's stable apt repository and checks
the chain from Brave's signing keys (pinned by fingerprint in the script)
through the signed `InRelease` and the package index to the `.deb`. If
Brave's keyring changes, it stops: check the new key, then update the
fingerprints. After committing, `guix pull` and reconfigure as usual.

## `(momesana packages fluxcd)`

`fluxcd`, the `flux` command-line tool for Flux (Kubernetes GitOps). It
installs the statically linked release binary, which runs unmodified on
Guix System; building from source would mean packaging several hundred
Go modules. Named `fluxcd` because Guix already has an unrelated `flux`.

## `(momesana packages resvg)`

`resvg`, the SVG renderer's command-line tool; yazi uses it for SVG previews.
Guix ships resvg's crate source, but no package for the tool.

## `(momesana packages solaar)`

`solaar` with a working wrapper. Since PR #9262 (commit 6605d4dc5f) Guix's
package replaces the standard `wrap` phase with one that only sets
`GI_TYPELIB_PATH`, so `solaar` only finds its Python modules when Python
itself is in the same profile. This variant keeps the standard phase and
sets `GI_TYPELIB_PATH` after it, and adds libnotify so notifications work
(its two notification test files need a display and are skipped). It has
the same name and version as Guix's, so refer to the package object rather
than a specification.

## `(momesana packages amtterm)`

`amtterm`, the Intel AMT serial-over-LAN client, with `amtider` (IDE
redirection) and `amttool` (SOAP-based power control, which only older AMT
firmware speaks). Upstream publishes 1.8 only as a git tag, so the source
comes from GitHub rather than kraxel.org's tarballs. In 1.8, `-P` (no TLS)
fails right after connecting, with an empty error: since upstream commit
d0d9ed5 nothing creates the connection context unless TLS is used.
`amtterm-plain-connection.patch` is upstream merge request !3
(https://gitlab.com/kraxel/amtterm/-/merge_requests/3), which creates a
plain one; drop it once that is merged. The GTK frontend `gamt`
is not built; adding `gtk+` and `vte` to the inputs enables it.

    AMT_PASSWORD=... amtterm HOST            # TLS, port 16995
    AMT_PASSWORD=... amtterm -P HOST         # plain text, port 16994
    AMT_PASSWORD=... amtterm -C ca.pem HOST  # TLS, verifying the certificate

Without `-C`, amtterm accepts any certificate.

## `(momesana packages rust-crates)`

Crate sources for this channel's Rust packages, looked up with
`(cargo-inputs 'NAME #:module '(momesana packages rust-crates))`. Guix's
`(gnu packages rust-crates)` does not export its definitions, so they are
regenerated here from the package's `Cargo.lock`:

    guix import crate --lockfile=Cargo.lock NAME

## `(momesana packages host)`

Makes Guix's authentication stack -- the polkit **agent** and `pam_unix` --
work when Guix runs on a foreign distribution whose init system is systemd.
Nothing here is specific to such a host: all fixes fall back to the Guix System behaviour at run time, so the
same packages are correct on Guix System.

Three assumptions in the upstream packages only hold on Guix System:

1. **Session lookup.** polkit tracks sessions through elogind, whose
   `sd_pid_get_session()` expects elogind's flat `/SESSION` cgroup hierarchy.
   Under systemd-logind sessions live in
   `/user.slice/user-UID.slice/session-ID.scope`, so elogind answers
   `user.slice` and polkitd refuses to register the agent:

       GDBus.Error:org.freedesktop.PolicyKit1.Error.Failed: Passed session and
       the session the caller is in differs. They must be equal for now.

   `elogind-session-on-systemd-hosts.patch` teaches `cg_path_get_session()` to
   recognise a `session-ID.scope` component, keeps the flat parsing as a
   fallback, and validates the result with `session_id_valid()`, so a process
   in no session now gets `-ENXIO` instead of `user.slice` -- the same answer
   libsystemd gives, on either kind of host.

2. **The polkit helper.** The agent authenticates by executing a helper
   that runs as root. Guix builds polkit to execute
   `/run/setuid-programs/polkit-agent-helper-1`, which only Guix System
   installs; distributions shipping polkit >= 126 ship no setuid helper at all
   and socket-activate theirs on `/run/polkit/agent-helper.socket`.

   `polkit-agent-helper-bridge.c` is executed in its place. It executes the
   setuid helper when that exists (Guix System: unchanged), and otherwise
   connects to the host's socket and passes the conversation through. Both
   helpers speak the same line protocol; the socket one reads the user name as
   its first line instead of taking it in `argv`, and derives the caller's
   credentials from the connected socket rather than from `getuid()`. So the
   bridge needs no setuid bit and no root: the privileged half stays on the
   host side of the socket.

3. **The password helper.** When not running as root, `pam_unix` checks a
   password by executing a setuid helper, since only root may read
   `/etc/shadow`. Guix builds it to execute
   `/run/privileged/bin/unix_chkpwd`, which only Guix System installs, so on
   a foreign distribution every password is rejected -- by DMS's lock screen,
   for instance:

       pam_unix(dankshell:auth): authentication failure; ... user=USER

   The `linux-pam` variant keeps that path first and falls back to the host's
   own helper, `/usr/sbin/unix_chkpwd` or `/sbin/unix_chkpwd` (setgid `shadow`
   on Debian and Ubuntu). Both come from linux-pam and speak the same
   argv/stdin protocol, and the host's helper handles whatever hash scheme the
   host's `/etc/shadow` uses.

### Exports

- `with-host-integration` -- rewrites a package to use all three variants. They are
  attached as *replacements* (grafts), so this costs a few dozen reference
  rewrites rather than rebuilding Qt, GTK+ and the rest.

      (use-modules (momesana packages host))
      (with-host-integration some-package)

- `dank-material-shell-qml-host` -- the QML package with the above applied,
  so the quickshell it propagates carries the fixed polkit and PAM.
- `quickshell-host` -- plain quickshell with the above applied, for a
  setup without DankMaterialShell.

The `elogind`, `polkit` and `linux-pam` variants themselves are private, so the channel does
not shadow the upstream packages of those names.

### Installing on a systemd host

Exactly one quickshell may be in the profile, otherwise the two differing
store items collide over `bin/quickshell`:

    guix package -L ~/repos/guix/channel \
      -r quickshell -r dank-material-shell-qml \
      -r dank-material-shell-qml-host-polkit \
      -i dank-material-shell-qml-host

Then restart the shell, check that an agent registers, and lock and unlock
the screen once:

    pkill -f 'dms run'
    niri msg action spawn -- dms run -c ~/.guix-profile/share/dms/quickshell
    pkexec true          # must show DMS's auth dialog
    dms ipc -c ~/.guix-profile/share/dms/quickshell call lock lock
