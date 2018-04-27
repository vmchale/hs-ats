let prelude = https://raw.githubusercontent.com/vmchale/atspkg/master/dhall/atspkg-prelude.dhall

in λ(x : List Integer) →
  prelude.makeHsPkg { x = x, name = "fast-arithmetic" }
    ⫽ { libDeps = prelude.mapPlainDeps [ "atscntrb-hx-intinf" ], description = [ "Library for number theory & combinatorics in ATS" ] : Optional Text }
