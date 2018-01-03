{-# LANGUAGE ForeignFunctionInterface #-}

{-|
Module      : Numeric.Combinatorics
Description : Fast computation of common combinatorial functions.
Copyright   : Copyright (c) 2017 Vanessa McHale

-}

module Numeric.Combinatorics
    ( factorial
    , choose
    , doubleFactorial
    ) where

import           Control.Composition
import           Foreign.C
import           Numeric.Common

foreign import ccall unsafe factorial_ats :: CInt -> CInt
foreign import ccall unsafe choose_ats :: CInt -> CInt -> CInt
foreign import ccall unsafe double_factorial :: CInt -> CInt

-- | Number of distinct sets of k objects drawn from a set of n distinct
-- objects. See [here](http://mathworld.wolfram.com/BinomialCoefficient.html).
choose :: Int -- ^ n
       -> Int -- ^ k
       -> Int
choose = fromIntegral .* on choose_ats fromIntegral

-- | See [here](http://mathworld.wolfram.com/DoubleFactorial.html).
doubleFactorial :: Int -> Int
doubleFactorial = conjugate double_factorial

factorial :: Int -> Int
factorial = conjugate factorial_ats
