{-|
Module      : Numeric.Combinatorics
Copyright   : Copyright (c) 2017 Vanessa McHale

This provides a few facilities for working with common combinatorial
functions.
-}

module Numeric.Combinatorics ( factorial
                             , choose
                             , doubleFactorial
                             , derangement
                             ) where

import           Control.Composition
import           Data.GMP
import           Foreign.C
import           Foreign.Ptr
import           Foreign.Storable

foreign import ccall unsafe factorial_ats :: CInt -> Ptr GMPInt
foreign import ccall unsafe double_factorial_ats :: CInt -> Ptr GMPInt
foreign import ccall unsafe choose_ats :: CInt -> CInt -> Ptr GMPInt
foreign import ccall unsafe derangement_ats :: CInt -> Ptr GMPInt

-- | See [here](http://mathworld.wolfram.com/BinomialCoefficient.html).
choose :: Int -> Int -> IO Integer
choose = (gmpToInteger <=<) . (peek .* on choose_ats fromIntegral)

-- | See [here](http://mathworld.wolfram.com/DoubleFactorial.html).
doubleFactorial :: Int -> IO Integer
doubleFactorial = conjugateGMP double_factorial_ats

-- | See [here](http://mathworld.wolfram.com/Derangement.html).
derangement :: Int -> IO Integer
derangement = conjugateGMP derangement_ats

factorial :: Int -> IO Integer
factorial = conjugateGMP factorial_ats
