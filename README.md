# fast-arithmetic

[![Build Status](https://travis-ci.org/vmchale/fast-arithmetic.svg?branch=master)](https://travis-ci.org/vmchale/fast-arithmetic)

This is a library for fast arithmetical functions using ATS, with a Haskell
wrapper.

It is intended to supplement (but not replace)
[arithmoi](https://hackage.haskell.org/package/arithmoi) and
[combinat](https://hackage.haskell.org/package/combinat) where speed is
important. In particular, this library provides a fast primality check and fast
computation of basic combinatorial functions.

## Benchmarks

| Computation | Version (ATS/Haskell) | Time |
| ----------- | --------------------- | ---- |
| `isPrime 2017` | ATS | 118.9 ns |
| `isPrime 2017` | Haskell | 497.3 ns |
| `φ(2016)` | ATS | - |
| `φ(2016)` | Haskell | - |
| `τ(3018)` | ATS | - |
| `τ(3018)` | Haskell | - |
| `ω(91)` | ATS | 66.59 ns |
| `ω(91)` | Haskell | 338.6 ns |
| `160!` | ATS | 4.081 μs |
| `160!` | Haskell | 6.032 μs |
| `79!!` | ATS | 813.8 ns ns |
| `79!!` | Haskell | 1.395 μs |
| ``322 `choose` 16`` | ATS | 629.8 ns |
| ``322 `choose` 16`` | Haskell | 1.046 μs |

## Building

The Haskell library comes with the C bundled, however you will likely want to build from
source if you are hacking on the library. To that end, you can install
[stack](http://haskellstack.org/), [patsopt](http://www.ats-lang.org/Downloads.html), and
[pats-filter](https://github.com/Hibou57/PostiATS-Utilities) and build with

```bash
 $ ./shake.hs
```

You will also likely want to install
[GHC](https://www.haskell.org/ghc/download.html) as well as
[cabal](https://www.haskell.org/cabal/).

## Documentation

You can find documentation for the Haskell library on 
[Hackage](https://hackage.haskell.org/package/fast-arithmetic/).
Unfortunately, there is no documentation for the ATS library, however,
the bundled source code is commented.
