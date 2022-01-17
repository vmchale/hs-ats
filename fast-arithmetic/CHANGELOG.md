# fast-arithmetic

## 0.6.7.0

  * Add `risingFac` function

## 0.6.6.0

  * Export `bell` function

## 0.6.5.1

  * Documentation fixes
  * Fix performance of `tau`; it now beats Haskell implementation from arithmoi
    again.

# 0.6.5.0

  * Add `isSemiprime`

## 0.6.4.3

  * Improved documentation
  * Update for latest `ats-includes` package
  * Remove unsafe casts and don't bother with `intinfGt(0)` types
  * Use internal library `pure-haskell` for benchmarks/test suite
  * Drop some older GHC support

## 0.6.4.2

  * Fix bug in `include/fast_arithmetic.h`
  * Put some documentation in `.sats` files rather than `.dats` files
  * Fix `.dhall` files

## 0.6.4.1

  * Use `hgmp` internally

## 0.6.4.0

  * Add `bell` to the ATS library
  * Add `stirling2` for computing Stirling numbers of the second kind.
  * Add `radical` to `fast_arithmetic.h`, for users of the C library

## 0.6.3.0

  * Patch `isPrime`

## 0.6.2.1

  * Export `radical`

## 0.6.2.0

  * Add `radical` for computing radicals of integers

## 0.6.1.2

  * Add `fast_arithmetic.h` for those wanting to use the C library.

## 0.6.1.1

  * Add niche function for a problem of combinatorial geometry.

## 0.6.1.0

  * Add `permutations` function
  * Minor performance improvements
  * Add debian package
  * Improvements to the ATS library

## 0.6.0.9

  * Fix builds on older GHCs

## 0.6.0.8

  * Improved performance slightly
  * Updated `pkg.dhall`
