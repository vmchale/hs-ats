{- Imports -}
let prelude = https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall
in

let map = https://ipfs.io/ipfs/QmQ8w5PLcsNz56dMvRtq54vbuPe9cNnCCUXAQp6xLc6Ccx/Prelude/List/map
in

let not = https://ipfs.io/ipfs/QmQ8w5PLcsNz56dMvRtq54vbuPe9cNnCCUXAQp6xLc6Ccx/Prelude/Bool/not
in

{- Types -}
let PreSrc = { atsSrc : Text, cTarget : Text }
in

{- Configuration variables -}
let sourceBld = True
in

let withBench = True
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

{- Build components -}
let atsSource = if sourceBld
  then
    prelude.mapSrc
      (mapDatsSrc moduleNames)
  else
    prelude.emptySrc
in

let test = if withBench
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

let libraries = if not sourceBld
  then
    [ prelude.staticLib ⫽
      { name = "numbertheory"
      , src = (map Text Text asDats moduleNames)
      , libTarget = "${prelude.cabalDir}/libnumbertheory.a"
      }
    ]
  else
    prelude.emptyLib
in

let dependencies = prelude.mapPlainDeps
  ([ "atscntrb-hx-intinf" ]
   # (if sourceBld then [ "ats-includes" ] else [] : List Text)
   # (if withBench then [ "ats-bench" ] else [] : List Text))
in

{- Main -}
prelude.default ⫽
  { atsSource = atsSource
  , test = test
  , libraries = libraries
  , dependencies = dependencies
  }
