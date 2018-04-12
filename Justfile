ci:
    cabal new-build all
    cabal new-test fast-arithmetic
    hlint fast-arithmetic gmpint
    yamllint .stylish-haskell.yaml
    yamllint .hlint.yaml
    yamllint .travis.yml
    yamllint stack.yaml
    stack build && weeder .
