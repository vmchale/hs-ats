{-# LANGUAGE CPP #-}

{-|
Module      : Numeric.NumberTheory
Copyright   : Copyright (c) 2017 Vanessa McHale

This module provides fast number theoretic functions when possible.
-}

module Numeric.NumberTheory ( totient
                            , tau
                            , littleOmega
                            , isPerfect
                            , sumDivisors
                            ) where

import           Foreign.C
import           Numeric.Common

foreign import ccall unsafe totient_ats :: CInt -> CInt
foreign import ccall unsafe count_divisors_ats :: CInt -> CInt
foreign import ccall unsafe sum_divisors_ats :: CInt -> CInt
foreign import ccall unsafe little_omega_ats :: CInt -> CInt
#if __GLASGOW_HASKELL__ >= 820
foreign import ccall unsafe is_perfect_ats :: CInt -> CBool
#else
foreign import ccall unsafe is_perfect_ats :: CInt -> CUChar
#endif

-- | See [here](http://mathworld.wolfram.com/PerfectNumber.html)
isPerfect :: Int -> Bool
isPerfect 1 = True
isPerfect x = asTest is_perfect_ats x

-- | Sum of proper divisors.
sumDivisors :: Int -> Int
sumDivisors 1 = 1
sumDivisors x = conjugate sum_divisors_ats x

-- Number of distinct prime factors
littleOmega :: Int -> Int
littleOmega = conjugate little_omega_ats

-- | Number of distinct divisors.
tau :: Int -> Int
tau = conjugate count_divisors_ats

-- | Euler totient function. Experimental.
totient :: Int -> Int
totient = conjugate totient_ats
