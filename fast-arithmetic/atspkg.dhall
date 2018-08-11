{- Imports -}
let prelude = http://hackage.haskell.org/package/ats-pkg/src/dhall/atspkg-prelude.dhall
in

let map = http://hackage.haskell.org/package/dhall/src/Prelude/List/map
in

let not = http://hackage.haskell.org/package/dhall/src/Prelude/Bool/not
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
  ["combinatorics", "number-theory", "numerics" ]
in

{- Main -}
λ(cfg : { sourceBld : Bool, withBench : Bool, icc : Bool }) →

    let test = if cfg.withBench
    then
        [ prelude.bin ⫽
            { src = "ats-src/bench.dats"
            , target = "target/bench"
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
            [ prelude.staticLib ⫽
                { name = "numbertheory"
                , src = (map Text Text asDats moduleNames)
                , includes = [ "include/fast_arithmetic.h" ]
                , libTarget = "${prelude.cabalDir}/libnumbertheory.a"
                }
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

    let cc =
        if cfg.icc
            then prelude.icc
            else prelude.cc
    in

    prelude.default ⫽
        { atsSource = atsSource
        , test = test
        , libraries = libraries
        , dependencies = dependencies
        , cflags = libBuildFlag # (prelude.ccFlags cc)
        , ccompiler = prelude.printCompiler cc
        }
