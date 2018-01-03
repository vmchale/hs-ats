# fast-combinatorics

[![Build Status](https://travis-ci.org/vmchale/fast-combinatorics.svg?branch=master)](https://travis-ci.org/vmchale/fast-combinatorics)

This is a library for fast arithmetical functions using ATS, with a Haskell
wrapper.

It is intended to supplement (but not replace)
[arithmoi](https://hackage.haskell.org/package/arithmoi) where speed is
important. In particular, it provides a fast primality checking function and
a slightly faster GCD function.

## Benchmarks

| Computation | Version (ATS/Haskell) | Time |
| ----------- | --------------------- | ---- |
| `isPrime 2017` | ATS | 118.9 ns |
| `isPrime 2017` | Haskell | 497.3 ns |
| `φ(2016)` | ATS | 5.574 μs |
| `φ(2016)` | Haskell | 177.3 μs |
| `τ(3018)` | ATS | 7.962 μs |
| `τ(3018)` | Haskell | 35.87 μs |
| `ω(91)` | ATS | 282.1 ns |
| `ω(91)` | Haskell | 1.194 μs |
| `gcd(201, 67)` | ATS | 8.848 ns |
| `gcd(201, 67)` | Haskell | 11.26 ns |

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
Unfortunately, there is no documentation for the ATS library, however, you may
find the bundled source code informative.
