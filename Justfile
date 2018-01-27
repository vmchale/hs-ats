test ARGUMENT:
    @cabal new-build
    dist-newstyle/build/x86_64-linux/ghc-8.2.2/fast-arithmetic-0.3.2.0/opt/build/fast-arithmetic-test/fast-arithmetic-test --ignore-dot-hspec -m {{ ARGUMENT }}

bench ARGUMENT:
    @cabal new-build
    dist-newstyle/build/x86_64-linux/ghc-8.2.2/fast-arithmetic-0.3.2.0/opt/build/fast-arithmetic-bench/fast-arithmetic-bench -m pattern {{ ARGUMENT }}
