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
| `isPrime 2017` | ATS | 118.9 ns |
| `isPrime 2017` | Haskell | 497.3 ns |
| `φ(2016)` | ATS | 230.1 ns |
| `φ(2016)` | Haskell | 402.8 ns |
| `τ(3018)` | ATS | 438.5 ns |
| `τ(3018)` | Haskell | 726.4 ns |
| `σ(115)` | ATS | 38.37 ns |
| `σ(115)` | Haskell | 310.0 ns |
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
[atspkg](http://hackage.haskell.org/package/ats-pkg), and build with

```bash
atspkg build
cabal new-build
```

## Documentation

You can find documentation for the Haskell library on 
[Hackage](https://hackage.haskell.org/package/fast-arithmetic/).
Unfortunately, there is no documentation for the ATS library, however,
the bundled source code is commented.
