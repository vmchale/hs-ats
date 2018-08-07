{-|
Module      : Numeric.NumberTheory
Copyright   : Copyright (c) 2018 Vanessa McHale

This module provides fast number theoretic functions.
-}

module Numeric.NumberTheory ( totient
                            , tau
                            , littleOmega
                            , isPerfect
                            , sumDivisors
                            , isPrime
                            ) where

import           Foreign.C
import           Numeric.Common

foreign import ccall unsafe totient_ats :: CInt -> CInt
foreign import ccall unsafe count_divisors_ats :: CInt -> CInt
foreign import ccall unsafe sum_divisors_ats :: CInt -> CInt
foreign import ccall unsafe little_omega_ats :: CInt -> CInt
foreign import ccall unsafe is_perfect_ats :: CInt -> CUChar
foreign import ccall unsafe is_prime_ats :: CInt -> CUChar

-- | \( O(\sqrt(n)) \)
isPrime :: Int -> Bool
isPrime = asTest is_prime_ats

-- | See [here](http://mathworld.wolfram.com/PerfectNumber.html)
isPerfect :: Int -> Bool
isPerfect = asTest is_perfect_ats

-- | Sum of proper divisors. May overflow.
sumDivisors :: Int -> Int
sumDivisors = conjugate sum_divisors_ats

-- | Number of distinct prime factors
littleOmega :: Int -> Int
littleOmega = conjugate little_omega_ats

-- | Number of distinct divisors.
tau :: Int -> Int
tau = conjugate count_divisors_ats

-- | Euler totient function.
totient :: Int -> Int
totient = conjugate totient_ats
