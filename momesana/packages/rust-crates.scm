(define-module (momesana packages rust-crates)
  #:use-module (guix build-system cargo)
  #:export (lookup-cargo-inputs))

;; Crate sources for the Rust packages of this channel, generated with
;; "guix import crate --lockfile=Cargo.lock".  Guix's own (gnu packages
;; rust-crates) does not export its definitions, so they cannot be shared.

(define rust-adler2-2.0.1
  (crate-source "adler2" "2.0.1"
                "1ymy18s9hs7ya1pjc9864l30wk8p2qfqdi7mhhcc5nfakxbij09j"))

(define rust-aead-0.5.2
  (crate-source "aead" "0.5.2"
                "1c32aviraqag7926xcb9sybdm36v5vh9gnxpn4pxdwjc50zl28ni"))

(define rust-aes-0.8.4
  (crate-source "aes" "0.8.4"
                "1853796anlwp4kqim0s6wm1srl4ib621nm0cl2h3c8klsjkgfsdi"))

(define rust-android-system-properties-0.1.6
  (crate-source "android_system_properties" "0.1.6"
                "1g3z4ga15a9022vbgi31qqyb7pgk23saq7xfarn6yslpr54ic8mf"))

(define rust-anstream-1.0.0
  (crate-source "anstream" "1.0.0"
                "13d2bj0xfg012s4rmq44zc8zgy1q8k9yp7yhvfnarscnmwpj2jl2"))

(define rust-anstyle-1.0.14
  (crate-source "anstyle" "1.0.14"
                "0030szmgj51fxkic1hpakxxgappxzwm6m154a3gfml83lq63l2wl"))

(define rust-anstyle-parse-1.0.0
  (crate-source "anstyle-parse" "1.0.0"
                "03hkv2690s0crssbnmfkr76kw1k7ah2i6s5amdy9yca2n8w7zkjj"))

(define rust-anstyle-query-1.1.5
  (crate-source "anstyle-query" "1.1.5"
                "1p6shfpnbghs6jsa0vnqd8bb8gd7pjd0jr7w0j8jikakzmr8zi20"))

(define rust-anstyle-wincon-3.0.11
  (crate-source "anstyle-wincon" "3.0.11"
                "0zblannm70sk3xny337mz7c6d8q8i24vhbqi42ld8v7q1wjnl7i9"))

(define rust-anyhow-1.0.104
  (crate-source "anyhow" "1.0.104"
                "0w34jjcm02p5g9kvsjr1dvpw0zs2fi7igi6nr414fkm5gz85w2ik"))

(define rust-arrayref-0.3.9
  (crate-source "arrayref" "0.3.9"
                "1jzyp0nvp10dmahaq9a2rnxqdd5wxgbvp8xaibps3zai8c9fi8kn"))

(define rust-arrayvec-0.7.8
  (crate-source "arrayvec" "0.7.8"
                "0mmd8lrijbvg1qp4c5zis5dq41a3mjv2rb6bxkyj9kwaw2k6gyyk"))

(define rust-askama-0.13.1
  (crate-source "askama" "0.13.1"
                "19z1zjabw7xbzf4491bwn8mdx6k8b5a8y7a43f1la9pg5vnl8isx"))

(define rust-askama-0.16.0
  (crate-source "askama" "0.16.0"
                "1p5d30z0q1wlnlzcqd6hn1l9ljf5vhvsi8yh36h8gn7d4m8q5gzi"))

(define rust-askama-0.16.1
  (crate-source "askama" "0.16.1"
                "195spsg79shd4593pwskxi33lzzfdzmbz0dqsb61agzlg4qxf930"))

(define rust-askama-derive-0.13.1
  (crate-source "askama_derive" "0.13.1"
                "1b26ijv1b3gxyalwqsgj32v0qzp6268d0y4gqha5qsp3ggsy0qfn"))

(define rust-askama-derive-0.16.0
  (crate-source "askama_derive" "0.16.0"
                "0f37ff849403w7sw2j6sjdrllnz158sj2pr1hkxflc51f9chdiz1"))

(define rust-askama-derive-0.16.1
  (crate-source "askama_derive" "0.16.1"
                "0f9z2lmywyswjbcl2drkv3kbbjn281lwzap0h38km3hkybmya7h7"))

(define rust-askama-macros-0.16.0
  (crate-source "askama_macros" "0.16.0"
                "06mf8jz3pav9kf8r1jryj500bzf69kplq4pnf4cs8fdxqk9b28qf"))

(define rust-askama-macros-0.16.1
  (crate-source "askama_macros" "0.16.1"
                "0ys82r6kw9pm0gdh51nb7lkrw8fqq2km3zij0f91vv3apdy1qgk4"))

(define rust-askama-parser-0.13.0
  (crate-source "askama_parser" "0.13.0"
                "0kqd9pg96dd6w9pm4q7zdhmchhkdrwsljygz56qpp1acabk5qcfg"))

(define rust-askama-parser-0.16.0
  (crate-source "askama_parser" "0.16.0"
                "1nhmlxnrb1ylmwasg3micddi4ir8wcpb73rm2d2srrs3j7g9zc3x"))

(define rust-askama-parser-0.16.1
  (crate-source "askama_parser" "0.16.1"
                "10v58ygnrr1l5fa5ccp2kqbbc5r1s76xr2xb0f5jcp97f9byfnic"))

(define rust-async-trait-0.1.89
  (crate-source "async-trait" "0.1.89"
                "1fsxxmz3rzx1prn1h3rs7kyjhkap60i7xvi0ldapkvbb14nssdch"))

(define rust-autocfg-1.5.1
  (crate-source "autocfg" "1.5.1"
                "0lqasy5i30flcgih1b50kvsk6z32g09r1q4ql7q81pj6228jy0zj"))

(define rust-base64-0.22.1
  (crate-source "base64" "0.22.1"
                "1imqzgh7bxcikp5vx3shqvw9j09g9ly0xr0jma0q66i52r7jbcvj"))

(define rust-base64-0.23.0
  (crate-source "base64" "0.23.0"
                "1a9x0g0gsi1iqh5c7mxdvnr340w8rn5bi4xjwp2q7p9w5kgmammj"))

(define rust-base64ct-1.8.3
  (crate-source "base64ct" "1.8.3"
                "01nyyyx84bhwrcc168hn47d8gvz2pzpv3y3lmck7mq4hw5vh3x9a"))

(define rust-basic-toml-0.1.10
  (crate-source "basic-toml" "0.1.10"
                "12hp59jl28kk229q4sqx6v4fc9p66v8i2byi0vlc9922h9g6fqms"))

(define rust-bitflags-2.13.1
  (crate-source "bitflags" "2.13.1"
                "1nl76mpykmwmb8rq1l5vw1azdh1wvxdrnsk4sy3rdrzx01nvg25m"))

(define rust-bitflags-2.13.2
  (crate-source "bitflags" "2.13.2"
                "01hbgjwvid66850fzi76mvn5f2bqycx6sf165ng1kfjqq9bl1v9x"))

(define rust-bitstream-io-4.10.0
  (crate-source "bitstream-io" "4.10.0"
                "07zxcy47l51k6vsxphzhgcnqyzl21pprs7212687c64s56z01zvy"))

(define rust-bitvec-1.1.1
  (crate-source "bitvec" "1.1.1"
                "0dqq44v9877q0xbl4g6aaaf3xhh3m1ca7ag0iy4l17ap5k8w7knx"))

(define rust-block-buffer-0.10.4
  (crate-source "block-buffer" "0.10.4"
                "0w9sa2ypmrsqqvc20nhwr75wbb5cjr4kkyhpjm1z1lv2kdicfy1h"))

(define rust-bnum-0.12.1
  (crate-source "bnum" "0.12.1"
                "041z8k753sh5nq7kcfv247qg7xh8n9c9jz5iqmnyz9g37nlxp0gp"))

(define rust-bumpalo-3.20.3
  (crate-source "bumpalo" "3.20.3"
                "0jc6va3nwcqikm7chnpdv1s87my3gs2j7g1sc7g3k91brg3arxbj"))

(define rust-bytemuck-1.25.2
  (crate-source "bytemuck" "1.25.2"
                "15rp2m7j7kq22s76cbjwmrkd5r8lvacnm0mnrj013cnzka22x0wm"))

(define rust-bytemuck-derive-1.11.0
  (crate-source "bytemuck_derive" "1.11.0"
                "1r9xdwcdxw385lbflmqlcc2via7hvg7d3zk2ky5mi73bkc2r6mpn"))

(define rust-byteorder-lite-0.1.0
  (crate-source "byteorder-lite" "0.1.0"
                "15alafmz4b9az56z6x7glcbcb6a8bfgyd109qc3bvx07zx4fj7wg"))

(define rust-bytes-1.12.1
  (crate-source "bytes" "1.12.1"
                "017z19dpg4f942h051m7bpnzcgng042hhcpd7bmg7bjjqd42lrgw"))

(define rust-camino-1.2.5
  (crate-source "camino" "1.2.5"
                "03dqn75zw26vf3lvc5m02kb0y3inacv7ps0nhjjvarx95bqhf4xv"))

(define rust-camino-1.2.6
  (crate-source "camino" "1.2.6"
                "14g55g2pn08yb29rqq8nqdbp4cial62x1bn87jga652c9c7d7fmv"))

(define rust-cargo-metadata-0.23.1
  (crate-source "cargo_metadata" "0.23.1"
                "1sddycfscjy47av3ykzykqgz8zjds0i00gcxs76vw4x1n0bpv67g"))

(define rust-cargo-platform-0.3.3
  (crate-source "cargo-platform" "0.3.3"
                "1fm418dzcc5rm8qm8a5vlrql7vamflwic3m05vhzl5crfgd6206x"))

(define rust-cc-1.10.0
  (crate-source "cc" "1.10.0"
                "185yfn6np0m5x7hz1q7qf595sqzbbs2vc9dshxhssh1ydvx5bq46"))

(define rust-cfg-if-1.0.4
  (crate-source "cfg-if" "1.0.4"
                "008q28ajc546z5p2hcwdnckmg0hia7rnx52fni04bwqkzyrghc4k"))

(define rust-cfg-if-1.0.5
  (crate-source "cfg-if" "1.0.5"
                "0026j56901nzjraap3da0a8njw42j66zcxnn6s2s9aa5bcblhxjf"))

