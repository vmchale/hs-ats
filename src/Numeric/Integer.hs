{-# LANGUAGE CPP #-}

{-|
Module      : Numeric.Combinatorics
Copyright   : Copyright (c) 2017 Vanessa McHale

This module provides a fast primality check.
-}

module Numeric.Integer ( isPrime
                       , fibonacci
                       ) where

import           Data.GMP
import           Foreign.C
import           Foreign.Ptr
import           Numeric.Common

#if __GLASGOW_HASKELL__ >= 820
foreign import ccall unsafe is_prime_ats :: CInt -> CBool
#else
foreign import ccall unsafe is_prime_ats :: CInt -> CUChar
#endif
foreign import ccall unsafe fib_ats :: CInt -> Ptr GMPInt

-- | Indexed starting at @0@.
fibonacci :: Int -> IO Integer
fibonacci = conjugateGMP fib_ats

-- | O(√n)
isPrime :: Int -> Bool
isPrime = asTest is_prime_ats
