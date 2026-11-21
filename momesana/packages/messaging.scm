(define-module (momesana packages messaging)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:use-module ((nongnu packages messaging) #:prefix nongnu:))

;; Newer releases of nonguix's packages, which lag behind upstream.  Once
;; nonguix catches up, its higher version wins and these can go.  SHA-256s
;; are listed in each project's apt Packages file:
;; https://updates.signal.org/desktop/apt/dists/xenial/main/binary-amd64/Packages
;; https://packages.element.io/debian/dists/default/main/binary-amd64/Packages

(define-public signal-desktop
  (package
    (inherit nongnu:signal-desktop)
    (version "8.36.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://updates.signal.org/desktop/apt/pool/s/"
                           "signal-desktop/signal-desktop_" version
                           "_amd64.deb"))
       (sha256
        (base32 "052aka2vbf39xryd3xhsr6g58xqwzznas7wfqvxp09w7skh1yf25"))))))

(define-public element-desktop
  (package
    (inherit nongnu:element-desktop)
    (version "1.12.35")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://packages.element.io/debian/pool/main/e/"
                           "element-desktop/element-desktop_" version
                           "_amd64.deb"))
       (sha256
        (base32 "14nwwrg1xdfagx4m6rg0k6l89i1sm1zrj5a8y2ixga6ws5i6azqm"))))))
