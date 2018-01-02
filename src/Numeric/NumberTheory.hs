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
                            ) where

import           Control.Composition
import           Foreign.C

foreign import ccall unsafe totient_ats :: CInt -> CInt
foreign import ccall unsafe count_divisors_ats :: CInt -> CInt
foreign import ccall unsafe totient_sum_ats :: CInt -> CInt
foreign import ccall unsafe little_omega_ats :: CInt -> CInt
foreign import ccall unsafe gcd_ats :: CInt -> CInt -> CInt

conjugate :: (CInt -> CInt) -> Int -> Int
conjugate f = fromIntegral . f . fromIntegral

fastGcd :: Int -> Int -> Int
fastGcd = fromIntegral .* on gcd_ats fromIntegral

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
