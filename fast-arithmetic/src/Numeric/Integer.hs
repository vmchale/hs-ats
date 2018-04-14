{-|
Module      : Numeric.Combinatorics
Copyright   : Copyright (c) 2018 Vanessa McHale

This module provides a fast primality check.
-}

module Numeric.Integer ( isPrime
                       ) where

import           Foreign.C
import           Numeric.Common

foreign import ccall unsafe is_prime_ats :: CInt -> CBool

-- | \( O(\sqrt(n)) \)
isPrime :: Int -> Bool
isPrime = asTest is_prime_ats
