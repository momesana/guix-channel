(define-module (momesana packages brave)
  #:use-module (gnu packages base)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages image)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages pciutils)
  #:use-module (gnu packages photo)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages video)
  #:use-module (gnu packages wget)
  #:use-module (gnu packages xiph)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages freedesktop)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (nonguix build-system chromium-binary))

;; Brave's official .deb, repackaged like nonguix's google-chrome-stable
;; (nongnu/packages/chrome.scm), whose layout it shares. New versions and
;; their SHA-256 are listed in
;; https://brave-browser-apt-release.s3.brave.com/dists/stable/main/binary-amd64/Packages

(define-public brave
  (package
    (name "brave")
    (version "1.97.56")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://brave-browser-apt-release.s3.brave.com/"
                           "pool/main/b/brave-browser/brave-browser_"
                           version "_amd64.deb"))
       (sha256
        (base32 "0sdnjf4xzsh2vdmhr1i2gr8m0qkxl4873ayszkk6f19qvf4wpr1h"))))
    (build-system chromium-binary-build-system)
    (arguments
     (list
      ;; About 150 MB, faster to download from Brave than from a substitute
      ;; server, which would not have it anyway.
      #:substitutable? #f
      #:wrapper-plan
      #~(map (lambda (file)
               (string-append "opt/brave.com/brave/" file))
             '("brave"
               "chrome-sandbox"
               "chrome_crashpad_handler"
               "chrome-management-service"
               "libqt5_shim.so"
               "libqt6_shim.so"
               "libvk_swiftshader.so"
               "libvulkan.so.1"))
      #:install-plan
      #~'(("opt/" "/share")
          ("usr/share/" "/share"))
      #:phases
      #~(modify-phases %standard-phases
          (add-before 'install 'patch-assets
            (lambda _
              (let ((exe (string-append #$output "/bin/brave-browser")))
                ;; Lets the wrapper below set CHROME_WRAPPER.
                (substitute* "opt/brave.com/brave/brave-browser"
                  (("CHROME_WRAPPER") "WRAPPER"))
                (substitute* '("usr/share/applications/brave-browser.desktop"
                               "usr/share/applications/com.brave.Browser.desktop"
                               "usr/share/gnome-control-center/default-apps/brave-browser.xml")
                  (("/usr/bin/brave-browser-stable") exe)))))
          (add-after 'install 'install-icons
            (lambda _
              (let ((icons (string-append #$output "/share/icons/hicolor"))
                    (share (string-append #$output "/share/brave.com/brave")))
                (for-each
                 (lambda (icon)
                   (let* ((size (string-drop-right
                                 (string-drop (basename icon) 13) 4))
                          (target (string-append icons "/" size "x" size
                                                 "/apps/brave-browser.png")))
                     (mkdir-p (dirname target))
                     (rename-file icon target)))
                 (find-files share "^product_logo_[0-9]+\\.png$")))))
          (add-before 'install-wrapper 'install-exe
            (lambda _
              (let ((exe (string-append #$output "/bin/brave-browser")))
                (mkdir-p (dirname exe))
                (symlink (string-append #$output
                                        "/share/brave.com/brave/brave-browser")
                         exe)
                (wrap-program exe
                  '("CHROME_WRAPPER" = ("brave-browser")))))))))
    (inputs
     (list bzip2
           curl
           flac
           font-liberation
           gdk-pixbuf
           gtk
           harfbuzz
           libexif
           libglvnd
           libpng
           libva
           libxscrnsaver
           opus
           pciutils
           pipewire
           qtbase-5
           qtbase
           snappy
           util-linux
           xdg-utils
           wget))
    (supported-systems '("x86_64-linux"))
    (home-page "https://brave.com/")
    (synopsis "Chromium-based web browser with built-in ad and tracker blocking")
    (description
     "Brave is a web browser based on Chromium that blocks ads and trackers
by default.  This package repackages Brave's official Debian package.")
    (license license:mpl2.0)))
