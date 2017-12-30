# fast-combinatorics

[![Build Status](https://travis-ci.org/vmchale/fast-combinatorics.svg?branch=master)](https://travis-ci.org/vmchale/fast-combinatorics)

This is a library for fast combinatorics using ATS. As such, make sure
a C compiler is installed. Also, I don't know if it works on Windows.

Currently it is in-progress, being somewhat constrained by the fact that I have
yet to figure out how to share arbitrary-precision types between ATS and Haskell.

## Building

The Haskell library comes with the C bundled, however you may wish to build from
source if you are hacking on the library. To that end, you can install
[stack](http://haskellstack.org/), [patscc](http://www.ats-lang.org/Downloads.html) , and
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
tooling/libraries may be used. In particular, you may like to interact with the
library via a REPL, viz.

```bash
 $ cabal new-repl
```

### Using the Haskell library

You may wish to read the ATS source code for an indication of what sorts of
things ATS allows us to prove things about our programs, such as proofs of
termination.

There are also a few caveats: note that all results and arguments
must be of the `Int` type. This unfortunate constraint will hopefully be fixed
in the future, but right now it limits the usefulness of the library.
