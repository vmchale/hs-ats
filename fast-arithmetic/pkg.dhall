let prelude =
      https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall

in  λ(x : List Natural) →
        prelude.makeHsPkg { x, name = "fast-arithmetic" }
      ⫽ { libDeps = prelude.mapPlainDeps [ "atscntrb-hx-intinf" ]
        , description = Some "Library for number theory & combinatorics in ATS"
        }
