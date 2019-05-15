let prelude = https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall

in λ(x : List Natural) →
  prelude.makeHsPkg { x = x, name = "fast-arithmetic" }
    ⫽ { libDeps = prelude.mapPlainDeps [ "atscntrb-hx-intinf" ], description = [ "Library for number theory & combinatorics in ATS" ] : Optional Text }
