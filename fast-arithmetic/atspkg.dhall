{- Imports -}
let prelude = http://hackage.haskell.org/package/ats-pkg/src/dhall/atspkg-prelude.dhall
in

let map = https://raw.githubusercontent.com/dhall-lang/dhall-lang/master/Prelude/List/map
in

let not = https://raw.githubusercontent.com/dhall-lang/dhall-lang/master/Prelude/Bool/not
in

{- Types -}
let PreSrc = { atsSrc : Text, cTarget : Text }
in

{- Helper functions -}
let asDats =
  λ(x : Text) → "ats-src/${x}.dats"
in

let hsDatsSrc =
  λ(x : Text) → { atsSrc = asDats x, cTarget = "cbits/${x}.c" }
in

let mapDatsSrc =
  λ(x : List Text) → map Text PreSrc hsDatsSrc x
in

let moduleNames =
  [ "combinatorics", "number-theory", "numerics" ]
in

{- Main -}
λ(cfg : { sourceBld : Bool, staticLib : Bool, withBench : Bool }) →

    let test = if cfg.withBench
    then
        [ prelude.bin ⫽
            { src = "ats-src/bench.dats"
            , target = "${prelude.atsProject}/bench"
            , libs = [ "gmp" ]
            , gcBin = True
            }
        ]
    else
        prelude.emptyBin
    in

    let atsSource = if cfg.sourceBld
        then
            prelude.mapSrc
            (mapDatsSrc moduleNames)
        else
            prelude.emptySrc
    in

    let libraries = if not cfg.sourceBld
        then
            let libCommon =
                { name = "numbertheory"
                , src = (map Text Text asDats moduleNames)
                , includes = [ "include/fast_arithmetic.h" ]
                }
            in

            if cfg.staticLib
                then
                    [ prelude.staticLib ⫽
                        libCommon ⫽
                        { libTarget = "${prelude.atsProject}/libnumbertheory.a" }
                    ]
                else
                    [ prelude.lib ⫽
                        libCommon ⫽
                        { libTarget = "${prelude.atsProject}/libnumbertheory.so" }
                    ]
        else
            prelude.emptyLib
    in

        let dependencies = prelude.mapPlainDeps
        ([ "atscntrb-hx-intinf" ]
            # (if cfg.sourceBld then [ "ats-includes" ] else [] : List Text)
            # (if cfg.withBench then [ "ats-bench" ] else [] : List Text))
    in

    let libBuildFlag =
        if cfg.sourceBld
            then ([] : List Text)
            else [ "-DLIBRARY_BUILD" ]
    in

    let cc = prelude.cc
    in

    prelude.default ⫽
        { atsSource = atsSource
        , test = test
        , libraries = libraries
        , dependencies = dependencies
        , cflags = libBuildFlag # (prelude.ccFlags cc)
        , ccompiler = prelude.printCompiler cc
        , debPkg = prelude.mkDeb
            (prelude.debian "fast-arithmetic" ⫽
                { version = [0,6,4,1]
                , maintainer = "Vanessa McHale <vamchale@gmail.com>"
                , description = "Library for fast arithmetic in ATS"
                , libraries = [ "${prelude.atsProject}/libnumbertheory.a" ]
                , headers = [ "include/fast_arithmetic.h" ]
                })
        }
