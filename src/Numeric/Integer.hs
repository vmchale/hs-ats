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
import           Data.Word
import           Foreign.C

foreign import ccall unsafe exp_ats :: CInt -> CInt -> CInt
#if __GLASGOW_HASKELL__ >= 820
foreign import ccall unsafe is_prime_ats :: CInt -> CBool
#else
foreign import ccall unsafe is_prime_ats :: CInt -> CUChar
#endif

#if __GLASGOW_HASKELL__ >= 820
convertBool :: CBool -> Bool
#else
convertBool :: CUChar -> Bool
#endif
convertBool = go . fromIntegral
    where
        go :: Word8 -> Bool
        go 0 = False
        go 1 = True
        go _ = False

-- | O(√n)
isPrime :: Int -> Bool
isPrime = convertBool . is_prime_ats . fromIntegral

-- | Note that both arguments must be positive. O(log(n)) in the exponent.
integerExp :: Int -> Int -> Int
integerExp = fromIntegral .* on exp_ats fromIntegral
