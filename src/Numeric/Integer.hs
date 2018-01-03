{-# LANGUAGE CPP #-}

{-|
Module      : Numeric.Combinatorics
Description : Fast computation of common functions on integers.
Copyright   : Copyright (c) 2017 Vanessa McHale

-}

module Numeric.Integer ( integerExp
                       , isPrime
                       ) where

import           Control.Composition
import           Foreign.C
import           Numeric.Common

foreign import ccall unsafe exp_ats :: CInt -> CInt -> CInt
#if __GLASGOW_HASKELL__ >= 820
foreign import ccall unsafe is_prime_ats :: CInt -> CBool
#else
foreign import ccall unsafe is_prime_ats :: CInt -> CUChar
#endif

-- | O(√n)
isPrime :: Int -> Bool
isPrime = convertBool . is_prime_ats . fromIntegral

-- | Note that both arguments must be positive. O(log(n)) in the exponent.
integerExp :: Int -> Int -> Int
integerExp = fromIntegral .* on exp_ats fromIntegral
