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

foreign import ccall unsafe factorial_ats :: CInt -> CInt
foreign import ccall unsafe choose_ats :: CInt -> CInt -> CInt
foreign import ccall unsafe double_factorial :: CInt -> CInt

-- | See [here](http://mathworld.wolfram.com/BinomialCoefficient.html).
choose :: Int -> Int -> Int
choose = fromIntegral .* on choose_ats fromIntegral

-- | See [here](http://mathworld.wolfram.com/DoubleFactorial.html).
doubleFactorial :: Int -> Int
doubleFactorial = fromIntegral . double_factorial . fromIntegral

factorial :: Int -> Int
factorial = fromIntegral . factorial_ats . fromIntegral
