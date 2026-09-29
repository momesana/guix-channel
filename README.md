# momesana guix channel

Personal Guix channel, module namespace `(momesana ...)`.

    guix build -L ~/repos/guix-channel PACKAGE     # without pulling

or in `~/.config/guix/channels.scm`:

    (cons (channel
            (name 'momesana)
            (url "ssh://git@git.momesana.io/momesana/guix-channel.git"))
          %default-channels)

## `(momesana packages dms)`

DankMaterialShell: the `dms` Go CLI and `dank-material-shell-qml`, the QML part
installed under `share/dms/quickshell`.

## `(momesana packages resvg)`

`resvg`, the SVG renderer's command-line tool; yazi uses it for SVG previews.
Guix ships resvg's crate source, but no package for the tool.

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

    guix package -L ~/repos/guix-channel \
      -r quickshell -r dank-material-shell-qml \
      -r dank-material-shell-qml-host-polkit \
      -i dank-material-shell-qml-host

Then restart the shell, check that an agent registers, and lock and unlock
the screen once:

    pkill -f 'dms run'
    niri msg action spawn -- dms run -c ~/.guix-profile/share/dms/quickshell
    pkexec true          # must show DMS's auth dialog
    dms ipc -c ~/.guix-profile/share/dms/quickshell call lock lock
