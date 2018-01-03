{-# LANGUAGE CPP #-}

{-|
Module      : Numeric.Combinatorics
Description : Fast computation of common functions on integers.
Copyright   : Copyright (c) 2017 Vanessa McHale

-}

module Numeric.Integer ( isPrime
                       , isEven
                       , isOdd
                       ) where

import           Foreign.C
import           Numeric.Common

#if __GLASGOW_HASKELL__ >= 820
foreign import ccall unsafe is_prime_ats :: CInt -> CBool
foreign import ccall unsafe is_even_ats :: CInt -> CBool
foreign import ccall unsafe is_odd_ats :: CInt -> CBool
#else
foreign import ccall unsafe is_prime_ats :: CInt -> CUChar
foreign import ccall unsafe is_even_ats :: CInt -> CUChar
foreign import ccall unsafe is_odd_ats :: CInt -> CUChar
#endif

isOdd :: Int -> Bool
isOdd = convertBool . is_odd_ats . fromIntegral

isEven :: Int -> Bool
isEven = convertBool . is_even_ats . fromIntegral

-- | O(√n)
isPrime :: Int -> Bool
isPrime = convertBool . is_prime_ats . fromIntegral
