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

## `(momesana packages polkit)`

Makes Guix's polkit **agent** stack work when Guix runs on a foreign
distribution whose init system is systemd. Nothing here is specific to such a
host: both fixes fall back to the Guix System behaviour at run time, so the
same packages are correct on Guix System.

Two assumptions in the upstream packages only hold on Guix System:

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

2. **The privileged helper.** The agent authenticates by executing a helper
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

### Exports

- `with-host-polkit` -- rewrites a package to use both variants. They are
  attached as *replacements* (grafts), so this costs a few dozen reference
  rewrites rather than rebuilding Qt, GTK+ and the rest.

      (use-modules (momesana packages polkit))
      (with-host-polkit some-package)

- `dank-material-shell-qml-host-polkit` -- the QML package with the above
  applied, so the quickshell it propagates carries the fixed polkit.
- `quickshell-host-polkit` -- plain quickshell with the above applied, for a
  setup without DankMaterialShell.

The `elogind` and `polkit` variants themselves are private, so the channel does
not shadow the upstream packages of those names.

### Installing on a systemd host

Exactly one quickshell may be in the profile, otherwise the two differing
store items collide over `bin/quickshell`:

    guix package -L ~/repos/guix-channel \
      -r quickshell -r dank-material-shell-qml \
      -i dank-material-shell-qml-host-polkit

Then restart the shell and check that an agent registers:

    pkill -f 'dms run'
    niri msg action spawn -- dms run -c ~/.guix-profile/share/dms/quickshell
    pkexec true          # must show DMS's auth dialog
