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
| `isPrime 2017` | ATS | 117.1 ns |
| `isPrime 2017` | Haskell | 426.4 ns |
| `φ(2016)` | ATS | 190.9 ns |
| `φ(2016)` | Haskell | 356.9 ns |
| `τ(3018)` | ATS | 340.8 ns |
| `τ(3018)` | Haskell | 659.0 ns |
| `σ(115)` | ATS | 41.27 ns |
| `σ(115)` | Haskell | 314.1 ns |
| `ω(91)` | ATS | 64.67 ns |
| `ω(91)` | Haskell | 332.0 ns |
| `160!` | ATS | 4.303 μs |
| `160!` | Haskell | 5.659 μs |
| `79!!` | ATS | 941.2 ns |
| `79!!` | Haskell | 1.267 μs |
| ``322 `choose` 16`` | ATS | 557.5 ns |
| ``322 `choose` 16`` | Haskell | 996.3 ns |
| `catalan 300` | ATS | 18.15 μs |
| `catalan 300` | Haskell | 29.08 μs |

## Building

The Haskell library comes with the C bundled, however you will likely want to build from
source if you are hacking on the library. To that end, you can install
[atspkg](http://hackage.haskell.org/package/ats-pkg) and build with

```bash
atspkg build --pkg-args "./source.dhall"
cabal new-build
```

## Documentation

You can find documentation for the Haskell library on 
[Hackage](https://hackage.haskell.org/package/fast-arithmetic/).
Unfortunately, there is no documentation for the ATS library, however,
the bundled source code is commented.
