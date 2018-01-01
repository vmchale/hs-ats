# fast-combinatorics

[![Build Status](https://travis-ci.org/vmchale/fast-combinatorics.svg?branch=master)](https://travis-ci.org/vmchale/fast-combinatorics)

This is a library for fast combinatorics using ATS. As such, make sure
a C compiler is installed. It may not work on windows, so if you run into bugs
building this please open an issue.

Currently it is a work-in-progress, being somewhat constrained by the fact that I have
yet to figure out how to share arbitrary-precision types between ATS and Haskell. 

## Benchmarks

| Computation | Version (ATS/Haskell) | Time |
| ----------- | --------------------- | ---- |
| `12!` | ATS | 9.301 ns |
| `12!` | Haskell | 27.84 ns |
| `19!!` | ATS | 10.07 ns |
| `19!!` | Haskell | 20.82 ns |
| ``13 `choose` 4`` | ATS | 12.28 ns |
| ``13 `choose` 4`` | Haskell | 28.38 ns |
| `isPrime 2017` | ATS | 118.9 ns |
| `isPrime 2017` | Haskell | 497.3 ns |
| `3 ^ 7` | ATS | 8.735 ns |
| `3 ^ 7` | Haskell | 37.02 ns |

## Building

The Haskell library comes with the C bundled, however you may wish to build from
source if you are hacking on the library. To that end, you can install
[stack](http://haskellstack.org/), [patscc](http://www.ats-lang.org/Downloads.html), and
[pats-filter](https://github.com/Hibou57/PostiATS-Utilities) and build with

```bash
 $ ./shake.hs
```

You will also likely want to install
[GHC](https://www.haskell.org/ghc/download.html) as well as
[cabal](https://www.haskell.org/cabal/).

## Documentation

### Using the ATS library

One of the nice things about a Haskell wrapper is that some of Haskell's
tooling/libraries may be used. You may want to try the REPL:

```bash
 $ cabal new-repl
```

### Using the Haskell library

You may wish to read the ATS source code for an indication of what sorts of
things ATS allows us to prove things about our programs, particularly proofs of
termination.

There are also a few caveats: note that all results and arguments
must be of the `Int` type. This unfortunate constraint will hopefully be fixed
in the future, but right now it limits the usefulness of the library.
