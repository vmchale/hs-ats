{-# LANGUAGE CPP #-}

{-|
Module      : Numeric.NumberTheory
Description : Fast computation of number theoretic functions
Copyright   : Copyright (c) 2017 Vanessa McHale

-}

module Numeric.NumberTheory ( totient
                            , tau
                            , littleOmega
                            , isPerfect
                            ) where

import           Foreign.C
import           Numeric.Common

foreign import ccall unsafe totient_ats :: CInt -> CInt
foreign import ccall unsafe count_divisors_ats :: CInt -> CInt
foreign import ccall unsafe little_omega_ats :: CInt -> CInt
#if __GLASGOW_HASKELL__ >= 820
foreign import ccall unsafe is_perfect_ats :: CInt -> CBool
#else
foreign import ccall unsafe is_perfect_ats :: CInt -> CUChar
#endif

isPerfect :: Int -> Bool
isPerfect = convertBool . is_perfect_ats . fromIntegral

-- TODO mathworld link
littleOmega :: Int -> Int
littleOmega = conjugate little_omega_ats

-- | Number of distinct prime divisors.
tau :: Int -> Int
tau = conjugate count_divisors_ats

-- | Euler totient function.
totient :: Int -> Int
totient = conjugate totient_ats