(define rust-chrono-0.4.45
  (crate-source "chrono" "0.4.45"
                "09rkcgk6is2sdhqs9142zv8xqnj8ryx8m9hknllqwyv9wxi9x9qs"))

(define rust-cipher-0.4.4
  (crate-source "cipher" "0.4.4"
                "1b9x9agg67xq5nq879z66ni4l08m6m3hqcshk37d4is4ysd3ngvp"))

(define rust-clap-4.6.6
  (crate-source "clap" "4.6.6"
                "1jmx5z8d6jbvxdz6dybh599s4rd7ns6sl90p2rrdga09yh3pwg27"))

(define rust-clap-builder-4.6.6
  (crate-source "clap_builder" "4.6.6"
                "12cqg25zpjc3k82cpqa2v9h7s3vk1vydpgnwl8lfg6lfm2jzwj3v"))

(define rust-clap-derive-4.6.4
  (crate-source "clap_derive" "4.6.4"
                "0qd0v7pa2arwxjjinmjim6xrjy61bc28m1yryhc7zjjssswx44nh"))

(define rust-clap-lex-1.1.0
  (crate-source "clap_lex" "1.1.0"
                "1ycqkpygnlqnndghhcxjb44lzl0nmgsia64x9581030yifxs7m68"))

(define rust-color-quant-1.1.0
  (crate-source "color_quant" "1.1.0"
                "12q1n427h2bbmmm1mnglr57jaz2dj9apk0plcxw7nwqiai7qjyrx"))

(define rust-colorchoice-1.0.5
  (crate-source "colorchoice" "1.0.5"
                "0w75k89hw39p0mnnhlrwr23q50rza1yjki44qvh2mgrnj065a1qx"))

(define rust-const-oid-0.9.6
  (crate-source "const-oid" "0.9.6"
                "1y0jnqaq7p2wvspnx7qj76m7hjcqpz73qzvr9l2p9n2s51vr6if2"))

(define rust-convert-case-0.11.0
  (crate-source "convert_case" "0.11.0"
                "0jfv1ajyr65bjlx533n5alfkfjdl8ks4zxfywdiz1jnj1qcz1yxg"))

(define rust-core-foundation-sys-0.8.7
  (crate-source "core-foundation-sys" "0.8.7"
                "12w8j73lazxmr1z0h98hf3z623kl8ms7g07jch7n4p8f9nwlhdkp"))

(define rust-cpufeatures-0.2.17
  (crate-source "cpufeatures" "0.2.17"
                "10023dnnaghhdl70xcds12fsx2b966sxbxjq5sxs49mvxqw5ivar"))

(define rust-crc32fast-1.5.0
  (crate-source "crc32fast" "1.5.0"
                "04d51liy8rbssra92p0qnwjw8i9rm9c4m3bwy19wjamz1k4w30cl"))

(define rust-crc-3.4.0
  (crate-source "crc" "3.4.0"
                "03dsq5qsv86m35ikg84l80d00wnkjm8q4pjxgac0vaqjrnhs5f2y"))

(define rust-crc-catalog-2.5.0
  (crate-source "crc-catalog" "2.5.0"
                "0lq8dl60g457za8la86pak6i7ydxanm2lrpkqh5kyjkbz7m9hxi1"))

(define rust-crypto-box-0.9.1
  (crate-source "crypto_box" "0.9.1"
                "02ghw0frbq99d9r52dmk3nxnac6s1i6cqm8ihnkchbm8757jn60n"))

(define rust-crypto-common-0.1.7
  (crate-source "crypto-common" "0.1.7"
                "02nn2rhfy7kvdkdjl457q2z0mklcvj9h662xrq6dzhfialh2kj3q"))

(define rust-crypto-secretbox-0.1.1
  (crate-source "crypto_secretbox" "0.1.1"
                "1qa1w5s8dbyb88269zrmvbnillqahz394pl07bsds6gpmn3wzmmr"))

(define rust-curve25519-dalek-4.1.3
  (crate-source "curve25519-dalek" "4.1.3"
                "1gmjb9dsknrr8lypmhkyjd67p1arb8mbfamlwxm7vph38my8pywp"))

(define rust-curve25519-dalek-derive-0.1.1
  (crate-source "curve25519-dalek-derive" "0.1.1"
                "1cry71xxrr0mcy5my3fb502cwfxy6822k4pm19cwrilrg7hq4s7l"))

(define rust-data-url-0.3.2
  (crate-source "data-url" "0.3.2"
                "0xl30jidc8s3kh2z3nvnn1nyzhbq5b2wpiqwzj9gjdrndk50n7my"))

(define rust-deluxe-0.5.0
  (crate-source "deluxe" "0.5.0"
                "120lbwqca3pv935882n7hd5yzqr3lgnd8gfgi845kd2jyym35lwf"))

(define rust-deluxe-core-0.5.0
  (crate-source "deluxe-core" "0.5.0"
                "04ykzz8cp28gsb3qm2s5r69b0hihyqgka325m3bgjvapr18xmnpd"))

(define rust-deluxe-macros-0.5.0
  (crate-source "deluxe-macros" "0.5.0"
                "05wi3ns9lp1l7hislxhv2hiw5hsjmrpbvf27gravgw1pr3clcxgq"))

(define rust-der-0.7.10
  (crate-source "der" "0.7.10"
                "1jyxacyxdx6mxbkfw99jz59dzvcd9k17rq01a7xvn1dr6wl87hg7"))

(define rust-digest-0.10.7
  (crate-source "digest" "0.10.7"
                "14p2n6ih29x81akj097lvz7wi9b6b9hvls0lwrv7b6xwyy0s5ncy"))

(define rust-displaydoc-0.2.7
  (crate-source "displaydoc" "0.2.7"
                "1a42mwpgpwcqq2qqgkcc630wvsc2p2dkmgacjnclginwfz9js8y6"))

(define rust-ed25519-2.2.3
  (crate-source "ed25519" "2.2.3"
                "0lydzdf26zbn82g7xfczcac9d7mzm3qgx934ijjrd5hjpjx32m8i"))

(define rust-ed25519-dalek-2.2.0
  (crate-source "ed25519-dalek" "2.2.0"
                "1agcwij1z687hg26ngzwhnmpz29b2w56m8z1ap3pvrnfh709drvh"))

(define rust-equivalent-1.0.2
  (crate-source "equivalent" "1.0.2"
                "03swzqznragy8n0x31lqc78g2af054jwivp7lkrbrc0khz74lyl7"))

(define rust-equivalent-1.0.3
  (crate-source "equivalent" "1.0.3"
                "09nqddaa84mix3vil6r02jlmya3qypi4j45dhzb8yphf83ap9l80"))

(define rust-errno-0.3.14
  (crate-source "errno" "0.3.14"
                "1szgccmh8vgryqyadg8xd58mnwwicf39zmin3bsn63df2wbbgjir"))

(define rust-euclid-0.22.14
  (crate-source "euclid" "0.22.14"
                "01ksjl4vb8ms89laswnjpld3z4n6c1s7qlqq0djx3imiwdjm787i"))

(define rust-fastnum-0.7.5
  (crate-source "fastnum" "0.7.5"
                "1kcx0n96absng5ww5428nhw52dm2xp1blgwhg6fj7g24m5cin382"))

(define rust-fastrand-2.5.0
  (crate-source "fastrand" "2.5.0"
                "08q2r30y62winysimnlpbvw9kiwn0rmdlidqlmzd6z90mv764z6s"))

(define rust-fdeflate-0.3.7
  (crate-source "fdeflate" "0.3.7"
                "130ga18vyxbb5idbgi07njymdaavvk6j08yh1dfarm294ssm6s0y"))

(define rust-fiat-crypto-0.2.9
  (crate-source "fiat-crypto" "0.2.9"
                "07c1vknddv3ak7w89n85ik0g34nzzpms6yb845vrjnv9m4csbpi8"))

(define rust-find-msvc-tools-0.1.15
  (crate-source "find-msvc-tools" "0.1.15"
                "0j5sh4lb7g8xh6kd67s0vz037ah5hlp9f2rbgbg9f41rqmf92rhw"))

(define rust-flate2-1.1.9
  (crate-source "flate2" "1.1.9"
                "0g2pb7cxnzcbzrj8bw4v6gpqqp21aycmf6d84rzb6j748qkvlgw4"))

(define rust-float-cmp-0.9.0
  (crate-source "float-cmp" "0.9.0"
                "1i799ksbq7fj9rm9m82g1yqgm6xi3jnrmylddmqknmksajylpplq"))

(define rust-font-types-0.12.1
  (crate-source "font-types" "0.12.1"
                "049lf3xha6xjdqf3d56pbx74vidmb1crp1rspnf4sl7m0gnyqrxd"))

(define rust-fontconfig-parser-0.5.8
  (crate-source "fontconfig-parser" "0.5.8"
                "0ijnbzg31sl6v49g7q2l7sl76hjj8z0hvlsz77cdvm029vi77ixv"))

(define rust-fontdb-0.24.0
  (crate-source "fontdb" "0.24.0"
                "03r9lf9863cd128vb8qr11hyy156xfgllki9n4nnvxvv2plwaq16"))

(define rust-form-urlencoded-1.2.2
  (crate-source "form_urlencoded" "1.2.2"
                "1kqzb2qn608rxl3dws04zahcklpplkd5r1vpabwga5l50d2v4k6b"))

(define rust-fs-err-3.3.1
  (crate-source "fs-err" "3.3.1"
                "12ifhahp785jzapfbb82xk930m11k66yxwxx6fafgmshr94a86mr"))

(define rust-fs-err-3.3.2
  (crate-source "fs-err" "3.3.2"
                "0aazlhygf35w2ys2y7jcwv1086yq89b1rqcs48sp4vwg7dkmpjdm"))

(define rust-funty-2.0.0
  (crate-source "funty" "2.0.0"
                "177w048bm0046qlzvp33ag3ghqkqw4ncpzcm5lq36gxf2lla7mg6"))

(define rust-futures-0.3.31
  (crate-source "futures" "0.3.31"
                "0xh8ddbkm9jy8kc5gbvjp9a4b6rqqxvc8471yb2qaz5wm2qhgg35"))

(define rust-futures-channel-0.3.34
  (crate-source "futures-channel" "0.3.34"
                "1i4kwcanpaphn1ax62ci3nx176kglxqx0gnhzqpqdr1rkpbf7ydi"))

