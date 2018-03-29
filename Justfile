ci:
    cabal new-build all
    cabal new-test all -w ghc-8.2.2
    hlint .
    yamllint .stylish-haskell.yaml
    yamllint .hlint.yaml
    yamllint .travis.yml
    yamllint stack.yaml
