let prelude = https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall
in

let map = https://ipfs.io/ipfs/QmQ8w5PLcsNz56dMvRtq54vbuPe9cNnCCUXAQp6xLc6Ccx/Prelude/List/map
in

let PreSrc = { atsSrc : Text, cTarget : Text }
in

let hsDatsSrc =
  λ(x : Text) → { atsSrc = "ats-src/${x}.dats", cTarget = "cbits/${x}.c" }
in

let mapDatsSrc =
  λ(x : List Text) → map Text PreSrc hsDatsSrc x
in

prelude.default ⫽
  { atsSource = prelude.mapSrc
      (mapDatsSrc ["combinatorics", "number-theory", "numerics" ])
  , test =
    [ prelude.bin ⫽
      { src = "ats-src/bench.dats"
      , target = "../dist-newstyle/build/bench"
      , libs = [ "gmp" ]
      }
    ]
  , dependencies = prelude.mapPlainDeps [ "atscntrb-hx-intinf", "ats-includes", "ats-bench" ]
  }
