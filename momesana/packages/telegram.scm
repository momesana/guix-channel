(define-module (momesana packages telegram)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module (guix build-system cargo)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages security-token)
  #:use-module ((gnu packages telegram) #:prefix upstream:)
  #:use-module (ice-9 match)
  #:export (telegram-desktop))

(define %telegram-version "7.2.9")

(define* (telegram-origin name url commit hash #:key (patches '()))
  (origin
    (method git-fetch)
    (uri (git-reference (url url) (commit commit)))
    (file-name (git-file-name (string-append name "-for-telegram-desktop")
                              %telegram-version))
    (patches patches)
    (sha256 (base32 hash))))

(define %telegram-submodules
  `(("cmake"
     ,(telegram-origin
       "cmake-helpers" "https://github.com/desktop-app/cmake_helpers.git"
       "5e21e7ac353138128145ec4419c0666dc9959347"
       "1s7vam6cg8fs7cx4p9xqcl4sgxjb19sb8m0sjy6xmn28rxzd5dxf"
       #:patches (search-patches "telegram-desktop-unbundle-cppgir.patch")))
    ("Telegram/codegen"
     ,(telegram-origin
       "codegen" "https://github.com/desktop-app/codegen.git"
       "5146c1703837b39e2d639340dc70db5d674c69f0"
       "11aw8hjj8s1b2sjj5swzak2p1p1khd8zi29c9dn9rqdr813raamp"))
    ("Telegram/lib_base"
     ,(telegram-origin
       "lib-base" "https://github.com/desktop-app/lib_base.git"
       "de35c7abcbf6464a0845695a55568bdac12a5fba"
       "0k2ca3im88h8b096rfnrqvp6irsr2556m1v6cfvx5nv139r496vi"))
    ("Telegram/lib_crl"
     ,(telegram-origin
       "lib-crl" "https://github.com/desktop-app/lib_crl.git"
       "7a165302fed408c84b2d1c2513e35a21a141da44"
       "1lxain8npmsjc4milid8862j19pn1rzvic2aj09aq4xdf5i7yhjn"))
    ("Telegram/lib_lottie"
     ,(telegram-origin
       "lib-lottie" "https://github.com/desktop-app/lib_lottie.git"
       "7d00b5048aff8dd93c0a9721abf50006d20682be"
       "1998203f73n1sy0g9zij2qcspj9c784apgwnm9xfg6kwb744drjy"))
    ("Telegram/lib_qr"
     ,(telegram-origin
       "lib-qr" "https://github.com/desktop-app/lib_qr.git"
       "6fdf60461444ba150e13ac36009c0ffce72c4c83"
       "1i5n3qvjkf4nv8k75cc0a71xyvpklc4nzg4k2zsfr2pxk0cy7hkw"))
    ("Telegram/lib_rpl"
     ,(telegram-origin
       "lib-rpl" "https://github.com/desktop-app/lib_rpl.git"
       "c57cccffb01d85570decd7fccb88419c9a682e63"
       "0s9sza56fsrcd366ii6isc3w27ii2n9k48drn2q4vrq4jy1hy9ln"))
    ("Telegram/lib_spellcheck"
     ,(telegram-origin
       "lib-spellcheck" "https://github.com/desktop-app/lib_spellcheck.git"
       "3273fd25c185fb626a9836dafbd644c2bd129ee1"
       "10xbyl4hs4zbifmvf5xnafr9nrdg6rl866m76c0f855xpr1gs0vy"))
    ("Telegram/lib_storage"
     ,(telegram-origin
       "lib-storage" "https://github.com/desktop-app/lib_storage.git"
       "ccdc72548a5065b5991b4e06e610d76bc4f6023e"
       "0b11ix95dzpkz335q0a6b5yg8qhj33s4fgj9ppl37pszcqq1j3wi"))
    ("Telegram/lib_tl"
     ,(telegram-origin
       "lib-tl" "https://github.com/desktop-app/lib_tl.git"
       "29746d31247c915a9ec870241399a9d103c39f87"
       "0hzxg53hcff0xbckxnxwpsh2qdlwm3gj1gm1i6wbz9ac3pavk64y"
       #:patches (search-patches "lib-tl-for-telegram-memcpy.patch")))
    ("Telegram/lib_translate"
     ,(telegram-origin
       "lib-translate" "https://github.com/desktop-app/lib_translate"
       "09c10726220e6862ca91d39b5dec5119aa0177bc"
       "05z9bz2gcc952afr19q9z00hnrdx1j3ww7bddazpb2f4b86xi5yc"))
    ("Telegram/lib_ui"
     ,(telegram-origin
       "lib-ui" "https://github.com/desktop-app/lib_ui.git"
       "ae492d4015ce35daf697053776c79786ea7d9282"
       "125xv4q4cf0y7k11g2vp9k65vx4p98qgdm1hv65qa7831f1kriaw"
       #:patches (list (local-file "lib-ui-qt-6.9-compat.patch"))))
    ("Telegram/lib_webrtc"
     ,(telegram-origin
       "lib-webrtc" "https://github.com/desktop-app/lib_webrtc.git"
       "52636e86eaa493de670daf71959d000b281bd153"
       "1y50q6b33r506qn4pw0sn6cmxhwjcxdb79qrw7laz45l1iw1zhm0"))
    ("Telegram/lib_webview"
     ,(telegram-origin
       "lib-webview" "https://github.com/desktop-app/lib_webview.git"
       "596fb2432b7c479e9499f8ede64fe6775e65ae91"
       "0d9skxyqxss0nk9d0d2yzxlf59qq84a5827pxk3svqq5a9rwn99a"))
    ("Telegram/ThirdParty/cld3"
     ,(telegram-origin
       "cld3" "https://github.com/google/cld3.git"
       "b48dc46512566f5a2d41118c8c1116c4f96dc661"
       "0ayrrhfdwrf4260h9fsirkhhfrcvc3qqnh6h9wj3ixij2lq0wwqb"))
    ("Telegram/ThirdParty/cmark-gfm"
     ,(telegram-origin
       "cmark-gfm" "https://github.com/desktop-app/cmark-gfm.git"
       "d7d4a24a9ebfa7581994ea6df0297662bfeaf413"
       "1xil7lq50qvz623r8v3d92iggb871j9wsc3s7z6v4x7nrn3x8mg0"))
    ("Telegram/ThirdParty/libprisma"
     ,(telegram-origin
       "libprisma" "https://github.com/desktop-app/libprisma"
       "23b0d70f9709da9b38561d5706891a134d18df76"
       "0fg4x4ikj7f3706bmfvkwq4smxc98qr3cgpm25w48n4ys6wfgadg"))
    ("Telegram/ThirdParty/MicroTeX"
     ,(telegram-origin
       "microtex" "https://github.com/desktop-app/MicroTeX.git"
       "61aaa7cc354de91d5898ffb0b2a6c62628d9a76f"
       "1isplcrdwyadlgz251817096y793cnmqms3ial36hvbigjq60qf4"))
    ("Telegram/ThirdParty/tgcalls"
     ,(telegram-origin
       "tgcalls" "https://github.com/TelegramMessenger/tgcalls.git"
       "2faee3b5524f54d56c91c2058c00e11c656a74b3"
       "0azwkwj1l91qrv41nn2ik3h1q4j849dki43xwzmqdfdwjbqgcv7v"))
    ("Telegram/ThirdParty/TooManyCooks"
     ,(telegram-origin
       "toomanycooks" "https://github.com/tzcnt/TooManyCooks.git"
       "b86af81982860c96295a7e95e4c60cb335615cef"
       "1lpmddx0plhl2g3h86lbv184iaf38gsyjkd1bczv7q9xq4fclppr"))))

(define tlottie
  (let ((commit "31f1b542f88e7b4be9a01e749920d857535fc715")
        (revision "0"))
    (package
      (name "tlottie")
      (version (git-version "0.1.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/dkaraush/tlottie.git")
               (commit commit)))
         (file-name (git-file-name name version))
         (patches (list (local-file "tlottie-rlottie-compat.patch")))
         (sha256
          (base32 "0v3vj6ifgssipcackpajy7p80mscp1c7pa86hcnphkfqaz8l3i16"))))
      (build-system cargo-build-system)
      (arguments
       (list
        #:install-source? #f
        #:phases
        #~(modify-phases %standard-phases
            (add-after 'unpack 'drop-no-std-dependencies
              (lambda _
                (substitute* "Cargo.toml"
                  (("^no-std = .*") "")
                  (("^hashbrown = .*") "")
                  (("^dlmalloc = .*") ""))))
            ;; CPUID intrinsics became safe in Rust 1.94.
            (add-after 'unpack 'support-older-rust
              (lambda _
                (substitute* "src/renderer/cpu/simd/cpuid.rs"
                  (("(__cpuid(_count)?\\([0-9, ]+\\))" call)
                   (string-append "unsafe { " call " }")))))
            (replace 'build
              (lambda _
                (invoke "cargo" "rustc" "--lib" "--release" "--offline"
                        "--features" "c-api" "--crate-type" "staticlib")))
            (replace 'check
              (lambda* (#:key tests? #:allow-other-keys)
                (when tests?
                  (invoke "cargo" "test" "--lib" "--release" "--offline" "--"
                          ;; Fails with LimitExceeded(ParseMemory) at this
                          ;; commit even without Telegram's patch.
                          "--skip"
                          "dos::renderer_rejects_generated_work_after_successful_parse"))))
            (delete 'package)
            (replace 'install
              (lambda _
                (install-file "target/release/libtlottie.a"
                              (string-append #$output "/lib"))
                (install-file "include/tlottie.h"
                              (string-append #$output "/include/tlottie")))))))
      (home-page "https://github.com/dkaraush/tlottie")
      (synopsis "Lottie animation renderer used by Telegram Desktop")
      (description
       "tlottie is a Rust Lottie renderer with a C API, used by Telegram
Desktop in place of rlottie.  This package carries Telegram's patch making its
parser match rlottie's handling of Telegram stickers.")
      (license license:expat))))

(define telegram-desktop
  (package
    (inherit upstream:telegram-desktop)
    (version %telegram-version)
    (source
     (origin
       (inherit (package-source upstream:telegram-desktop))
       (uri (git-reference
             (url "https://github.com/telegramdesktop/tdesktop.git")
             (commit (string-append "v" version))))
       (file-name (git-file-name "telegram-desktop" version))
       (sha256
        (base32 "0r73dnmps6fq5m0jqrmp5fqzqlpqp76c70znwlbiwgcyhq2p30ns"))))
    (arguments
     (substitute-keyword-arguments
         (package-arguments upstream:telegram-desktop)
       ((#:make-flags _ #~'()) #~'("-k"))
       ((#:configure-flags flags)
        #~(delete "-DDESKTOP_APP_USE_PACKAGED_RLOTTIE=ON" #$flags))
       ((#:phases _)
        #~(modify-phases %standard-phases
            (add-after 'unpack 'unpack-additional-sources
              (lambda _
                (for-each make-file-writable (find-files "."))
                (for-each
                 (match-lambda
                   ((dst src)
                    (copy-recursively src dst)
                    (for-each make-file-writable (find-files dst))))
                 '#$(map (match-lambda
                           ((dst src) #~(#$dst #$src)))
                         %telegram-submodules))))
            (add-after 'unpack-additional-sources 'patch-gir-ignore-paths
              (lambda _
                (substitute* "cmake/external/glib/generate_cppgir.cmake"
                  (("\\$\\{cmake_helpers_loc\\}/external/glib/cppgir/data")
                   (string-append #$(this-package-input "cppgir")
                                  "/share/cppgir")))))
            (add-after 'unpack-additional-sources 'use-system-xdg-desktop-portal
              (lambda _
                (substitute* (list "Telegram/CMakeLists.txt"
                                   "Telegram/lib_base/CMakeLists.txt")
                  (("\\$\\{third_party_loc\\}/xdg-desktop-portal/data")
                   (string-append
                    #$(this-package-native-input "xdg-desktop-portal")
                    "/share/dbus-1/interfaces")))))
            (add-after 'use-system-xdg-desktop-portal 'patch-libwebview
              (lambda _
                (substitute* "Telegram/lib_webview/webview/webview_interface.h"
                  (("constexpr ") ""))))
            (add-after 'install 'glib-or-gtk-compile-schemas
              (assoc-ref glib-or-gtk:%standard-phases
                         'glib-or-gtk-compile-schemas))
            (add-after 'glib-or-gtk-compile-schemas 'glib-or-gtk-wrap
              (assoc-ref glib-or-gtk:%standard-phases 'glib-or-gtk-wrap))))))
    (inputs
     (modify-inputs (package-inputs upstream:telegram-desktop)
       (delete "rlottie-for-telegram-desktop")
       (append libfido2 tlottie)))))
