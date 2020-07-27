let prelude =
      https://hackage.haskell.org/package/ats-pkg/src/dhall/atspkg-prelude.dhall

in  λ(x : List Natural) →
        prelude.makeHsPkg { x, name = "fast-arithmetic" }
      ⫽ { libDeps = prelude.mapPlainDeps [ "atscntrb-hx-intinf" ]
        , description = Some "Library for number theory & combinatorics in ATS"
        }
