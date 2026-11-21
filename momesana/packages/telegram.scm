(define-module (momesana packages telegram)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module (guix build-system cargo)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix download)
  #:use-module (gnu packages)
  #:use-module (gnu packages kde-frameworks)
  #:use-module (gnu packages rust)
  #:use-module (gnu packages security-token)
  #:use-module ((gnu packages telegram) #:prefix upstream:)
  #:use-module (ice-9 match)
  #:export (telegram-desktop))

(define %telegram-version "7.4.5")

(define* (telegram-origin name url commit hash #:key (patches '()))
  (origin
    (method git-fetch)
    (uri (git-reference (url url) (commit commit)))
    (file-name (git-file-name (string-append name "-for-telegram-desktop")
                              %telegram-version))
    (patches patches)
    (sha256 (base32 hash))))

(define tlottie-source
  (let ((commit "92df98dc209bc39b1e567ec74a8c86a0af5239de"))
    (origin
      (method git-fetch)
      (uri (git-reference
            (url "https://github.com/dkaraush/tlottie")
            (commit commit)))
      (file-name (git-file-name "tlottie" (git-version "1.0.6" "0" commit)))
      (sha256
       (base32 "1s3i9qzgs79scs4dyrqj2m4clf9xp9yz3yldc7nyhby0zv4k5mjs")))))

(define %telegram-submodules
  `(("cmake"
     ,(telegram-origin
       "cmake-helpers" "https://github.com/desktop-app/cmake_helpers.git"
       "8080200d61af9b2e4f72e80fca0a5176b2dd8049"
       "1sisvs899b1ys8vqx2qcwa5v3hd06rnfgshm52lz06c602ddrvic"
       #:patches (search-patches "telegram-desktop-unbundle-cppgir.patch")))
    ("Telegram/codegen"
     ,(telegram-origin
       "codegen" "https://github.com/desktop-app/codegen.git"
       "dbd1d53137cd581cfdbeebe93bcaf54abf55ec74"
       "0slsdpc28zxdgddd6z1i3028v5pgsrsdwz26idk15950jjwbc3nh"))
    ("Telegram/lib_base"
     ,(telegram-origin
       "lib-base" "https://github.com/desktop-app/lib_base.git"
       "f224f12040eea81c06b83c9aa651e80b14b4dc3a"
       "10y0cq02mq3s0qnz12hdxwsgk9icdzjyx73hb0mxrzn9qxp0p83s"))
    ("Telegram/lib_crl"
     ,(telegram-origin
       "lib-crl" "https://github.com/desktop-app/lib_crl.git"
       "de724667d7bdfbf906f78fc405af1ee9f7723d49"
       "089pn2sgcm6s8l1mx6hdn84v9mwdl66r469j0rg08pggv1jr56lr"))
    ("Telegram/lib_lottie"
     ,(telegram-origin
       "lib-lottie" "https://github.com/desktop-app/lib_lottie.git"
       "4b1e7c89e79aaae3ffd010acbf93d40cb38b067f"
       "1ivpv1m2i1qfhdm94nr45iw9qms0bngv9s62am7vq3r66cp78w9g"))
    ("Telegram/lib_qr"
     ,(telegram-origin
       "lib-qr" "https://github.com/desktop-app/lib_qr.git"
       "6fdf60461444ba150e13ac36009c0ffce72c4c83"
       "1i5n3qvjkf4nv8k75cc0a71xyvpklc4nzg4k2zsfr2pxk0cy7hkw"))
    ("Telegram/lib_rpl"
     ,(telegram-origin
       "lib-rpl" "https://github.com/desktop-app/lib_rpl.git"
       "11b92f816e99bbe085641a61a6db917e49bdd22c"
       "1gissxgbahykdcqcjqmsvxpjl0jxpyfkdq1i7v3pkzqa0h2r0sgk"))
    ("Telegram/lib_spellcheck"
     ,(telegram-origin
       "lib-spellcheck" "https://github.com/desktop-app/lib_spellcheck.git"
       "05f135f23546fc0ffa9453e39782463a3607c2b2"
       "177adk4h4rwqlz4j978plln2mfrw10m7d7pjxx2dbmgmxf3rg4p4"))
    ("Telegram/lib_storage"
     ,(telegram-origin
       "lib-storage" "https://github.com/desktop-app/lib_storage.git"
       "2711d80b90b662434be744017313ef3b9377f8b2"
       "0wj3iciirwzxarlx9ywdyriknndxj4744w70wv8n8dlaga5jyl9d"))
    ("Telegram/lib_tl"
     ,(telegram-origin
       "lib-tl" "https://github.com/desktop-app/lib_tl.git"
       "29746d31247c915a9ec870241399a9d103c39f87"
       "0hzxg53hcff0xbckxnxwpsh2qdlwm3gj1gm1i6wbz9ac3pavk64y"
       #:patches (search-patches "lib-tl-for-telegram-memcpy.patch")))
    ("Telegram/lib_translate"
     ,(telegram-origin
       "lib-translate" "https://github.com/desktop-app/lib_translate"
       "b23983df9dd87b6993afdcefb48daf890beb545e"
       "13wwq88wiwb27alisfi55aiifq0s7fbq9mnpj81hby24njfh313v"))
    ("Telegram/lib_ui"
     ,(telegram-origin
       "lib-ui" "https://github.com/desktop-app/lib_ui.git"
       "562381f7537c60a2bec7b0fea37bdb14392bfbf3"
       "1pzpm0r9npf9c8xdgvxg0dqr8lb0j5q0iv0pwg7p1i1n3qqy5a1q"
       #:patches (list (local-file "lib-ui-qt-6.9-compat.patch"))))
    ("Telegram/lib_webrtc"
     ,(telegram-origin
       "lib-webrtc" "https://github.com/desktop-app/lib_webrtc.git"
       "a22c87ddb80ebf6235b3c139448be6f364908a20"
       "18iighwjwdv6aqbp7gii07ij3valhngrdp5yzxl2s2g4na5163dw"))
    ("Telegram/lib_webview"
     ,(telegram-origin
       "lib-webview" "https://github.com/desktop-app/lib_webview.git"
       "a87346831e459e850f3cdaedf93bbb636e2b032f"
       "1izx23wx0d67n7v6rl1jdybjzcxzk54wf3lvl4k4vklrxamb9xmh"))
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
       "94640c63c20eacdf70e37e23198d9ab53c802ebd"
       "0vjrrh43c8wa38bal283vdyik36b12sjwb3bqcrby3gv2rirf9hp"))
    ("Telegram/ThirdParty/MicroTeX"
     ,(telegram-origin
       "microtex" "https://github.com/desktop-app/MicroTeX.git"
       "61aaa7cc354de91d5898ffb0b2a6c62628d9a76f"
       "1isplcrdwyadlgz251817096y793cnmqms3ial36hvbigjq60qf4"))
    ("Telegram/ThirdParty/tgcalls"
     ,(telegram-origin
       "tgcalls" "https://github.com/TelegramMessenger/tgcalls.git"
       "f0bffbb7ba91a4b95136f9bd9354d3eae9226b7a"
       "1y697ygwj14v6j1v6ax00yxvh458k8s7wxyp8b27q0wqwrsq0vk5"))
    ("Telegram/ThirdParty/TooManyCooks"
     ,(telegram-origin
       "toomanycooks" "https://github.com/tzcnt/TooManyCooks.git"
       "b86af81982860c96295a7e95e4c60cb335615cef"
       "1lpmddx0plhl2g3h86lbv184iaf38gsyjkd1bczv7q9xq4fclppr"))
    ("Telegram/ThirdParty/twidget"
     ,(telegram-origin
       "twidget" "https://github.com/TelegramMessenger/twidget.git"
       "65b031a4f60c1465cbd56a62b7435bc0f57f9fcd"
       "11jxr3bca1hxa6qml8zbwpclqw0dxgz3ckfsq6rqzmsqwwdsv965"))
    ("Telegram/ThirdParty/widget-sandbox"
     ,(telegram-origin
       "widget-sandbox" "https://github.com/TelegramMessenger/widget-sandbox.git"
       "a6cf612b9bab02308ad3b1d4eb13d15c17a137c9"
       "0dm5cx3i05x5y691b65nizj4zzh41bxg03rcmirmz5skl8s6109c"))
    ;; A submodule of widget-sandbox.
    ("Telegram/ThirdParty/widget-sandbox/packages/ios/Sources/CQuickJS/quickjs"
     ,(telegram-origin
       "quickjs" "https://github.com/TelegramMessenger/quickjs.git"
       "fbc91d85432b967d5ad112308e6c752f7b5a9417"
       "17q72gk74kqhqm9srnw0676mq8iay74fjmsbbm7sirhp9ggg08zb"))
    ("Telegram/ThirdParty/zxcvbn"
     ,(telegram-origin
       "zxcvbn" "https://github.com/tsyrogit/zxcvbn-c.git"
       "ab51000506afc1a450557a3608646bc04ba951fa"
       "035jgrjvn6lhcii7yxh2a6wyz9y8il81pwz3i7zp10jz6dqv2nvd"))))

(define wallet-engine-source
  (let ((commit "e59e0d89d7ee90c388bf36e3334c5b276f396697"))
    (origin
      (method git-fetch)
      (uri (git-reference
            (url "https://github.com/i582/wallet-engine")
            (commit commit)))
      (file-name (git-file-name "wallet-engine" (git-version "0.0.7" "0" commit)))
      (sha256
       (base32 "07l7qssdfgvrqaym1ivyl4mykn19qw9z1r655yfl14d3h3nmcvzg")))))

(define uniffi-bindgen-cpp
  (package
    (name "uniffi-bindgen-cpp")
    (version "0.9.0")
    (source wallet-engine-source)
    (build-system cargo-build-system)
    (arguments
     (list
      #:install-source? #f
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'chdir
            (lambda _
              (chdir "bindgen/cpp")))
          (replace 'install
            (lambda _
              (invoke "cargo" "install" "--offline" "--no-track"
                      "--path" "bindgen" "--root" #$output))))))
    (inputs (cargo-inputs 'uniffi-bindgen-cpp
                          #:module '(momesana packages rust-crates)))
    (home-page "https://github.com/NordSecurity/uniffi-bindgen-cpp")
    (synopsis "C++ bindings generator for UniFFI")
    (description
     "uniffi-bindgen-cpp generates C++ bindings for Rust libraries that use
UniFFI.  This copy is the one vendored by wallet-engine.")
    (license license:mpl2.0)))

;; The Rust libraries of Telegram Desktop, built like upstream's Linux build
;; does: one crate re-exporting tlottie and wallet-engine, so that a single
;; copy of the Rust standard library ends up in the binary.
(define tdesktop-rust
  (package
    (name "tdesktop-rust")
    (version %telegram-version)
    (source
     (origin
       (inherit wallet-engine-source)
       (patches
        (list (origin
                (method url-fetch)
                (uri (string-append
                      "https://raw.githubusercontent.com/desktop-app/patches/"
                      "23d349a3ff09dbc1fa8127ce39ba9223de0edf21"
                      "/wallet-engine.patch"))
                (file-name "wallet-engine-for-telegram-desktop.patch")
                (sha256
                 (base32
                  "1mjwirpmvphyzjw42yvmylyc9nkfidwi9bdvzznvyi3515wzr8k7")))))))
    (build-system cargo-build-system)
    (arguments
     (list
      #:rust rust-1.96
      #:install-source? #f
      #:tests? #f                     ; The umbrella crate has no tests
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'create-umbrella-crate
            (lambda _
              (let ((source (getcwd)))
                (chdir "..")
                (rename-file source "wallet-engine")
                (copy-recursively #$tlottie-source "tlottie")
                (mkdir-p "tdesktop_rust/src")
                (chdir "tdesktop_rust")
                (call-with-output-file "Cargo.toml"
                  (lambda (port)
                    (display "[package]
name = \"tdesktop_rust\"
version = \"0.1.0\"
edition = \"2024\"

[dependencies]
tlottie = { path = \"../tlottie\", features = [\"c-api\"] }
wallet-engine = { path = \"../wallet-engine\" }
" port)))
                (call-with-output-file "src/lib.rs"
                  (lambda (port)
                    (display "pub use ::tlottie;\npub use ::wallet_engine;\n"
                             port))))))
          (replace 'build
            (lambda _
              ;; wallet-engine asks for Rust 1.96.1.
              (invoke "cargo" "rustc" "--offline" "--lib" "--release"
                      "--ignore-rust-version"
                      "--crate-type" "staticlib" "--crate-type" "cdylib")))
          (delete 'package)
          (replace 'install
            (lambda _
              (let ((include (string-append #$output "/include")))
                (install-file "target/release/libtdesktop_rust.a"
                              (string-append #$output "/lib"))
                (install-file "../tlottie/include/tlottie.h"
                              (string-append include "/tlottie"))
                (invoke "uniffi-bindgen-cpp" "--library"
                        "--out-dir" (string-append include "/wallet_engine")
                        "target/release/libtdesktop_rust.so")))))))
    (native-inputs (list uniffi-bindgen-cpp))
    (inputs (cargo-inputs 'tdesktop-rust
                          #:module '(momesana packages rust-crates)))
    (home-page "https://github.com/telegramdesktop/tdesktop")
    (synopsis "Rust libraries of Telegram Desktop")
    (description
     "This package combines tlottie, a Lottie renderer, and wallet-engine,
the TON wallet core, into the single static library Telegram Desktop links,
along with their C and C++ interfaces.")
    (license (list license:expat license:asl2.0))))

;; LibRaw recognises some headerless camera files by their size alone,
;; so kimageformats' RAW plugin claims any image of such a size and
;; Telegram shows it as noise.  Telegram passes images without a file
;; name, which makes Qt guess the format from the content.
(define kimageformats-without-raw
  (package
    (inherit kimageformats)
    (inputs (modify-inputs (package-inputs kimageformats)
              (delete "libraw")))))

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
        (base32 "1z14hig6vp941zl7cvz9zpdbln3x39iavry94js44wxnw6pw3wlv"))))
    (arguments
     (substitute-keyword-arguments
         (package-arguments upstream:telegram-desktop)
       ((#:phases phases)
        #~(modify-phases #$phases
            (replace 'unpack-additional-sources
              (lambda _
                (for-each make-file-writable (find-files "."))
                (for-each
                 (match-lambda
                   ((dst src)
                    (copy-recursively src dst)
                    (for-each make-file-writable (find-files dst))))
                 '#$(map (match-lambda
                           ((dst src) #~(#$dst #$src)))
                         %telegram-submodules))))))))
    (inputs
     (modify-inputs (package-inputs upstream:telegram-desktop)
       (delete "rlottie-for-telegram-desktop")
       (replace "kimageformats" kimageformats-without-raw)
       (append libfido2 tdesktop-rust)))))
