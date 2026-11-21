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

(define %telegram-version "7.3.3")

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
       "7ceca3019b4750d7a5acb2de0faffd523ee14095"
       "127k1h3j9279i8a9jyp5alr9kr0pswjfhr0j5kaxvbwk2c0wlfyw"
       #:patches (search-patches "telegram-desktop-unbundle-cppgir.patch")))
    ("Telegram/codegen"
     ,(telegram-origin
       "codegen" "https://github.com/desktop-app/codegen.git"
       "dbd1d53137cd581cfdbeebe93bcaf54abf55ec74"
       "0slsdpc28zxdgddd6z1i3028v5pgsrsdwz26idk15950jjwbc3nh"))
    ("Telegram/lib_base"
     ,(telegram-origin
       "lib-base" "https://github.com/desktop-app/lib_base.git"
       "95a543e426e35938dd632139d0bb828b268c3b4c"
       "12d4vf3imr6v0a1n8c2gj5kdl812k5x984dbddqz93nw9hc8kl26"))
    ("Telegram/lib_crl"
     ,(telegram-origin
       "lib-crl" "https://github.com/desktop-app/lib_crl.git"
       "de724667d7bdfbf906f78fc405af1ee9f7723d49"
       "089pn2sgcm6s8l1mx6hdn84v9mwdl66r469j0rg08pggv1jr56lr"))
    ("Telegram/lib_lottie"
     ,(telegram-origin
       "lib-lottie" "https://github.com/desktop-app/lib_lottie.git"
       "fbb922c30b7c30ba17ad5fd4fcb989eadd620062"
       "0cx98kv22iqplb8b8xhwq1lna4hjqjgizcp8s02zl0ap5wrv577c"))
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
       "b23983df9dd87b6993afdcefb48daf890beb545e"
       "13wwq88wiwb27alisfi55aiifq0s7fbq9mnpj81hby24njfh313v"))
    ("Telegram/lib_ui"
     ,(telegram-origin
       "lib-ui" "https://github.com/desktop-app/lib_ui.git"
       "2f29133506e174a9d4a7b78740c3f1b04c2b993c"
       "0h33qdz2m11z3gmm0nafyca7b5vms4rnprbjkrv73bf3hh66q3vi"
       #:patches (list (local-file "lib-ui-qt-6.9-compat.patch"))))
    ("Telegram/lib_webrtc"
     ,(telegram-origin
       "lib-webrtc" "https://github.com/desktop-app/lib_webrtc.git"
       "52636e86eaa493de670daf71959d000b281bd153"
       "1y50q6b33r506qn4pw0sn6cmxhwjcxdb79qrw7laz45l1iw1zhm0"))
    ("Telegram/lib_webview"
     ,(telegram-origin
       "lib-webview" "https://github.com/desktop-app/lib_webview.git"
       "ef03bbfd696c7527d7cb57ac20c3a5d30feb98fa"
       "1n3lacw0jvn1i0dkciagqicma5whpr38k2q20f011bz11bylj56j"))
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
       "75f26c17308871bee69f69a2831a8af2bc2f3627"
       "1bbnvrc2yvq8g4km0bdy6q6bysqp2y7hlp41m67flijkhgvwx4p2"))
    ("Telegram/ThirdParty/MicroTeX"
     ,(telegram-origin
       "microtex" "https://github.com/desktop-app/MicroTeX.git"
       "61aaa7cc354de91d5898ffb0b2a6c62628d9a76f"
       "1isplcrdwyadlgz251817096y793cnmqms3ial36hvbigjq60qf4"))
    ("Telegram/ThirdParty/tgcalls"
     ,(telegram-origin
       "tgcalls" "https://github.com/TelegramMessenger/tgcalls.git"
       "1c236c09f8d8569fead14bd68000618a52051225"
       "194r0qnpwlqkm31iw61lpcfji2cmc2kfqjjakzzi3habjzzaagg8"))
    ("Telegram/ThirdParty/TooManyCooks"
     ,(telegram-origin
       "toomanycooks" "https://github.com/tzcnt/TooManyCooks.git"
       "b86af81982860c96295a7e95e4c60cb335615cef"
       "1lpmddx0plhl2g3h86lbv184iaf38gsyjkd1bczv7q9xq4fclppr"))
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
                      "a895fef40eaa7d66481cff542c623b039b7ce494"
                      "/wallet-engine.patch"))
                (file-name "wallet-engine-for-telegram-desktop.patch")
                (sha256
                 (base32
                  "08mqndv1aam407k00rid39xsbfhksr0gmv45d99d0hlsqf1bl2ml")))))))
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
        (base32 "0k9fwvc4bd92a88bd8ica3lvkdf3x1g52q0vhdz3jfkymckxq0qi"))))
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
