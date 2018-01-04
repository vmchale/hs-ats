{-# LANGUAGE CPP #-}

{-|
Module      : Numeric.Combinatorics
Description : Fast computation of common functions on integers.
Copyright   : Copyright (c) 2017 Vanessa McHale

-}

module Numeric.Integer ( isPrime
                       ) where

import           Foreign.C
import           Numeric.Common

#if __GLASGOW_HASKELL__ >= 820
foreign import ccall unsafe is_prime_ats :: CInt -> CBool
#else
foreign import ccall unsafe is_prime_ats :: CInt -> CUChar
#endif

-- | O(√n)
isPrime :: Int -> Bool
isPrime = convertBool . is_prime_ats . fromIntegral
