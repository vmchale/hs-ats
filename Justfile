bundle:
    duma https://downloads.sourceforge.net/project/ats2-lang/ats2-lang/ats2-postiats-0.3.8/ATS2-Postiats-include-0.3.8.tgz
    tar xvf ATS2-Postiats-include-0.3.8.tgz

ci:
    cabal new-build
    cabal new-haddock
    cabal new-test
    hlint src bench test/Spec.hs
    tomlcheck --file .atsfmt.toml
    yamllint .travis.yml
    yamllint .hlint.yaml
    yamllint .stylish-haskell.yaml
    yamllint .yamllint
    stack build --test --bench --no-run-tests --no-run-benchmarks
    weeder
