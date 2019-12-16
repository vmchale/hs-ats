{- Imports -}
let prelude =
      https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall sha256:33e41e509b6cfd0b075d1a8a5210ddfd1919372f9d972c2da783c6187d2298ba

let map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/9f259cd68870b912fbf2f2a08cd63dc3ccba9dc3/Prelude/List/map sha256:dd845ffb4568d40327f2a817eb42d1c6138b929ca758d50bc33112ef3c885680

let not =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/9f259cd68870b912fbf2f2a08cd63dc3ccba9dc3/Prelude/Bool/not sha256:723df402df24377d8a853afed08d9d69a0a6d86e2e5b2bac8960b0d4756c7dc4

let PreSrc = { atsSrc : Text, cTarget : Text }

let asDats = λ(x : Text) → "ats-src/${x}.dats"

let hsDatsSrc = λ(x : Text) → { atsSrc = asDats x, cTarget = "cbits/${x}.c" }

let mapDatsSrc = λ(x : List Text) → map Text PreSrc hsDatsSrc x

let moduleNames = [ "combinatorics", "number-theory", "numerics" ]

in    λ(cfg : { sourceBld : Bool, staticLib : Bool, withBench : Bool })
    → let test =
                  if cfg.withBench

            then  [   prelude.bin
                    ⫽ { src = "ats-src/bench.dats"
                      , target = "${prelude.atsProject}/bench"
                      , libs = [ "gmp" ]
                      , gcBin = True
                      }
                  ]

            else  prelude.emptyBin

      let atsSource =
                  if cfg.sourceBld

            then  prelude.mapSrc (mapDatsSrc moduleNames)

            else  prelude.emptySrc

      let libraries =
                  if not cfg.sourceBld

            then  let libCommon =
                        { name = "numbertheory"
                        , src = map Text Text asDats moduleNames
                        , includes = [ "include/fast_arithmetic.h" ]
                        }

                  in        if cfg.staticLib

                      then  [   prelude.staticLib
                              ⫽ libCommon
                              ⫽ { libTarget =
                                    "${prelude.atsProject}/libnumbertheory.a"
                                }
                            ]

                      else  [   prelude.lib
                              ⫽ libCommon
                              ⫽ { libTarget =
                                    "${prelude.atsProject}/libnumbertheory.so"
                                }
                            ]

            else  prelude.emptyLib

      let dependencies =
            prelude.mapPlainDeps
              (   [ "atscntrb-hx-intinf" ]
                # (if cfg.sourceBld then [ "ats-includes" ] else [] : List Text)
                # (if cfg.withBench then [ "ats-bench" ] else [] : List Text)
              )

      let libBuildFlag =
            if cfg.sourceBld then [] : List Text else [ "-DLIBRARY_BUILD" ]

      let cc = prelude.cc

      in    prelude.default
          ⫽ { atsSource = atsSource
            , test = test
            , libraries = libraries
            , dependencies = dependencies
            , cflags = libBuildFlag # prelude.ccFlags cc
            , ccompiler = prelude.printCompiler cc
            , debPkg =
                prelude.mkDeb
                  (   prelude.debian "fast-arithmetic"
                    ⫽ { version = [ 0, 6, 4, 1 ]
                      , maintainer = "Vanessa McHale <vamchale@gmail.com>"
                      , description = "Library for fast arithmetic in ATS"
                      , libraries =
                          [ "${prelude.atsProject}/libnumbertheory.a" ]
                      , headers = [ "include/fast_arithmetic.h" ]
                      }
                  )
            }
