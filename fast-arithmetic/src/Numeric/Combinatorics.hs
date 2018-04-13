{-|
Module      : Numeric.Combinatorics
Copyright   : Copyright (c) 2018 Vanessa McHale

This provides a few facilities for working with common combinatorial
functions.
-}

module Numeric.Combinatorics ( choose
                             , doubleFactorial
                             , catalan
                             , factorial
                             , derangement
                             ) where

import           Control.Composition
import           Control.Monad
import           Data.GMP
import           Foreign.C
import           Foreign.Ptr
import           Foreign.Storable
import           System.IO.Unsafe    (unsafePerformIO)

foreign import ccall double_factorial_ats :: CInt -> Ptr GMPInt
foreign import ccall factorial_ats :: CInt -> Ptr GMPInt
foreign import ccall choose_ats :: CInt -> CInt -> Ptr GMPInt
foreign import ccall catalan_ats :: CInt -> Ptr GMPInt
foreign import ccall derangements_ats :: CInt -> Ptr GMPInt

-- | \\( !n \\). See [here](http://mathworld.wolfram.com/Derangement.html)
derangement :: Int -> Integer
derangement = unsafePerformIO . conjugateGMP derangements_ats

-- | The @n@th Catalan number, with indexing beginning at @0@. See
-- [here](http://mathworld.wolfram.com/CatalanNumber.html).
--
-- > λ:> catalan <$> [0..9]
-- > [1,1,2,5,14,42,132,429,1430,4862]
catalan :: Int -> Integer
catalan = unsafePerformIO . conjugateGMP catalan_ats

-- | \( \binom{n}{k} \)
choose :: Int -> Int -> Integer
choose = unsafePerformIO .* (gmpToInteger <=<) . (peek .* on choose_ats fromIntegral)

factorial :: Int -> Integer
factorial = unsafePerformIO . conjugateGMP factorial_ats

-- | See [here](http://mathworld.wolfram.com/DoubleFactorial.html).
doubleFactorial :: Int -> Integer
doubleFactorial = unsafePerformIO . conjugateGMP double_factorial_ats