(define rust-futures-core-0.3.34
  (crate-source "futures-core" "0.3.34"
                "0pjgv4fx0np6hrs5sz5a2phabwv0z70yr51v03injbi44bjrkmlj"))

(define rust-futures-executor-0.3.34
  (crate-source "futures-executor" "0.3.34"
                "0cjl3y7jgg60wwb96ikxj23r6q91ylvx8v675yychv1w3b7lf6q3"))

(define rust-futures-io-0.3.34
  (crate-source "futures-io" "0.3.34"
                "1v9z6wj92ra18kpv0xig21hgpzrvcwmcr8fszyzh64yyay0zmh2k"))

(define rust-futures-macro-0.3.34
  (crate-source "futures-macro" "0.3.34"
                "0i0czvcvsqq4hrccibq2f23004si5z34zjwdxfmqhlrmm15nbfcz"))

(define rust-futures-sink-0.3.34
  (crate-source "futures-sink" "0.3.34"
                "07cfvrgc3vxk6sw5g8a8dnrm1mzg6d5mwy08ywa1sgyhyxml4i0r"))

(define rust-futures-task-0.3.34
  (crate-source "futures-task" "0.3.34"
                "1zfilqs8nwlfqz4prk7ihvpp5avvzins87ibzlxzq5fhs7ipshfd"))

(define rust-futures-util-0.3.34
  (crate-source "futures-util" "0.3.34"
                "1g3r9ghzq7c2fh34lis43i72xavk9p84npgfwgb5vfpqcwjajl0d"))

(define rust-generic-array-0.14.7
  (crate-source "generic-array" "0.14.7"
                "16lyyrzrljfq424c3n8kfwkqihlimmsg5nhshbbp48np3yjrqr45"))

(define rust-getrandom-0.2.17
  (crate-source "getrandom" "0.2.17"
                "1l2ac6jfj9xhpjjgmcx6s1x89bbnw9x6j9258yy6xjkzpq0bqapz"))

(define rust-getrandom-0.3.4
  (crate-source "getrandom" "0.3.4"
                "1zbpvpicry9lrbjmkd4msgj3ihff1q92i334chk7pzf46xffz7c9"))

(define rust-getrandom-0.4.3
  (crate-source "getrandom" "0.4.3"
                "16b0202fkdwz3p2cyll82dv24ljbn0wiyy829v4lwbkbflyqh3ih"))

(define rust-gif-0.14.2
  (crate-source "gif" "0.14.2"
                "0n81js7vlb9bwrjb765sicza3k0vrihjddrgm2mvpbfr272gr37f"))

(define rust-glob-0.3.4
  (crate-source "glob" "0.3.4"
                "02zby4rsidb2ksrnysyrsaap7rk6wpp7vl5chflndafhl5gaisz4"))

(define rust-goblin-0.8.2
  (crate-source "goblin" "0.8.2"
                "0isg7yzqv7y9s4xs594niy4vqzpc7d6h58z65x06dxk5q4q3ldhv"))

(define rust-harfrust-0.12.0
  (crate-source "harfrust" "0.12.0"
                "1ybn0c0yq6f1xw1749g45126hzwa95mdfz9g52xrn25a2jd98gf0"))

(define rust-hashbrown-0.17.1
  (crate-source "hashbrown" "0.17.1"
                "0jmqz7i4yl6cm7rbn0i2ffkfrmwi6xkmzkaldr2v8bcsx2v0jngd"))

(define rust-heck-0.4.1
  (crate-source "heck" "0.4.1"
                "1a7mqsnycv5z4z5vnv1k34548jzmc0ajic7c1j8jsaspnhw5ql4m"))

(define rust-heck-0.5.0
  (crate-source "heck" "0.5.0"
                "1sjmpsdl8czyh9ywl3qcsfsq9a307dg4ni2vnlwgnzzqhc4y0113"))

(define rust-hex-0.4.3
  (crate-source "hex" "0.4.3"
                "0w1a4davm1lgzpamwnba907aysmlrnygbqmfis2mqjx5m552a93z"))

(define rust-hmac-0.12.1
  (crate-source "hmac" "0.12.1"
                "0pmbr069sfg76z7wsssfk5ddcqd9ncp79fyz6zcm6yn115yc6jbc"))

(define rust-iana-time-zone-0.1.65
  (crate-source "iana-time-zone" "0.1.65"
                "0w64khw5p8s4nzwcf36bwnsmqzf61vpwk9ca1920x82bk6nwj6z3"))

(define rust-iana-time-zone-haiku-0.1.2
  (crate-source "iana-time-zone-haiku" "0.1.2"
                "17r6jmj31chn7xs9698r122mapq85mfnv98bb4pg6spm0si2f67k"))

(define rust-icu-collections-2.4.0
  (crate-source "icu_collections" "2.4.0"
                "1p85w6wf2bfyv1ffbgzln8n440nczv8kw9k3iknhy56kl110l2gy"))

(define rust-icu-locale-core-2.4.0
  (crate-source "icu_locale_core" "2.4.0"
                "1h44m6jbiff814wpllybb93010nhlb7l28acvk82hrbwq5brpli5"))

(define rust-icu-normalizer-2.4.0
  (crate-source "icu_normalizer" "2.4.0"
                "16f5hzppvfl136p72ikfdpblljnqjilan8vzzs3mq83g9263njj0"))

(define rust-icu-normalizer-data-2.4.0
  (crate-source "icu_normalizer_data" "2.4.0"
                "1g4cir7jji6wlv98rkmrqv5a3jz9n46f5jd0gyizfhblzf5hiw10"))

(define rust-icu-properties-2.4.0
  (crate-source "icu_properties" "2.4.0"
                "17rpgbrwk5963yaqizl2xq3przhxdi1qdgwqz1y8y5an3jckva1f"))

(define rust-icu-properties-data-2.4.0
  (crate-source "icu_properties_data" "2.4.0"
                "1kyzmmgm1jqlfcpqr3nc0wqvnhz7a21khq81wlzicayhhapjk3xr"))

(define rust-icu-provider-2.4.0
  (crate-source "icu_provider" "2.4.0"
                "05458rwq7bnw05z1b7dfiyda0wdr56rr0481izp8ii9naqqrjc21"))

(define rust-idna-1.1.0
  (crate-source "idna" "1.1.0"
                "1pp4n7hppm480zcx411dsv9wfibai00wbpgnjj4qj0xa7kr7a21v"))

(define rust-idna-adapter-1.2.2
  (crate-source "idna_adapter" "1.2.2"
                "0557p76l8hj35r9zn1yv7c6x1c0qbrsffmg80n0yy8361ly3fs6b"))

(define rust-if-chain-1.0.3
  (crate-source "if_chain" "1.0.3"
                "1jzm319jbb3lbm5vdsxjjyih3g3a1a405pmiipmyxa3fx2sycqnd"))

(define rust-image-webp-0.2.4
  (crate-source "image-webp" "0.2.4"
                "1hz814csyi9283vinzlkix6qpnd6hs3fkw7xl6z2zgm4w7rrypjj"))

(define rust-imagesize-0.15.0
  (crate-source "imagesize" "0.15.0"
                "0ah45pw3bjwwca0nfq13z7yz6hikkbnkiicl7xzh6ay9q9h79ck5"))

(define rust-indexmap-2.14.0
  (crate-source "indexmap" "2.14.0"
                "1na9z6f0d5pkjr1lgsni470v98gv2r7c41j8w48skr089x2yjrnl"))

(define rust-indexmap-2.14.2
  (crate-source "indexmap" "2.14.2"
                "0mf86hbjkkcd82cpq683bblbs0zwa8ndla96ci8p1ji6bl7ijknc"))

(define rust-inout-0.1.4
  (crate-source "inout" "0.1.4"
                "008xfl1jn9rxsq19phnhbimccf4p64880jmnpg59wqi07kk117w7"))

(define rust-is-terminal-polyfill-1.70.2
  (crate-source "is_terminal_polyfill" "1.70.2"
                "15anlc47sbz0jfs9q8fhwf0h3vs2w4imc030shdnq54sny5i7jx6"))

(define rust-itoa-1.0.18
  (crate-source "itoa" "1.0.18"
                "10jnd1vpfkb8kj38rlkn2a6k02afvj3qmw054dfpzagrpl6achlg"))

(define rust-js-sys-0.3.106
  (crate-source "js-sys" "0.3.106"
                "1icwmpjw54lb7vg5926k5y4y5jbiih0zxhwgjwnzn475v90xk0vq"))

(define rust-kurbo-0.13.1
  (crate-source "kurbo" "0.13.1"
                "1qjhhjgwr9admlz6r1s7kp38dl8nbd95abhryrnr4av55z1xyq2b"))

(define rust-libc-0.2.189
  (crate-source "libc" "0.2.189"
                "1whjfs375vlng2q6yrbzs73cvp5lm3w1n2gfqajb2vgf7zg3xbry"))

(define rust-libc-0.2.191
  (crate-source "libc" "0.2.191"
                "02i4j7pjh129y92rijaia4576131fa2xjsii1dc3c1fnlv4qgkb5"))

(define rust-libm-0.2.16
  (crate-source "libm" "0.2.16"
                "10brh0a3qjmbzkr5mf5xqi887nhs5y9layvnki89ykz9xb1wxlmn"))

(define rust-linux-raw-sys-0.12.1
  (crate-source "linux-raw-sys" "0.12.1"
                "0lwasljrqxjjfk9l2j8lyib1babh2qjlnhylqzl01nihw14nk9ij"))

(define rust-litemap-0.8.3
  (crate-source "litemap" "0.8.3"
                "1bpgpj87560hmckh3875fbahpmfxbk4g8pzns84h3ykf3nfx3na7"))

(define rust-lock-api-0.4.14
  (crate-source "lock_api" "0.4.14"
                "0rg9mhx7vdpajfxvdjmgmlyrn20ligzqvn8ifmaz7dc79gkrjhr2"))

(define rust-log-0.4.33
  (crate-source "log" "0.4.33"
                "1bd9dmk22pxgnf0h0slba6rz99zb0a0b2mdhpk8p92bp26ycbvhc"))

(define rust-log-0.4.34
  (crate-source "log" "0.4.34"
                "1ihkzn0m33ab79fcl4mkb04n5iwqzbxzyw7l7hazqkffaqzbvy7r"))

