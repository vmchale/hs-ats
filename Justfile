ci:
    cabal new-build all
    cd fast-arithmetic && cabal new-test
    stack build --test --no-run-tests --bench --no-run-benchmarks
    hlint .
    weeder .
    yamllint .stylish-haskell.yaml
    yamllint .hlint.yaml
    yamllint .travis.yml
    yamllint stack.yaml
