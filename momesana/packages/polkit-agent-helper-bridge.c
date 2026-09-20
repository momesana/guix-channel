/* Locate and run the privileged polkit agent helper, whichever form the host
   system provides.

   polkit's agent library authenticates the user by executing a helper that
   runs as root; Guix's polkit is built to execute the setuid helper that Guix
   System installs in /run/setuid-programs.  That file does not exist on a
   foreign distribution, and distributions shipping polkit >= 126 (Debian,
   Ubuntu, Fedora, ...) no longer install a setuid helper at all: theirs is
   socket-activated and reached through /run/polkit/agent-helper.socket.

   This program is executed by the agent in place of the helper and picks
   whatever the host offers:

     - Guix System: execute the setuid helper as before, so behaviour there is
       unchanged.
     - Host with a socket-activated helper: connect to the socket and pass the
       conversation through.  Both helpers speak the same line protocol; the
       socket one only wants the user name as its first line instead of in
       argv, and takes the caller's credentials from the connected socket
       rather than from getuid().  No setuid bit is needed here - the
       privileged half stays on the host side of the socket.  */

#include <errno.h>
#include <poll.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

#define SETUID_HELPER "/run/setuid-programs/polkit-agent-helper-1"
#define HELPER_SOCKET "/run/polkit/agent-helper.socket"

static int write_all(int fd, const char *buf, size_t len) {
        while (len > 0) {
                ssize_t n = write(fd, buf, len);
                if (n < 0) {
                        if (errno == EINTR)
                                continue;
                        return -1;
                }
                buf += n;
                len -= n;
        }
        return 0;
}

static int bridge_to_socket(const char *program, const char *user) {
        struct sockaddr_un addr = { .sun_family = AF_UNIX };
        struct pollfd fds[2];
        int sock, stdin_open = 1;

        sock = socket(AF_UNIX, SOCK_STREAM, 0);
        if (sock < 0) {
                fprintf(stderr, "%s: socket: %s\n", program, strerror(errno));
                return 1;
        }

        strncpy(addr.sun_path, HELPER_SOCKET, sizeof addr.sun_path - 1);
        if (connect(sock, (struct sockaddr *) &addr, sizeof addr) < 0) {
                fprintf(stderr, "%s: cannot connect to %s: %s\n",
                        program, HELPER_SOCKET, strerror(errno));
                return 1;
        }

        /* The socket helper expects the user name as its first line. */
        if (write_all(sock, user, strlen(user)) < 0
            || write_all(sock, "\n", 1) < 0) {
                fprintf(stderr, "%s: write: %s\n", program, strerror(errno));
                return 1;
        }

        fds[0].fd = STDIN_FILENO;
        fds[1].fd = sock;

        for (;;) {
                char buf[4096];
                ssize_t n;

                fds[0].events = stdin_open ? POLLIN : 0;
                fds[1].events = POLLIN;

                if (poll(fds, 2, -1) < 0) {
                        if (errno == EINTR)
                                continue;
                        fprintf(stderr, "%s: poll: %s\n", program, strerror(errno));
                        return 1;
                }

                if (stdin_open && (fds[0].revents & (POLLIN | POLLHUP))) {
                        n = read(STDIN_FILENO, buf, sizeof buf);
                        if (n > 0) {
                                if (write_all(sock, buf, n) < 0)
                                        return 1;
                        } else if (n == 0 || errno != EINTR) {
                                stdin_open = 0;
                                shutdown(sock, SHUT_WR);
                        }
                }

                if (fds[1].revents & (POLLIN | POLLHUP)) {
                        n = read(sock, buf, sizeof buf);
                        if (n > 0) {
                                if (write_all(STDOUT_FILENO, buf, n) < 0)
                                        return 1;
                        } else if (n == 0) {
                                return 0;
                        } else if (errno != EINTR) {
                                fprintf(stderr, "%s: read: %s\n", program, strerror(errno));
                                return 1;
                        }
                }
        }
}

int main(int argc, char **argv) {
        if (argc != 2) {
                fprintf(stderr, "%s: wrong number of arguments\n", argv[0]);
                return 1;
        }

        if (access(SETUID_HELPER, X_OK) == 0) {
                execv(SETUID_HELPER, argv);
                fprintf(stderr, "%s: cannot execute %s: %s\n",
                        argv[0], SETUID_HELPER, strerror(errno));
                return 1;
        }

        return bridge_to_socket(argv[0], argv[1]);
}
