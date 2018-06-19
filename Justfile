poly:
    @rm -f fast-arithmetic/*.c
    @poly -e cbits

linguist:
    linguist

ci:
    cd fast-arithmetic && atspkg build
    cabal new-build all
    cabal new-test all
    hlint fast-arithmetic gmpint
    yamllint .stylish-haskell.yaml
    yamllint .hlint.yaml
    yamllint .travis.yml

bench:
    cd fast-arithmetic && bench "cdeps cbits/numerics.c -I .atspkg/contrib/ats-includes-0.3.10/ -I .atspkg/contrib/ats-includes-0.3.10/ccomp/runtime"

dump:
    @cd fast-arithmetic && cdeps cbits/numerics.c -I .atspkg/contrib/ats-includes-0.3.10/ -I .atspkg/contrib/ats-includes-0.3.10/ccomp/runtime
