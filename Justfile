ci:
    cd fast-arithmetic && cabal new-build
    hlint fast-arithmetic gmpint
    yamllint .stylish-haskell.yaml
    yamllint .hlint.yaml
    yamllint .travis.yml
    yamllint stack.yaml
    stack build && weeder .