(define rust-memchr-2.8.3
  (crate-source "memchr" "2.8.3"
                "161xa63ipfanf8v3nb82xd5hqgydv55nzw59wyngqbz6alfaz2yg"))

(define rust-memmap2-0.9.11
  (crate-source "memmap2" "0.9.11"
                "1h4qnzgarnn488ljjpg9ns5y4bw0sq0xv0fj0iqywagjnz8rw8fi"))

(define rust-minimal-lexical-0.2.1
  (crate-source "minimal-lexical" "0.2.1"
                "16ppc5g84aijpri4jzv14rvcnslvlpphbszc7zzp6vfkddf4qdb8"))

(define rust-miniz-oxide-0.8.9
  (crate-source "miniz_oxide" "0.8.9"
                "05k3pdg8bjjzayq3rf0qhpirq9k37pxnasfn4arbs17phqn6m9qz"))

(define rust-no-std-io2-0.9.4
  (crate-source "no_std_io2" "0.9.4"
                "00w0ggkaaacbwiv4qw188ih5llmhf53qgp20wk5gdyrldldvv2j1"))

(define rust-nom-7.1.3
  (crate-source "nom" "7.1.3"
                "0jha9901wxam390jcf5pfa0qqfrgh8li787jx2ip0yk5b8y9hwyj"))

(define rust-num-bigint-0.4.8
  (crate-source "num-bigint" "0.4.8"
                "0ry3xjal8f5xhdinani268ci13h14mf7j4w0y1gflfzhw3knk7n8"))

(define rust-num-integer-0.1.47
  (crate-source "num-integer" "0.1.47"
                "02z1p3azy6p10n99skrab4a6hhfd4amf2i9gm8sxqd1p9dfxkqkw"))

(define rust-num-traits-0.2.19
  (crate-source "num-traits" "0.2.19"
                "0h984rhdkkqd4ny9cif7y2azl3xdfb7768hb9irhpsch4q3gq787"))

(define rust-once-cell-1.21.4
  (crate-source "once_cell" "1.21.4"
                "0l1v676wf71kjg2khch4dphwh1jp3291ffiymr2mvy1kxd5kwz4z"))

(define rust-once-cell-polyfill-1.70.2
  (crate-source "once_cell_polyfill" "1.70.2"
                "1zmla628f0sk3fhjdjqzgxhalr2xrfna958s632z65bjsfv8ljrq"))

(define rust-opaque-debug-0.3.1
  (crate-source "opaque-debug" "0.3.1"
                "10b3w0kydz5jf1ydyli5nv10gdfp97xh79bgz327d273bs46b3f0"))

(define rust-ordered-float-2.10.1
  (crate-source "ordered-float" "2.10.1"
                "075i108hr95pr7hy4fgxivib5pky3b6b22rywya5qyd2wmkrvwb8"))

(define rust-parking-lot-0.12.5
  (crate-source "parking_lot" "0.12.5"
                "06jsqh9aqmc94j2rlm8gpccilqm6bskbd67zf6ypfc0f4m9p91ck"))

(define rust-parking-lot-core-0.9.12
  (crate-source "parking_lot_core" "0.9.12"
                "1hb4rggy70fwa1w9nb0svbyflzdc69h047482v2z3sx2hmcnh896"))

(define rust-password-hash-0.5.0
  (crate-source "password-hash" "0.5.0"
                "0ri1mim11zk0a9s40zdi288dfqvmdiryc7lw8vl46b59ifa08vrl"))

(define rust-paste-1.0.15
  (crate-source "paste" "1.0.15"
                "02pxffpdqkapy292harq6asfjvadgp1s005fip9ljfsn9fvxgh2p"))

(define rust-pbkdf2-0.12.2
  (crate-source "pbkdf2" "0.12.2"
                "1wms79jh4flpy1zi8xdp4h8ccxv4d85adc6zjagknvppc5vnmvgq"))

(define rust-percent-encoding-2.3.2
  (crate-source "percent-encoding" "2.3.2"
                "083jv1ai930azvawz2khv7w73xh8mnylk7i578cifndjn5y64kwv"))

(define rust-pico-args-0.5.0
  (crate-source "pico-args" "0.5.0"
                "05d30pvxd6zlnkg2i3ilr5a70v3f3z2in18m67z25vinmykngqav"))

(define rust-pin-project-lite-0.2.17
  (crate-source "pin-project-lite" "0.2.17"
                "1kfmwvs271si96zay4mm8887v5khw0c27jc9srw1a75ykvgj54x8"))

(define rust-pkcs8-0.10.2
  (crate-source "pkcs8" "0.10.2"
                "1dx7w21gvn07azszgqd3ryjhyphsrjrmq5mmz1fbxkj5g0vv4l7r"))

(define rust-plain-0.2.3
  (crate-source "plain" "0.2.3"
                "19n1xbxb4wa7w891268bzf6cbwq4qvdb86bik1z129qb0xnnnndl"))

(define rust-png-0.18.1
  (crate-source "png" "0.18.1"
                "0qca282xp8a6d7mikxrwji3f52mjn4vnqxz2v9iz5adj665rnxk0"))

(define rust-poly1305-0.8.0
  (crate-source "poly1305" "0.8.0"
                "1grs77skh7d8vi61ji44i8gpzs3r9x7vay50i6cg8baxfa8bsnc1"))

(define rust-polycool-0.4.0
  (crate-source "polycool" "0.4.0"
                "19m52bzlr779l2ci8vpqp9qxyrlfaq4h5m5cbkvxanpb17f6snah"))

(define rust-potential-utf-0.1.6
  (crate-source "potential_utf" "0.1.6"
                "0qbndl2fpphq7mph41m11vaixs05xrh1s451wxlgap4fdnybjgnq"))

(define rust-proc-macro2-1.0.107
  (crate-source "proc-macro2" "1.0.107"
                "1nb6ly8kp65f724kj73ippc7lvydss24sm2vagk6qpklpg4pwplq"))

(define rust-proc-macro-crate-1.3.1
  (crate-source "proc-macro-crate" "1.3.1"
                "069r1k56bvgk0f58dm5swlssfcp79im230affwk6d9ck20g04k3z"))

(define rust-proc-macro-crate-3.5.0
  (crate-source "proc-macro-crate" "3.5.0"
                "0kv1g1d1zjwxlgcaba2qlshzyy32j03xic8rskqlcr5mnblsfyz6"))

(define rust-quick-error-2.0.1
  (crate-source "quick-error" "2.0.1"
                "18z6r2rcjvvf8cn92xjhm2qc3jpd1ljvcbf12zv0k9p565gmb4x9"))

(define rust-quote-1.0.47
  (crate-source "quote" "1.0.47"
                "00ch0yyzvv6s671ik0kcsbw8nigdaj2g3fr61kcahwx48aqlvgqz"))

(define rust-r-efi-5.3.0
  (crate-source "r-efi" "5.3.0"
                "03sbfm3g7myvzyylff6qaxk4z6fy76yv860yy66jiswc2m6b7kb9"))

(define rust-r-efi-6.0.0
  (crate-source "r-efi" "6.0.0"
                "1gyrl2k5fyzj9k7kchg2n296z5881lg7070msabid09asp3wkp7q"))

(define rust-radium-0.7.0
  (crate-source "radium" "0.7.0"
                "02cxfi3ky3c4yhyqx9axqwhyaca804ws46nn4gc1imbk94nzycyw"))

(define rust-rand-core-0.6.4
  (crate-source "rand_core" "0.6.4"
                "0b4j2v4cb5krak1pv6kakv4sz6xcwbrmy2zckc32hsigbrwy82zc"))

(define rust-read-fonts-0.41.0
  (crate-source "read-fonts" "0.41.0"
                "02c7q458gz6cfsyryiss5w6xp0k8dl2n4l1gncjrhidg9mkpssh4"))

(define rust-redox-syscall-0.5.18
  (crate-source "redox_syscall" "0.5.18"
                "0b9n38zsxylql36vybw18if68yc9jczxmbyzdwyhb9sifmag4azd"))

(define rust-rgb-0.8.53
  (crate-source "rgb" "0.8.53"
                "1i0c55whln68zs6f5qqrkbg1mzai0p3qk1mwkwzdgr9i3dw4pcs7"))

(define rust-roxmltree-0.20.0
  (crate-source "roxmltree" "0.20.0"
                "15vw91ps91wkmmgy62khf9zb63bdinvm80957dascbsw7dwvc83c"))

(define rust-roxmltree-0.21.1
  (crate-source "roxmltree" "0.21.1"
                "1fxc3jgvl2rk05bw0hj86azqg6mzlijh06gyi9pw69b1qw84p5pi"))

(define rust-rustc-hash-2.1.3
  (crate-source "rustc-hash" "2.1.3"
                "0bbla578m87qmf3yr55q49l97gxn7z0ha1dwqlnvwwc58ad7y7kb"))

(define rust-rustc-version-0.4.1
  (crate-source "rustc_version" "0.4.1"
                "14lvdsmr5si5qbqzrajgb6vfn69k0sfygrvfvr2mps26xwi3mjyg"))

(define rust-rustix-1.1.4
  (crate-source "rustix" "1.1.4"
                "14511f9yjqh0ix07xjrjpllah3325774gfwi9zpq72sip5jlbzmn"))

(define rust-rustix-1.1.6
  (crate-source "rustix" "1.1.6"
                "1ajqv2zxmfms30hhvp5bdzpixn5xqnz7s871vpa56h99wm16grz5"))

(define rust-rustversion-1.0.23
  (crate-source "rustversion" "1.0.23"
                "07z2a843fs80fawwflj9jwn49k9b0bd0dhhbvy0ar69vaxd72m6g"))

(define rust-salsa20-0.10.2
  (crate-source "salsa20" "0.10.2"
                "04w211x17xzny53f83p8f7cj7k2hi8zck282q5aajwqzydd2z8lp"))

(define rust-scopeguard-1.2.0
  (crate-source "scopeguard" "1.2.0"
                "0jcz9sd47zlsgcnm1hdw0664krxwb5gczlif4qngj2aif8vky54l"))

(define rust-scroll-0.12.0
  (crate-source "scroll" "0.12.0"
                "19mix9vm4k23jkknpgbi0ylmhpf2hnlpzzrfj9wqcj88lj55kf3a"))

(define rust-scroll-derive-0.12.1
  (crate-source "scroll_derive" "0.12.1"
                "0gb89b1yr8a6jwp4rcm00xqry6ajvmfywsm7bf5f42a686yfm0qp"))

