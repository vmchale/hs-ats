{-|
Module      : Numeric.Combinatorics
Copyright   : Copyright (c) 2018 Vanessa McHale

This module provides a fast primality check.
-}

module Numeric.Integer ( isPrime
                       , fibonacci
                       ) where

import           Data.GMP
import           Foreign.C
import           Foreign.Ptr
import           Numeric.Common
import           System.IO.Unsafe (unsafePerformIO)

foreign import ccall is_prime_ats :: CInt -> CBool
foreign import ccall unsafe fib_ats :: CInt -> Ptr GMPInt

-- | Indexed starting at @0@.
fibonacci :: Int -> Integer
fibonacci = unsafePerformIO . conjugateGMP fib_ats

-- | \( O(\sqrt(n)) \)
isPrime :: Int -> Bool
isPrime = asTest is_prime_ats
