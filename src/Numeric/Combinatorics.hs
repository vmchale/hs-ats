{-|
Module      : Numeric.Combinatorics
Copyright   : Copyright (c) 2017 Vanessa McHale

This provides a few facilities for working with common combinatorial
functions.
-}

module Numeric.Combinatorics ( choose
                             , doubleFactorial
                             , catalan
                             , factorial
                             ) where

import           Control.Composition
import           Data.GMP
import           Foreign.C
import           Foreign.Ptr
import           Foreign.Storable

foreign import ccall unsafe double_factorial_ats :: CInt -> Ptr GMPInt
foreign import ccall unsafe factorial_ats :: CInt -> Ptr GMPInt
foreign import ccall unsafe choose_ats :: CInt -> CInt -> Ptr GMPInt
foreign import ccall unsafe catalan_ats :: CInt -> Ptr GMPInt

-- | The @n@th Catalan number, with indexing beginning at @0@. See
-- [here](http://mathworld.wolfram.com/CatalanNumber.html).
--
-- > λ:> mapM catalan [0..9]
-- > [1,1,2,5,14,42,132,429,1430,4862]
catalan :: Int -> IO Integer
catalan = conjugateGMP catalan_ats

-- | See [here](http://mathworld.wolfram.com/BinomialCoefficient.html).
choose :: Int -> Int -> IO Integer
choose = (gmpToInteger <=<) . (peek .* on choose_ats fromIntegral)

factorial :: Int -> IO Integer
factorial = conjugateGMP factorial_ats

-- | See [here](http://mathworld.wolfram.com/DoubleFactorial.html).
doubleFactorial :: Int -> IO Integer
doubleFactorial = conjugateGMP double_factorial_ats
