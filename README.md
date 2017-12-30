# fast-combinatorics

[![Build Status](https://travis-ci.org/vmchale/fast-combinatorics.svg?branch=master)](https://travis-ci.org/vmchale/fast-combinatorics)

This is a library for fast combinatorics using ATS. You may need to download the 
relevant ATS libraries
[here](http://www.ats-lang.org/Downloads.html#Install_of_ATS2_include) if
linking fails.

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
