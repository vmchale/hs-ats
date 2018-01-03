{-|
Module      : Numeric.NumberTheory
Description : Fast computation of number theoretic functions
Copyright   : Copyright (c) 2017 Vanessa McHale

-}

module Numeric.NumberTheory ( totient
                            , tau
                            , totientSum
                            , littleOmega
                            , fastGcd
                            , fastLcm
                            ) where

import           Control.Composition
import           Foreign.C
import           Numeric.Common

foreign import ccall unsafe totient_ats :: CInt -> CInt
foreign import ccall unsafe count_divisors_ats :: CInt -> CInt
foreign import ccall unsafe totient_sum_ats :: CInt -> CInt
foreign import ccall unsafe little_omega_ats :: CInt -> CInt
foreign import ccall unsafe gcd_ats :: CInt -> CInt -> CInt
foreign import ccall unsafe lcm_ats :: CInt -> CInt -> CInt

fastLcm :: Int -> Int -> Int
fastLcm = fromIntegral .* on lcm_ats fromIntegral

-- | Slightly faster than the function in the prelude.
fastGcd :: Int -> Int -> Int
fastGcd = fromIntegral .* on gcd_ats fromIntegral

-- TODO mathworld link
littleOmega :: Int -> Int
littleOmega = conjugate little_omega_ats

-- | Number of distinct prime divisors.
tau :: Int -> Int
tau = conjugate count_divisors_ats

-- | Euler totient function.
totient :: Int -> Int
totient = conjugate totient_ats

-- | @[totient k | k <- [1 .. n]]@ in Haskell
totientSum :: Int -> Int
totientSum = conjugate totient_sum_ats