(define rust-semver-1.0.28
  (crate-source "semver" "1.0.28"
                "1kaimrpy876bcgi8bfj0qqfxk77zm9iz2zhn1hp9hj685z854y4a"))

(define rust-serde-1.0.229
  (crate-source "serde" "1.0.229"
                "1fp04fq4a79bpm61xz1zy0pbz4kpc7d771zii1k3inmszq55jj21"))

(define rust-serde-aux-4.7.0
  (crate-source "serde-aux" "4.7.0"
                "02lamg1xzz2xghbqwr872gi33s553szz16rsa2bba3z9iyr6fzr0"))

(define rust-serde-core-1.0.229
  (crate-source "serde_core" "1.0.229"
                "0j1ajiha76h3nmd976il9li6975k121xa7jb39ws8n0yqp4s5p37"))

(define rust-serde-derive-1.0.229
  (crate-source "serde_derive" "1.0.229"
                "0j4k63i7h1bikxwz2c89ig0hrwbnl9mz1czn85xx99x5cc9dg9g7"))

(define rust-serde-json-1.0.151
  (crate-source "serde_json" "1.0.151"
                "051zww7lvpw147vvwss1ng6w587qyrkzg75fvj08q2dfrmgbahf8"))

(define rust-serde-spanned-1.1.1
  (crate-source "serde_spanned" "1.1.1"
                "09jzk7i6wihn3d8i3wi4j4n98ghi93c3b8m8k64nxq0ijn3vaqk6"))

(define rust-serde-spanned-1.1.2
  (crate-source "serde_spanned" "1.1.2"
                "0b0crd16vvp0n81pgh0ldi3apld0ph5ywsrml80y5v2ynnz26xaf"))

(define rust-serde-value-0.7.0
  (crate-source "serde-value" "0.7.0"
                "0b18ngk7n4f9zmwsfdkhgsp31192smzyl5z143qmx1qi28sa78gk"))

(define rust-sha2-0.10.9
  (crate-source "sha2" "0.10.9"
                "10xjj843v31ghsksd9sl9y12qfc48157j1xpb8v1ml39jy0psl57"))

(define rust-shlex-2.0.1
  (crate-source "shlex" "2.0.1"
                "1fjsll1cd7d2bcpdij9kd6w62rpbc7qqzvydvs021vsmr1cxvypq"))

(define rust-signature-2.2.0
  (crate-source "signature" "2.2.0"
                "1pi9hd5vqfr3q3k49k37z06p7gs5si0in32qia4mmr1dancr6m3p"))

(define rust-simd-adler32-0.3.10
  (crate-source "simd-adler32" "0.3.10"
                "1sny4y2qa5mwyxx5x59ln2p02vsdh92004njlslnx98imjc9489s"))

(define rust-simplecss-0.2.2
  (crate-source "simplecss" "0.2.2"
                "0v0kid7b2602kcka2x2xs9wwfjf8lnvpgpl8x287qg4wra1ni73s"))

(define rust-siphasher-1.0.3
  (crate-source "siphasher" "1.0.3"
                "0jg6l9xyzca5vy4h6gf8r6p4kk84g98fk95pzig1kq6cr4z8grcf"))

(define rust-siphasher-1.0.4
  (crate-source "siphasher" "1.0.4"
                "0mn28y43123jdpskdn6r9wibmn066f7h30zkkqn88bd6hj8zxx1k"))

(define rust-skrifa-0.44.0
  (crate-source "skrifa" "0.44.0"
                "0s5a3fnyrxfv514vjjrn268lyhihmh5nb9fyv7cp4ghx5gbbg6l1"))

(define rust-slab-0.4.12
  (crate-source "slab" "0.4.12"
                "1xcwik6s6zbd3lf51kkrcicdq2j4c1fw0yjdai2apy9467i0sy8c"))

(define rust-slotmap-1.1.1
  (crate-source "slotmap" "1.1.1"
                "0f20xf53zaysx9ydzkwwqm6hsjyb8lj2j6amhg57iln3jcy8rmdx"))

(define rust-smallvec-1.15.2
  (crate-source "smallvec" "1.15.2"
                "143wzbqf6vgapdp2z4qpl0yvlqcn17s8cnk8m28rqly808zsdmlf"))

(define rust-smallvec-1.16.4
  (crate-source "smallvec" "1.16.4"
                "1j772prjisi2872lxry7d9fkss3dfbjwl16jmsvvp2qvk2qx9mfh"))

(define rust-smawk-0.3.3
  (crate-source "smawk" "0.3.3"
                "006id1vx7vv7vdnmj0ss5dla34ggymlavv9b5wb4vfws947zpqp8"))

(define rust-spki-0.7.3
  (crate-source "spki" "0.7.3"
                "17fj8k5fmx4w9mp27l970clrh5qa7r5sjdvbsln987xhb34dc7nr"))

(define rust-stable-deref-trait-1.2.1
  (crate-source "stable_deref_trait" "1.2.1"
                "15h5h73ppqyhdhx6ywxfj88azmrpml9gl6zp3pwy2malqa6vxqkc"))

(define rust-static-assertions-1.1.0
  (crate-source "static_assertions" "1.1.0"
                "0gsl6xmw10gvn3zs1rv99laj5ig7ylffnh71f9l34js4nr4r7sx2"))

(define rust-strict-num-0.1.1
  (crate-source "strict-num" "0.1.1"
                "0cb7l1vhb8zj90mzm8avlk815k40sql9515s865rqdrdfavvldv6"))

(define rust-strsim-0.10.0
  (crate-source "strsim" "0.10.0"
                "08s69r4rcrahwnickvi0kq49z524ci50capybln83mg6b473qivk"))

(define rust-strsim-0.11.1
  (crate-source "strsim" "0.11.1"
                "0kzvqlw8hxqb7y598w1s0hxlnmi84sg5vsipp3yg5na5d1rvba3x"))

(define rust-subtle-2.6.1
  (crate-source "subtle" "2.6.1"
                "14ijxaymghbl1p0wql9cib5zlwiina7kall6w7g89csprkgbvhhk"))

(define rust-svgtypes-0.16.1
  (crate-source "svgtypes" "0.16.1"
                "0gdw5a7znyv5sh4a575ddlhkvnvf45dd5grvkflsy78knf85fnv9"))

(define rust-syn-2.0.119
  (crate-source "syn" "2.0.119"
                "15vjy620l91a3q4n4f4gzhnflmdr6pnm38v2m6cpk86i8av32a47"))

(define rust-syn-3.0.3
  (crate-source "syn" "3.0.3"
                "18srnql3cd39j9q6hf1az02p67rlr1rf6njx9zx4vxj9i3jvmsak"))

(define rust-syn-3.0.9
  (crate-source "syn" "3.0.9"
                "0fw28lhl90kls24q2h2sp39yjb0lsvz5cwh9fd3f3w3v9kp8v36p"))

(define rust-synstructure-0.14.0
  (crate-source "synstructure" "0.14.0"
                "00kzyz38xqvs7x1dn6rp64y0ckly4m7ywf3qk3qkgqfzs3nh85wh"))

(define rust-tap-1.0.1
  (crate-source "tap" "1.0.1"
                "0sc3gl4nldqpvyhqi3bbd0l9k7fngrcl4zs47n314nqqk4bpx4sm"))

(define rust-tempfile-3.27.0
  (crate-source "tempfile" "3.27.0"
                "1gblhnyfjsbg9wjg194n89wrzah7jy3yzgnyzhp56f3v9jd7wj9j"))

(define rust-textwrap-0.16.2
  (crate-source "textwrap" "0.16.2"
                "0mrhd8q0dnh5hwbwhiv89c6i41yzmhw4clwa592rrp24b9hlfdf1"))

(define rust-textwrap-0.16.4
  (crate-source "textwrap" "0.16.4"
                "0jfdxds0k50c3cy5a2s31l37lzp55r0iw75ry9vsb05w79navkvf"))

(define rust-thiserror-2.0.17
  (crate-source "thiserror" "2.0.17"
                "1j2gixhm2c3s6g96vd0b01v0i0qz1101vfmw0032mdqj1z58fdgn"))

(define rust-thiserror-2.0.20
  (crate-source "thiserror" "2.0.20"
                "0kxs6p295jffxhzaxpxv1dwaaf5iqlm6sx8h0djp6ancbxgj71pc"))

(define rust-thiserror-impl-2.0.17
  (crate-source "thiserror-impl" "2.0.17"
                "04y92yjwg1a4piwk9nayzjfs07sps8c4vq9jnsfq9qvxrn75rw9z"))

(define rust-thiserror-impl-2.0.20
  (crate-source "thiserror-impl" "2.0.20"
                "1bwjc94gi0xn5jz26h1a8bjj1wdkvvr6jifamyc4mp9n28zcs15w"))

(define rust-tiny-skia-0.12.0
  (crate-source "tiny-skia" "0.12.0"
                "1sliba6ghl038ig7r4wds7aq9v5x1swmdqxh1xipylpmm9gfxzs7"))

(define rust-tiny-skia-path-0.12.0
  (crate-source "tiny-skia-path" "0.12.0"
                "1fgfzl0mzf2vfcqk3817wxynhmvcza05jg2r0rysdk5c7xf3djpd"))

(define rust-tinystr-0.8.5
  (crate-source "tinystr" "0.8.5"
                "06l0g5wy57a43bd1qvk92xd5dpnz3qk949vbx3wmhk8m73141j5b"))

(define rust-tinyvec-1.12.0
  (crate-source "tinyvec" "1.12.0"
                "0zxaid976y60f4722vjhfnwcbydmzpwva7p03aqzl15gl3dblkmv"))

(define rust-tinyvec-macros-0.1.1
  (crate-source "tinyvec_macros" "0.1.1"
                "081gag86208sc3y6sdkshgw3vysm5d34p431dzw0bshz66ncng0z"))

(define rust-toml-1.1.4+spec-1.1.0
  (crate-source "toml" "1.1.4+spec-1.1.0"
                "1xanf3v10j8hdjz37mkhg80w92cw25kxwndhcp4w5pxw9czydb1s"))

(define rust-toml-1.1.8+spec-1.1.0
  (crate-source "toml" "1.1.8+spec-1.1.0"
                "13b7kqvw7aa4x08i03d2fpima1i75v0lqxl0wrmisx6qwh09wj10"))

