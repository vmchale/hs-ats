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
                            , jacobi
                            ) where

import           Foreign.C
import           Numeric.Common

foreign import ccall unsafe totient_ats :: CInt -> CInt
foreign import ccall unsafe count_divisors_ats :: CInt -> CInt
foreign import ccall unsafe sum_divisors_ats :: CInt -> CInt
foreign import ccall unsafe little_omega_ats :: CInt -> CInt
foreign import ccall unsafe jacobi_ats :: CInt -> CInt -> CInt
#if __GLASGOW_HASKELL__ >= 820
foreign import ccall unsafe is_perfect_ats :: CInt -> CBool
#else
foreign import ccall unsafe is_perfect_ats :: CInt -> CUChar
#endif

-- | The Jacobi symbol (a/n) (see
-- [here](http://mathworld.wolfram.com/JacobiSymbol.html)) for more.
--
-- This function is somewhat experimental, and improvements to
-- performance are expected.
jacobi :: Int -- ^ a
       -> Int -- ^ n
       -> Int
jacobi = conjugateTwo jacobi_ats

-- | See [here](http://mathworld.wolfram.com/PerfectNumber.html)
isPerfect :: Int -> Bool
isPerfect = asTest is_perfect_ats

-- | Sum of proper divisors.
sumDivisors :: Int -> Int
sumDivisors = conjugate sum_divisors_ats

-- Number of distinct prime factors
littleOmega :: Int -> Int
littleOmega = conjugate little_omega_ats

-- | Number of distinct divisors.
tau :: Int -> Int
tau = conjugate count_divisors_ats

-- | Euler totient function. Experimental.
totient :: Int -> Int
totient = conjugate totient_ats
