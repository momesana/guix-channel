(define-module (momesana packages niri)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module ((gnu packages window-management) #:prefix upstream:))

;; Guix's niri with one patch: when focus-column-left/right or
;; move-column-left/right can't go further, the view stretches past the first
;; or last column, stays stretched while the key is held, and bounces back on
;; release.  The new `column-edge-bounce` animation configures the bounce back
;; (`off` disables it).  Not upstream yet.
(define-public niri
  (package
    (inherit upstream:niri)
    (source
     (origin
       (inherit (package-source upstream:niri))
       (patches (list (local-file "niri-column-edge-bounce.patch")))))))