(define rust-toml-datetime-0.6.11
  (crate-source "toml_datetime" "0.6.11"
                "077ix2hb1dcya49hmi1avalwbixmrs75zgzb3b2i7g2gizwdmk92"))

(define rust-toml-datetime-1.1.1+spec-1.1.0
  (crate-source "toml_datetime" "1.1.1+spec-1.1.0"
                "1mws2mkkf46l7inn77azhm0vdwxngv9vsbhbl0ah33p2c9gzcr9i"))

(define rust-toml-datetime-1.1.2+spec-1.1.0
  (crate-source "toml_datetime" "1.1.2+spec-1.1.0"
                "0lrhcmqvhjr259w4f2kijya7fgi0kpmhg9fb3m144v3cj1kxg1ib"))

(define rust-toml-edit-0.19.15
  (crate-source "toml_edit" "0.19.15"
                "08bl7rp5g6jwmfpad9s8jpw8wjrciadpnbaswgywpr9hv9qbfnqv"))

(define rust-toml-edit-0.25.17+spec-1.1.0
  (crate-source "toml_edit" "0.25.17+spec-1.1.0"
                "174w1b2fjg1jb0wi7384v1m59g7ga79458i022gafjakpddisr73"))

(define rust-toml-parser-1.1.3+spec-1.1.0
  (crate-source "toml_parser" "1.1.3+spec-1.1.0"
                "0mjdvihdkmjd4ykh574xgii71hpxw7ns7h4n4bisqpxrz4faqf0x"))

(define rust-toml-parser-1.1.5+spec-1.1.0
  (crate-source "toml_parser" "1.1.5+spec-1.1.0"
                "0k3lljyi4zxchdklaqghkwbl7wkd2ab1w16hlyniqzid0fl979ms"))

(define rust-toml-writer-1.1.2+spec-1.1.0
  (crate-source "toml_writer" "1.1.2+spec-1.1.0"
                "1lk6pqf9mac3v1x6282n6a66qx5b18c8f4a23bsd0nk658x3amkx"))

(define rust-toml-writer-1.1.3+spec-1.1.0
  (crate-source "toml_writer" "1.1.3+spec-1.1.0"
                "0w17cps8mfg7wcwyp0gggi9cpgmxldb9pwl55qp8ssq5zj6bvg86"))

(define rust-ton-core-0.1.4
  (crate-source "ton_core" "0.1.4"
                "132c3zxwmyppjvspqxg3dk2bxawfj0nzwy0fvzjc4s7cpdlzrs7v"))

(define rust-ton-macros-0.1.2
  (crate-source "ton_macros" "0.1.2"
                "0q3h19jzrlk7qgj28ms5fb634zjaljflny93dazp7i8ww76aflyk"))

(define rust-topological-sort-0.2.2
  (crate-source "topological-sort" "0.2.2"
                "0gcxahg24c058izagz642vs0kfb2zja48my3qrd0kkaf2d730s7a"))

(define rust-typenum-1.20.1
  (crate-source "typenum" "1.20.1"
                "086s9ly0906kw5yw41249fba97w5zfxf03pyfwdkffvcprqfixdn"))

(define rust-unicode-bidi-0.3.18
  (crate-source "unicode-bidi" "0.3.18"
                "1xcxwbsqa24b8vfchhzyyzgj0l6bn51ib5v8j6krha0m77dva72w"))

(define rust-unicode-ident-1.0.24
  (crate-source "unicode-ident" "1.0.24"
                "0xfs8y1g7syl2iykji8zk5hgfi5jw819f5zsrbaxmlzwsly33r76"))

(define rust-unicode-ident-1.0.27
  (crate-source "unicode-ident" "1.0.27"
                "0qv54hz0sxmspjyr162z3435pnyylzjjhx3j4k1s359pqgb59ix2"))

(define rust-unicode-linebreak-0.1.5
  (crate-source "unicode-linebreak" "0.1.5"
                "07spj2hh3daajg335m4wdav6nfkl0f6c0q72lc37blr97hych29v"))

(define rust-unicode-script-0.5.8
  (crate-source "unicode-script" "0.5.8"
                "1vmifpgd0map3frmvhszhl96k82crcry083prv05wii7p45x8fiq"))

(define rust-unicode-segmentation-1.13.3
  (crate-source "unicode-segmentation" "1.13.3"
                "1a47zaq83p386r3baq4m018xd5q4q0grdg56i1x042dzn71x7xf6"))

(define rust-unicode-vo-0.1.0
  (crate-source "unicode-vo" "0.1.0"
                "151sha088v9jyfvbg5164xh4dk72g53b82xm4zzbf5dlagzqdlxi"))

(define rust-unicode-width-0.2.2
  (crate-source "unicode-width" "0.2.2"
                "0m7jjzlcccw716dy9423xxh0clys8pfpllc5smvfxrzdf66h9b5l"))

(define rust-unicode-width-0.2.3
  (crate-source "unicode-width" "0.2.3"
                "0mymrsdklcgys4fndds2h2hasij36gyalcqy4nghb4k9hxqq8wfa"))

(define rust-uniffi-0.32.0
  (crate-source "uniffi" "0.32.0"
                "1j206p66swfcxkvrbhdk0hqw8xakpwfnjz7wbkba5mygfa6s90m7"))

(define rust-uniffi-bindgen-0.32.0
  (crate-source "uniffi_bindgen" "0.32.0"
                "1b7r8d368x4s61w5g6b78zfn429rmv75gcm4g3mm8fryqw906fsk"))

(define rust-uniffi-core-0.32.0
  (crate-source "uniffi_core" "0.32.0"
                "1gl6l1h6prdyj6vpxb4qljqxdpbxjmqnwlwg92kappxhqmhy4clf"))

(define rust-uniffi-internal-macros-0.32.0
  (crate-source "uniffi_internal_macros" "0.32.0"
                "1bximmp67153yqmi9rzhqb98hb2k52vbvmagd7pp4rsyk837ibl4"))

(define rust-uniffi-macros-0.32.0
  (crate-source "uniffi_macros" "0.32.0"
                "03axxlzkl279avx7g3jfb647brhbpdq4rx9ivwh67s1j0mvyc2rk"))

(define rust-uniffi-meta-0.32.0
  (crate-source "uniffi_meta" "0.32.0"
                "1ryrihr9sdg9l8wpfbs2fwgd7lsggpb4jnk6djqnmra7algh5pkq"))

(define rust-uniffi-pipeline-0.32.0
  (crate-source "uniffi_pipeline" "0.32.0"
                "0j293nwfsvpm27cz3ky365x3w0wabk1cn48fv118mv8736xh30iz"))

(define rust-uniffi-udl-0.32.0
  (crate-source "uniffi_udl" "0.32.0"
                "1h2n2qdcbmj9qg0p2wdq8wjkqcdf4zb4aj7hkg19q02qpjb7krd6"))

(define rust-universal-hash-0.5.1
  (crate-source "universal-hash" "0.5.1"
                "1sh79x677zkncasa95wz05b36134822w6qxmi1ck05fwi33f47gw"))

(define rust-url-2.5.7
  (crate-source "url" "2.5.7"
                "0nzghdv0kcksyvri0npxbjzyx2ihprks5k590y77bld355m17g08"))

(define rust-usvg-0.49.0
  (crate-source "usvg" "0.49.0"
                "0b7jzk3sazi7zyv7axj3iq9fn5kv6h7h1ngzsw53j7b4hgp776yh"))

(define rust-utf8-iter-1.0.4
  (crate-source "utf8_iter" "1.0.4"
                "1gmna9flnj8dbyd8ba17zigrp9c4c3zclngf5lnb5yvz1ri41hdn"))

(define rust-utf8parse-0.2.2
  (crate-source "utf8parse" "0.2.2"
                "088807qwjq46azicqwbhlmzwrbkz7l4hpw43sdkdyyk524vdxaq6"))

(define rust-version-check-0.9.5
  (crate-source "version_check" "0.9.5"
                "0nhhi4i5x89gm911azqbn7avs9mdacw2i3vcz3cnmz3mv4rqz4hb"))

(define rust-wasi-0.11.1+wasi-snapshot-preview1
  (crate-source "wasi" "0.11.1+wasi-snapshot-preview1"
                "0jx49r7nbkbhyfrfyhz0bm4817yrnxgd3jiwwwfv0zl439jyrwyc"))

(define rust-wasip2-1.0.4+wasi-0.2.12
  (crate-source "wasip2" "1.0.4+wasi-0.2.12"
                "11wl7lqwq4pbmlmzr6n7bwz0hzy1z6sxc4554bkmrr86w4vznzmn"))

(define rust-wasm-bindgen-0.2.129
  (crate-source "wasm-bindgen" "0.2.129"
                "02flhqld01jqb6vbfyx1gb8s78g1pnq2164daxad93y6mhrlzdcv"))

(define rust-wasm-bindgen-macro-0.2.129
  (crate-source "wasm-bindgen-macro" "0.2.129"
                "0dc5xq09sy1v9ns1fhb0cnyqz5p1wcjjvkdmxskj9qhnbg1x0a9f"))

(define rust-wasm-bindgen-macro-support-0.2.129
  (crate-source "wasm-bindgen-macro-support" "0.2.129"
                "1dx6w90f14avmhri7ss9lyz03060g6475r4axy3bm7biqf5ill3g"))

(define rust-wasm-bindgen-shared-0.2.129
  (crate-source "wasm-bindgen-shared" "0.2.129"
                "1ilmp5d3sl8lrq9djhcs90gk66yvk8mgwk4sfrvpvkd75b2wkw13"))

(define rust-weedle2-5.0.0
  (crate-source "weedle2" "5.0.0"
                "03mf9r8py0za38jh35ww3lgvd0lxky2hhy26z7d8g6h9xhj2r3cr"))

(define rust-weezl-0.1.12
  (crate-source "weezl" "0.1.12"
                "122a1dhha6cib5az4ihcqlh60ns2bi6rskdv875p94lbvj6wk2m2"))

(define rust-windows-core-0.62.2
  (crate-source "windows-core" "0.62.2"
                "1swxpv1a8qvn3bkxv8cn663238h2jccq35ff3nsj61jdsca3ms5q"))

(define rust-windows-implement-0.60.2
  (crate-source "windows-implement" "0.60.2"
                "1psxhmklzcf3wjs4b8qb42qb6znvc142cb5pa74rsyxm1822wgh5"))

