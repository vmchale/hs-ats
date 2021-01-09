# fast-arithmetic

[![Build Status](https://travis-ci.org/vmchale/hs-ats.svg?branch=master)](https://travis-ci.org/vmchale/hs-ats)
[![Hackage](https://img.shields.io/hackage/v/fast-arithmetic.svg)](http://hackage.haskell.org/package/fast-arithmetic)
[![Dependencies of latest version on Hackage](https://img.shields.io/hackage-deps/v/fast-arithmetic.svg)](https://hackage.haskell.org/package/fast-arithmetic)

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
| `isPrime 2017` | ATS | 117.2 ns |
| `isPrime 2017` | Haskell | 425.0 ns |
| `φ(2016)` | ATS | 191.5 ns |
| `φ(2016)` | Haskell | 384.8 ns |
| `τ(3018)` | ATS | 337.0 ns |
| `τ(3018)` | Haskell | 660.2 ns |
| `σ(115)` | ATS | 45.41 ns |
| `σ(115)` | Haskell | 322.4 ns |
| `ω(91)` | ATS | 65.52 ns |
| `ω(91)` | Haskell | 345.2 ns |
| `160!` | ATS | 2.363 μs |
| `160!` | Haskell | 6.134μs |
| `79!!` | ATS | 556.2 ns |
| `79!!` | Haskell | 1.355 μs |
| ``322 `choose` 16`` | ATS | 467.6 ns |
| ``322 `choose` 16`` | Haskell | 956.7 ns |
| `catalan 300` | ATS | 13.74 μs |
| `catalan 300` | Haskell | 28.76 μs |
| `permutations 20 10` | ATS | 202.8 ns |
| `permutations 20 10` | Haskell | 362.6 ns |
| `maxRegions 45000` | ATS | 624.1 ns |
| `maxRegions 45000` | Haskell | 1.064 μs |
| `stirling2 25 8` | ATS | 3.108 μs |
| `stirling2 25 8` | Haskell | 9.494 μs |

## Building

The Haskell library comes with the C bundled, however you will likely want to build from
source if you are hacking on the library. To that end, you can install
[atspkg](http://hackage.haskell.org/package/ats-pkg) and build with

```bash
atspkg build --pkg-args "./source.dhall"
cabal build
```

## Documentation

You can find documentation for the Haskell library on 
[Hackage](https://hackage.haskell.org/package/fast-arithmetic/).
Unfortunately, there is no documentation for the ATS library, however,
the bundled source code is commented.
