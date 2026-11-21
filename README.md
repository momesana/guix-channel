# momesana Guix channel

A [Guix](https://guix.gnu.org) channel with packages that Guix lacks, or has
only in an older or broken version. It depends on
[nonguix](https://gitlab.com/nonguix/nonguix): `brave` uses its
`chromium-binary-build-system`, and the `messaging` packages inherit its
package definitions. `guix pull` fetches nonguix along with this channel.

The packages are built and used on `x86_64-linux`. Those installing an
upstream release binary support only that system.

## Using the channel

Add the channel to `~/.config/guix/channels.scm`:

    (cons (channel
            (name 'momesana)
            (url "https://github.com/momesana/guix-channel")
            (introduction
             (make-channel-introduction
              "72402bb9e8847025928d513238d647eaecd60255"
              (openpgp-fingerprint
               "1338 3E41 986B 07C8 402A  62D2 9FE9 38BB FAA0 4E94"))))
          %default-channels)

and run `guix pull`. The introduction lets Guix check that every commit it
pulls is signed by an authorized key (see `.guix-authorizations`).

To build a package from a checkout without pulling, run this in the
checkout's top directory:

    guix build -L . PACKAGE

## Packages

<!-- package table: begin -->
| Package | Version | License | Description | Upstream |
| ------- | ------- | ------- | ----------- | -------- |
| [amtterm](#amtterm) | 1.8 | GPL 2+ | Serial-over-LAN and IDE redirection client for Intel AMT | [kraxel/amtterm](https://github.com/kraxel/amtterm) |
| [brave](#brave) | 1.100.58 | MPL 2.0 | Chromium-based web browser with built-in ad and tracker blocking | [brave.com](https://brave.com/) |
| [cilium-cli](#kubernetes) | 0.20.2 | ASL 2.0 | Command-line tool for Cilium | [cilium/cilium-cli](https://github.com/cilium/cilium-cli) |
| [dank-material-shell-qml](#dms) | 2.1.2 | Expat | Quickshell-based desktop shell for Wayland compositors | [duxlabs-dev/dux-shell](https://github.com/duxlabs-dev/dux-shell) |
| [dank-material-shell-qml-host](#host) | 2.1.2 | Expat | Quickshell-based desktop shell for Wayland compositors | [duxlabs-dev/dux-shell](https://github.com/duxlabs-dev/dux-shell) |
| [dms](#dms) | 2.1.2 | Expat | Command-line backend for Dux Shell | [duxlabs-dev/dux-shell](https://github.com/duxlabs-dev/dux-shell) |
| [dux-files](#dms) | 2.1.2 | Expat | File manager for the Dux desktop | [duxlabs-dev/dux-files](https://github.com/duxlabs-dev/dux-files) |
| [element-desktop](#messaging) | 1.12.35 | ASL 2.0 | Matrix collaboration client for desktop | [element.io](https://element.io/) |
| [fluxcd](#fluxcd) | 2.10.0 | ASL 2.0 | Command-line tool for Flux, the GitOps toolkit for Kubernetes | [fluxcd.io](https://fluxcd.io) |
| [k9s](#kubernetes) | 0.51.0 | ASL 2.0 | Terminal user interface for Kubernetes clusters | [k9scli.io](https://k9scli.io) |
| [kubectl](#kubernetes) | 1.36.6 | ASL 2.0 | Command-line tool for Kubernetes | [kubernetes.io](https://kubernetes.io) |
| [kubernetes-helm](#kubernetes) | 4.3.2 | ASL 2.0 | Package manager for Kubernetes | [helm.sh](https://helm.sh) |
| [quickshell-host](#host) | 0.3.2 | LGPL 3 | QtQuick-based desktop shell toolkit | [quickshell.outfoxxed.me](https://quickshell.outfoxxed.me) |
| [signal-desktop](#messaging) | 8.36.0 | AGPL 3 | Private messenger using the Signal protocol | [signal.org](https://signal.org/) |
| [solaar](#solaar) | 1.1.20 | GPL 2 | Linux devices manager for the Logitech Unifying Receiver | [pwr-solaar.github.io](https://pwr-solaar.github.io/Solaar/) |
| [talhelper](#talos) | 3.1.17 | Modified BSD | Generate Talos Linux machine configurations | [budimanjojo.github.io](https://budimanjojo.github.io/talhelper/) |
| [talosctl](#talos) | 1.14.5 | MPL 2.0 | Command-line tool for Talos Linux | [talos.dev](https://www.talos.dev) |
| [telegram-desktop](#telegram) | 7.4.5 | LGPL 3, GPL 3+ | Telegram Desktop | [desktop.telegram.org](https://desktop.telegram.org/) |
<!-- package table: end -->

Libraries are left out; `etc/update-readme` regenerates the table, and
`etc/git-hooks/pre-commit` refuses commits that leave it out of date:

    ln -s ../../etc/git-hooks/pre-commit .git/hooks/pre-commit

`etc/check-updates` lists the packages with a newer upstream release
(`--all` lists every package). Like npm-check-updates, it colours the new
version red for a major release (or a minor one below 1.0), cyan for a
minor and green for a patch release. kubectl stays on its minor version.
It also shows the Guix and nonguix versions, in bold once they are as new
as ours.

Each module `(momesana packages NAME)` is the file
`momesana/packages/NAME.scm`. The sections below are named after them.

## [dms](momesana/packages/dms.scm)

Dux Shell (formerly DankMaterialShell): the `dms` Go CLI and
`dank-material-shell-qml`, the QML part installed under
`share/dms/quickshell`. Also `dux-files`, the Dux Files file manager. The
Go libraries they need beyond Guix's are in
[golang](momesana/packages/golang.scm).

## [brave](momesana/packages/brave.scm)

`brave`, the Brave browser, repackaged from Brave's official `.deb` with
nonguix's `chromium-binary-build-system`, like nonguix's
`google-chrome-stable`.

Brave publishes a stable release about every five days. To update:

    etc/update-brave            # update brave.scm and build it
    etc/update-brave --commit   # ... and commit the update (signed)

It takes the newest version from Brave's stable apt repository and checks
the chain from Brave's signing keys (pinned by fingerprint in the script)
through the signed `InRelease` and the package index to the `.deb`. If
Brave's keyring changes, it stops: check the new key, then update the
fingerprints.

## [telegram](momesana/packages/telegram.scm)

`telegram-desktop`, newer than Guix's. This version of Telegram Desktop
links Rust libraries (the tlottie Lottie renderer and the TON wallet core); they
are built as one static library, `tdesktop-rust`, like upstream's Linux
build does. Their crate sources are in
[rust-crates](momesana/packages/rust-crates.scm).

It uses kimageformats without its RAW plugin. LibRaw recognises some
headerless camera files by their size alone, so the plugin claimed
ordinary images of such a size and Telegram showed them as noise. A
kimageformats in a directory on an inherited `QT_PLUGIN_PATH` still
brings the plugin back.

## [messaging](momesana/packages/messaging.scm)

`signal-desktop` and `element-desktop`, newer than nonguix's. They inherit
nonguix's packages and change only the version and the `.deb`'s hash. Once
nonguix catches up, they can be removed.

## [kubernetes](momesana/packages/kubernetes.scm)

`kubectl`, `kubernetes-helm` (Guix's `helm` is a synthesizer), `k9s` and
`cilium-cli`. kubectl supports API servers only within one minor version of
its own, and Guix's lags behind.

## [talos](momesana/packages/talos.scm)

`talosctl`, the command-line tool for Talos Linux, and `talhelper`, which
generates a Talos cluster's machine configurations.

## [fluxcd](momesana/packages/fluxcd.scm)

`fluxcd`, the `flux` command-line tool for Flux (Kubernetes GitOps). Named
`fluxcd` because Guix already has an unrelated `flux`.

Like the kubernetes and talos packages, it installs the statically linked
upstream release binary, which runs unmodified on Guix System; building
from source would mean packaging several hundred Go modules.

## [solaar](momesana/packages/solaar.scm)

`solaar` with a working wrapper. Since PR #9262 (commit 6605d4dc5f) Guix's
package replaces the standard `wrap` phase with one that only sets
`GI_TYPELIB_PATH`, so `solaar` only finds its Python modules when Python
itself is in the same profile. This variant keeps the standard phase and
sets `GI_TYPELIB_PATH` after it, and adds libnotify so notifications work
(its two notification test files need a display and are skipped). It has
the same name and version as Guix's, so refer to the package object rather
than a specification.

## [amtterm](momesana/packages/amtterm.scm)

`amtterm`, the Intel AMT serial-over-LAN client, with `amtider` (IDE
redirection) and `amttool` (SOAP-based power control, which only older AMT
firmware speaks). Upstream publishes 1.8 only as a git tag, so the source
comes from GitHub rather than kraxel.org's tarballs. The GTK frontend `gamt`
is not built; adding `gtk+` and `vte` to the inputs enables it.

In 1.8, `-P` (no TLS) fails right after connecting, with an empty error:
since upstream commit d0d9ed5 nothing creates the connection context unless
TLS is used. `amtterm-plain-connection.patch` is upstream merge request !3
(https://gitlab.com/kraxel/amtterm/-/merge_requests/3), which creates a
plain one; drop it once that is merged.

When the host changes its serial control lines (Linux's 8250 driver does so
while probing the UART at boot), AMT sends a 10-byte control message, but 1.8
discards its whole receive buffer. SOL output in the same read is lost, and
if a data message was split, amtterm aborts with `redir_data: unknown r->buf
0x..`. `amtterm-sol-controls-length.patch` consumes only the 10 bytes; it is
not upstream yet.

    AMT_PASSWORD=... amtterm HOST            # TLS, port 16995
    AMT_PASSWORD=... amtterm -P HOST         # plain text, port 16994
    AMT_PASSWORD=... amtterm -C ca.pem HOST  # TLS, verifying the certificate

Without `-C`, amtterm accepts any certificate.

## [rust-crates](momesana/packages/rust-crates.scm)

Crate sources for this channel's Rust packages, looked up with
`(cargo-inputs 'NAME #:module '(momesana packages rust-crates))`. Guix's
`(gnu packages rust-crates)` does not export its definitions, so they are
regenerated here from the package's `Cargo.lock`:

    guix import crate --lockfile=Cargo.lock NAME

## [host](momesana/packages/host.scm)

Makes Guix's authentication stack -- the polkit **agent** and `pam_unix` --
work when Guix runs on a foreign distribution whose init system is systemd.
Nothing here is specific to such a host: all fixes fall back to the Guix
System behaviour at run time, so the same packages are correct on Guix
System.

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

- `with-host-integration` -- rewrites a package to use all three variants.
  They are attached as *replacements* (grafts), so this costs a few dozen
  reference rewrites rather than rebuilding Qt, GTK+ and the rest.

      (use-modules (momesana packages host))
      (with-host-integration some-package)

- `dank-material-shell-qml-host` -- the QML package with the above applied,
  so the quickshell it propagates carries the fixed polkit and PAM.
- `quickshell-host` -- plain quickshell with the above applied, for a
  setup without DankMaterialShell.

The `elogind`, `polkit` and `linux-pam` variants themselves are private, so
the channel does not shadow the upstream packages of those names.

### Installing on a systemd host

Exactly one quickshell may be in the profile, otherwise the two differing
store items collide over `bin/quickshell`:

    guix package -r quickshell -r dank-material-shell-qml \
      -i dank-material-shell-qml-host

Then restart the shell, check that an agent registers, and lock and unlock
the screen once:

    pkill -f 'dms run'
    niri msg action spawn -- dms run -c ~/.guix-profile/share/dms/quickshell
    pkexec true          # must show DMS's auth dialog
    dms ipc -c ~/.guix-profile/share/dms/quickshell call lock lock

## Contributing

Issues and pull requests are welcome on GitHub. Pull requests are not
merged through GitHub: `guix pull` accepts only commits signed by a key in
`.guix-authorizations`, so changes are applied and signed by the
maintainer, keeping your authorship.

## License

GPLv3 or later, like Guix; see `LICENSE`. The patches under
`momesana/packages/` keep the licenses of the projects they patch.