(define rust-windows-interface-0.59.3
  (crate-source "windows-interface" "0.59.3"
                "0n73cwrn4247d0axrk7gjp08p34x1723483jxjxjdfkh4m56qc9z"))

(define rust-windows-link-0.2.1
  (crate-source "windows-link" "0.2.1"
                "1rag186yfr3xx7piv5rg8b6im2dwcf8zldiflvb22xbzwli5507h"))

(define rust-windows-result-0.4.1
  (crate-source "windows-result" "0.4.1"
                "1d9yhmrmmfqh56zlj751s5wfm9a2aa7az9rd7nn5027nxa4zm0bp"))

(define rust-windows-strings-0.5.1
  (crate-source "windows-strings" "0.5.1"
                "14bhng9jqv4fyl7lqjz3az7vzh8pw0w4am49fsqgcz67d67x0dvq"))

(define rust-windows-sys-0.61.2
  (crate-source "windows-sys" "0.61.2"
                "1z7k3y9b6b5h52kid57lvmvm05362zv1v8w0gc7xyv5xphlp44xf"))

(define rust-winnow-0.5.40
  (crate-source "winnow" "0.5.40"
                "0xk8maai7gyxda673mmw3pj1hdizy5fpi7287vaywykkk19sk4zm"))

(define rust-winnow-0.7.15
  (crate-source "winnow" "0.7.15"
                "0i9rkl2rqpbnnxlgs20gmkj3nd0b2k8q55mjmpc2ybb84xwxjyfz"))

(define rust-winnow-1.0.4
  (crate-source "winnow" "1.0.4"
                "10fzxipa7lx16172p3aca9j60hzbqgjki2f95kqksd5qywcp7f93"))

(define rust-wit-bindgen-0.57.1
  (crate-source "wit-bindgen" "0.57.1"
                "0vjk2jb593ri9k1aq4iqs2si9mrw5q46wxnn78im7hm7hx799gqy"))

(define rust-writeable-0.6.4
  (crate-source "writeable" "0.6.4"
                "1p3r4s4wbf3dksfpj3xyrn7id5p0f7r74mj6qx6ngjfd6cm2vn1s"))

(define rust-wyz-0.5.1
  (crate-source "wyz" "0.5.1"
                "1vdrfy7i2bznnzjdl9vvrzljvs4s3qm8bnlgqwln6a941gy61wq5"))

(define rust-xmlwriter-0.1.0
  (crate-source "xmlwriter" "0.1.0"
                "1fg0ldmkgiis6hnxpi1c9gy7v23y0lpi824bp8yp12fi3r82lypc"))

(define rust-yoke-0.8.4
  (crate-source "yoke" "0.8.4"
                "1cs06ci8h7pdhr3wzwrnslmc0cb9fhd571awsbdvf063yvyg6zj1"))

(define rust-yoke-derive-0.8.4
  (crate-source "yoke-derive" "0.8.4"
                "0wbdvvdv9birwxrr9ynxj0k7as0f0ci7ihhck34yi09nvgibv3pc"))

(define rust-zerofrom-0.1.8
  (crate-source "zerofrom" "0.1.8"
                "0wjjdj7gdmd0iq91gzkxl7dlv0nhkk80l4bmdpzh3a1yh48mmh0f"))

(define rust-zerofrom-derive-0.1.8
  (crate-source "zerofrom-derive" "0.1.8"
                "0jhdy4p9c6ja3dynsdck14g2iilq8ai5ch6nsi455x67ys1lcnzp"))

(define rust-zeroize-1.9.0
  (crate-source "zeroize" "1.9.0"
                "0kpnij2v1ig6g2mhc0bnci0lrdfdhiq40afbc0fahajqc9jiag71"))

(define rust-zeroize-derive-1.5.0
  (crate-source "zeroize_derive" "1.5.0"
                "0a7kq8srk81pn23xqn7c9jw1jpnfy41ffn802x1zrqqgpdf6al1w"))

(define rust-zerotrie-0.2.5
  (crate-source "zerotrie" "0.2.5"
                "0gss16krjzk22m57dz5hkdjg99ibj6pa41qr68na7w1jpp1nk8jf"))

(define rust-zerovec-0.11.9
  (crate-source "zerovec" "0.11.9"
                "0h3amsfmvqx93grkpy576z5r7nwfxx9bvvd8gq66g8g9rycjg2pm"))

(define rust-zerovec-derive-0.11.7
  (crate-source "zerovec-derive" "0.11.7"
                "0ypr1gq2nvb4mvwawcgyknbn408dsjcy3qhsrllxjf3pykdksx63"))

(define rust-zmij-1.0.23
  (crate-source "zmij" "1.0.23"
                "06zwri21nnrl34rwinmvbciap8yk1mrl8qfg9pff7lgspc56sri9"))

(define rust-zune-core-0.5.1
  (crate-source "zune-core" "0.5.1"
                "1ya0zdqxlr5v57791j7bvm408ri2cfx81a4v6z85f560yw3hi2nb"))

(define rust-zune-jpeg-0.5.15
  (crate-source "zune-jpeg" "0.5.15"
                "15kjpn6pywxlwb8w5irfd68x31wi3mb4y1da8bqh7havh5drvg17"))


