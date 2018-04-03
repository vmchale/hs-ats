let prelude = https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall
in

prelude.default ⫽
  { libraries =
    [
      prelude.lib ⫽ 
      { name = "storable"
      , src = [ "ats-src/combinatorics.dats", "ats-src/number-theory.dats", "ats-src/numerics.dats" ]
      , libTarget = "dist-newstyle/lib/libnumbertheory.a"
      , static = True
      }
    ]
  , compiler = [0,3,10]
  , dependencies = prelude.mapPlainDeps [ "atscntrb-hx-intinf" ]
  }