(define-cargo-inputs lookup-cargo-inputs
  (resvg =>
         (list rust-adler2-2.0.1
               rust-arrayref-0.3.9
               rust-arrayvec-0.7.8
               rust-autocfg-1.5.1
               rust-base64-0.23.0
               rust-bitflags-2.13.1
               rust-bytemuck-1.25.2
               rust-bytemuck-derive-1.11.0
               rust-byteorder-lite-0.1.0
               rust-cfg-if-1.0.4
               rust-color-quant-1.1.0
               rust-crc32fast-1.5.0
               rust-data-url-0.3.2
               rust-euclid-0.22.14
               rust-fdeflate-0.3.7
               rust-flate2-1.1.9
               rust-float-cmp-0.9.0
               rust-font-types-0.12.1
               rust-fontconfig-parser-0.5.8
               rust-fontdb-0.24.0
               rust-gif-0.14.2
               rust-harfrust-0.12.0
               rust-image-webp-0.2.4
               rust-imagesize-0.15.0
               rust-kurbo-0.13.1
               rust-libc-0.2.189
               rust-log-0.4.33
               rust-memchr-2.8.3
               rust-memmap2-0.9.11
               rust-miniz-oxide-0.8.9
               rust-num-traits-0.2.19
               rust-once-cell-1.21.4
               rust-pico-args-0.5.0
               rust-png-0.18.1
               rust-polycool-0.4.0
               rust-proc-macro2-1.0.107
               rust-quick-error-2.0.1
               rust-quote-1.0.47
               rust-read-fonts-0.41.0
               rust-rgb-0.8.53
               rust-roxmltree-0.20.0
               rust-roxmltree-0.21.1
               rust-simd-adler32-0.3.10
               rust-simplecss-0.2.2
               rust-siphasher-1.0.3
               rust-skrifa-0.44.0
               rust-slotmap-1.1.1
               rust-smallvec-1.15.2
               rust-strict-num-0.1.1
               rust-svgtypes-0.16.1
               rust-syn-2.0.119
               rust-tiny-skia-0.12.0
               rust-tiny-skia-path-0.12.0
               rust-tinyvec-1.12.0
               rust-tinyvec-macros-0.1.1
               rust-unicode-bidi-0.3.18
               rust-unicode-ident-1.0.24
               rust-unicode-script-0.5.8
               rust-unicode-vo-0.1.0
               rust-usvg-0.49.0
               rust-version-check-0.9.5
               rust-weezl-0.1.12
               rust-xmlwriter-0.1.0
               rust-zune-core-0.5.1
               rust-zune-jpeg-0.5.15))
  (tdesktop-rust =>
                 (list rust-aead-0.5.2
                       rust-aes-0.8.4
                       rust-android-system-properties-0.1.6
                       rust-anyhow-1.0.104
                       rust-arrayvec-0.7.8
                       rust-askama-0.16.1
                       rust-askama-derive-0.16.1
                       rust-askama-macros-0.16.1
                       rust-askama-parser-0.16.1
                       rust-async-trait-0.1.89
                       rust-autocfg-1.5.1
                       rust-base64-0.22.1
                       rust-base64ct-1.8.3
                       rust-basic-toml-0.1.10
                       rust-bitflags-2.13.2
                       rust-bitstream-io-4.10.0
                       rust-bitvec-1.1.1
                       rust-block-buffer-0.10.4
                       rust-bnum-0.12.1
                       rust-bumpalo-3.20.3
                       rust-bytes-1.12.1
                       rust-camino-1.2.6
                       rust-cargo-metadata-0.23.1
                       rust-cargo-platform-0.3.3
                       rust-cc-1.10.0
                       rust-cfg-if-1.0.5
                       rust-chrono-0.4.45
                       rust-cipher-0.4.4
                       rust-const-oid-0.9.6
                       rust-convert-case-0.11.0
                       rust-core-foundation-sys-0.8.7
                       rust-cpufeatures-0.2.17
                       rust-crc-3.4.0
                       rust-crc-catalog-2.5.0
                       rust-crypto-box-0.9.1
                       rust-crypto-common-0.1.7
                       rust-crypto-secretbox-0.1.1
                       rust-curve25519-dalek-4.1.3
                       rust-curve25519-dalek-derive-0.1.1
                       rust-deluxe-0.5.0
                       rust-deluxe-core-0.5.0
                       rust-deluxe-macros-0.5.0
                       rust-der-0.7.10
                       rust-digest-0.10.7
                       rust-displaydoc-0.2.7
                       rust-ed25519-2.2.3
                       rust-ed25519-dalek-2.2.0
                       rust-equivalent-1.0.3
                       rust-errno-0.3.14
                       rust-fastnum-0.7.5
                       rust-fastrand-2.5.0
                       rust-fiat-crypto-0.2.9
                       rust-find-msvc-tools-0.1.15
                       rust-form-urlencoded-1.2.2
                       rust-fs-err-3.3.2
                       rust-funty-2.0.0
                       rust-futures-0.3.31
                       rust-futures-channel-0.3.34
                       rust-futures-core-0.3.34
                       rust-futures-executor-0.3.34
                       rust-futures-io-0.3.34
                       rust-futures-macro-0.3.34
                       rust-futures-sink-0.3.34
                       rust-futures-task-0.3.34
                       rust-futures-util-0.3.34
                       rust-generic-array-0.14.7
                       rust-getrandom-0.2.17
                       rust-getrandom-0.3.4
                       rust-getrandom-0.4.3
                       rust-glob-0.3.4
                       rust-goblin-0.8.2
                       rust-hashbrown-0.17.1
                       rust-heck-0.4.1
                       rust-heck-0.5.0
                       rust-hex-0.4.3
                       rust-hmac-0.12.1
                       rust-iana-time-zone-0.1.65
                       rust-iana-time-zone-haiku-0.1.2
                       rust-icu-collections-2.4.0
                       rust-icu-locale-core-2.4.0
                       rust-icu-normalizer-2.4.0
                       rust-icu-normalizer-data-2.4.0
                       rust-icu-properties-2.4.0
                       rust-icu-properties-data-2.4.0
                       rust-icu-provider-2.4.0
                       rust-idna-1.1.0
                       rust-idna-adapter-1.2.2
                       rust-if-chain-1.0.3
                       rust-indexmap-2.14.2
                       rust-inout-0.1.4
                       rust-itoa-1.0.18
                       rust-js-sys-0.3.106
                       rust-libc-0.2.191
                       rust-libm-0.2.16
                       rust-linux-raw-sys-0.12.1
                       rust-litemap-0.8.3
                       rust-lock-api-0.4.14
                       rust-log-0.4.34
                       rust-memchr-2.8.3
                       rust-minimal-lexical-0.2.1
                       rust-no-std-io2-0.9.4
                       rust-nom-7.1.3
                       rust-num-bigint-0.4.8
                       rust-num-integer-0.1.47
                       rust-num-traits-0.2.19
                       rust-once-cell-1.21.4
                       rust-opaque-debug-0.3.1
                       rust-ordered-float-2.10.1
                       rust-parking-lot-0.12.5
                       rust-parking-lot-core-0.9.12
                       rust-password-hash-0.5.0
                       rust-pbkdf2-0.12.2
                       rust-percent-encoding-2.3.2
                       rust-pin-project-lite-0.2.17
                       rust-pkcs8-0.10.2
                       rust-plain-0.2.3
                       rust-poly1305-0.8.0
                       rust-potential-utf-0.1.6
                       rust-proc-macro2-1.0.107
                       rust-proc-macro-crate-1.3.1
                       rust-proc-macro-crate-3.5.0
                       rust-quote-1.0.47
                       rust-r-efi-5.3.0
                       rust-r-efi-6.0.0
                       rust-radium-0.7.0
                       rust-rand-core-0.6.4
                       rust-redox-syscall-0.5.18
                       rust-rustc-hash-2.1.3
                       rust-rustc-version-0.4.1
                       rust-rustix-1.1.6
                       rust-rustversion-1.0.23
                       rust-salsa20-0.10.2
                       rust-scopeguard-1.2.0
                       rust-scroll-0.12.0
                       rust-scroll-derive-0.12.1
                       rust-semver-1.0.28
                       rust-serde-1.0.229
                       rust-serde-aux-4.7.0
                       rust-serde-core-1.0.229
                       rust-serde-derive-1.0.229
                       rust-serde-json-1.0.151
                       rust-serde-spanned-1.1.2
                       rust-serde-value-0.7.0
                       rust-sha2-0.10.9
                       rust-shlex-2.0.1
                       rust-signature-2.2.0
                       rust-siphasher-1.0.4
                       rust-slab-0.4.12
                       rust-smallvec-1.16.4
                       rust-smawk-0.3.3
                       rust-spki-0.7.3
                       rust-stable-deref-trait-1.2.1
                       rust-static-assertions-1.1.0
                       rust-strsim-0.10.0
                       rust-subtle-2.6.1
                       rust-syn-2.0.119
                       rust-syn-3.0.9
                       rust-synstructure-0.14.0
                       rust-tap-1.0.1
                       rust-tempfile-3.27.0
                       rust-textwrap-0.16.4
                       rust-thiserror-2.0.17
                       rust-thiserror-impl-2.0.17
                       rust-tinystr-0.8.5
                       rust-toml-1.1.8+spec-1.1.0
                       rust-toml-datetime-0.6.11
                       rust-toml-datetime-1.1.2+spec-1.1.0
                       rust-toml-edit-0.19.15
                       rust-toml-edit-0.25.17+spec-1.1.0
                       rust-toml-parser-1.1.5+spec-1.1.0
                       rust-toml-writer-1.1.3+spec-1.1.0
                       rust-ton-core-0.1.4
                       rust-ton-macros-0.1.2
                       rust-typenum-1.20.1
                       rust-unicode-ident-1.0.27
                       rust-unicode-segmentation-1.13.3
                       rust-unicode-width-0.2.3
                       rust-uniffi-0.32.0
                       rust-uniffi-bindgen-0.32.0
                       rust-uniffi-core-0.32.0
                       rust-uniffi-internal-macros-0.32.0
                       rust-uniffi-macros-0.32.0
                       rust-uniffi-meta-0.32.0
                       rust-uniffi-pipeline-0.32.0
                       rust-uniffi-udl-0.32.0
                       rust-universal-hash-0.5.1
                       rust-url-2.5.7
                       rust-utf8-iter-1.0.4
                       rust-version-check-0.9.5
                       rust-wasi-0.11.1+wasi-snapshot-preview1
                       rust-wasip2-1.0.4+wasi-0.2.12
                       rust-wasm-bindgen-0.2.129
                       rust-wasm-bindgen-macro-0.2.129
                       rust-wasm-bindgen-macro-support-0.2.129
                       rust-wasm-bindgen-shared-0.2.129
                       rust-weedle2-5.0.0
                       rust-windows-core-0.62.2
                       rust-windows-implement-0.60.2
                       rust-windows-interface-0.59.3
                       rust-windows-link-0.2.1
                       rust-windows-result-0.4.1
                       rust-windows-strings-0.5.1
                       rust-windows-sys-0.61.2
                       rust-winnow-0.5.40
                       rust-winnow-1.0.4
                       rust-wit-bindgen-0.57.1
                       rust-writeable-0.6.4
                       rust-wyz-0.5.1
                       rust-yoke-0.8.4
                       rust-yoke-derive-0.8.4
                       rust-zerofrom-0.1.8
                       rust-zerofrom-derive-0.1.8
                       rust-zeroize-1.9.0
                       rust-zeroize-derive-1.5.0
                       rust-zerotrie-0.2.5
                       rust-zerovec-0.11.9
                       rust-zerovec-derive-0.11.7
                       rust-zmij-1.0.23))
  (uniffi-bindgen-cpp =>
                      (list rust-anstream-1.0.0
                            rust-anstyle-1.0.14
                            rust-anstyle-parse-1.0.0
                            rust-anstyle-query-1.1.5
                            rust-anstyle-wincon-3.0.11
                            rust-anyhow-1.0.104
                            rust-askama-0.13.1
                            rust-askama-0.16.0
                            rust-askama-derive-0.13.1
                            rust-askama-derive-0.16.0
                            rust-askama-macros-0.16.0
                            rust-askama-parser-0.13.0
                            rust-askama-parser-0.16.0
                            rust-autocfg-1.5.1
                            rust-basic-toml-0.1.10
                            rust-bitflags-2.13.1
                            rust-camino-1.2.5
                            rust-cargo-metadata-0.23.1
                            rust-cargo-platform-0.3.3
                            rust-cfg-if-1.0.4
                            rust-clap-4.6.6
                            rust-clap-builder-4.6.6
                            rust-clap-derive-4.6.4
                            rust-clap-lex-1.1.0
                            rust-colorchoice-1.0.5
                            rust-equivalent-1.0.2
                            rust-errno-0.3.14
                            rust-fastrand-2.5.0
                            rust-fs-err-3.3.1
                            rust-getrandom-0.4.3
                            rust-glob-0.3.4
                            rust-goblin-0.8.2
                            rust-hashbrown-0.17.1
                            rust-heck-0.4.1
                            rust-heck-0.5.0
                            rust-indexmap-2.14.0
                            rust-is-terminal-polyfill-1.70.2
                            rust-itoa-1.0.18
                            rust-libc-0.2.189
                            rust-linux-raw-sys-0.12.1
                            rust-log-0.4.33
                            rust-memchr-2.8.3
                            rust-minimal-lexical-0.2.1
                            rust-nom-7.1.3
                            rust-once-cell-1.21.4
                            rust-once-cell-polyfill-1.70.2
                            rust-paste-1.0.15
                            rust-percent-encoding-2.3.2
                            rust-plain-0.2.3
                            rust-proc-macro2-1.0.107
                            rust-quote-1.0.47
                            rust-r-efi-6.0.0
                            rust-rustc-hash-2.1.3
                            rust-rustix-1.1.4
                            rust-scroll-0.12.0
                            rust-scroll-derive-0.12.1
                            rust-semver-1.0.28
                            rust-serde-1.0.229
                            rust-serde-core-1.0.229
                            rust-serde-derive-1.0.229
                            rust-serde-json-1.0.151
                            rust-serde-spanned-1.1.1
                            rust-siphasher-1.0.3
                            rust-smawk-0.3.3
                            rust-strsim-0.11.1
                            rust-syn-2.0.119
                            rust-syn-3.0.3
                            rust-tempfile-3.27.0
                            rust-textwrap-0.16.2
                            rust-thiserror-2.0.20
                            rust-thiserror-impl-2.0.20
                            rust-toml-1.1.4+spec-1.1.0
                            rust-toml-datetime-1.1.1+spec-1.1.0
                            rust-toml-parser-1.1.3+spec-1.1.0
                            rust-toml-writer-1.1.2+spec-1.1.0
                            rust-topological-sort-0.2.2
                            rust-unicode-ident-1.0.24
                            rust-unicode-linebreak-0.1.5
                            rust-unicode-width-0.2.2
                            rust-uniffi-bindgen-0.32.0
                            rust-uniffi-internal-macros-0.32.0
                            rust-uniffi-meta-0.32.0
                            rust-uniffi-pipeline-0.32.0
                            rust-uniffi-udl-0.32.0
                            rust-utf8parse-0.2.2
                            rust-weedle2-5.0.0
                            rust-windows-link-0.2.1
                            rust-windows-sys-0.61.2
                            rust-winnow-0.7.15
                            rust-winnow-1.0.4
                            rust-zmij-1.0.23)))
