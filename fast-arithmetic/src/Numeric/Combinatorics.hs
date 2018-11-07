{-|
Module      : Numeric.Combinatorics
Copyright   : Copyright (c) 2018 Vanessa McHale

This provides facilities for working with common combinatorial
functions.
-}

module Numeric.Combinatorics ( choose
                             , doubleFactorial
                             , catalan
                             , factorial
                             , derangement
                             , permutations
                             , maxRegions
                             , stirling2
                             ) where

import           Control.Composition
import           Control.Monad
import           Data.GMP
import           Foreign.C
import           Foreign.Ptr
import           Foreign.Storable
import           System.IO.Unsafe    (unsafePerformIO)

foreign import ccall unsafe double_factorial_ats :: CInt -> Ptr GMPInt
foreign import ccall unsafe factorial_ats :: CInt -> Ptr GMPInt
foreign import ccall unsafe choose_ats :: CInt -> CInt -> Ptr GMPInt
foreign import ccall unsafe catalan_ats :: CInt -> Ptr GMPInt
foreign import ccall unsafe derangements_ats :: CInt -> Ptr GMPInt
foreign import ccall unsafe permutations_ats :: CInt -> CInt -> Ptr GMPInt
foreign import ccall unsafe max_regions_ats :: CInt -> Ptr GMPInt
foreign import ccall unsafe stirling2_ats :: CInt -> CInt -> Ptr GMPInt

helper :: (CInt -> CInt -> Ptr GMPInt) -> Int -> Int -> Integer
helper f = unsafePerformIO .* (gmpToInteger <=<) . (peek .* on f fromIntegral)

-- | \\( !n \\)
--
-- > λ:> derangement <$> [0..10]
-- > [1,0,1,2,9,44,265,1854,14833,133496,1334961]
derangement :: Int -> Integer
derangement = unsafePerformIO . conjugateGMP derangements_ats

-- | The @n@th Catalan number, with indexing beginning at @0@.
--
-- > λ:> catalan <$> [0..9]
-- > [1,1,2,5,14,42,132,429,1430,4862]
catalan :: Int -> Integer
catalan = unsafePerformIO . conjugateGMP catalan_ats

-- | \( \binom{n}{k} \)
choose :: Int -> Int -> Integer
choose = helper choose_ats

permutations :: Int -> Int -> Integer
permutations = helper permutations_ats

-- | Stirling numbers of the second kind.
stirling2 :: Int -> Int -> Integer
stirling2 = helper stirling2_ats

factorial :: Int -> Integer
factorial = unsafePerformIO . conjugateGMP factorial_ats

-- | \( n!! \)
doubleFactorial :: Int -> Integer
doubleFactorial = unsafePerformIO . conjugateGMP double_factorial_ats

-- | Compute the maximal number of regions obtained by joining \\( n \\) points
-- about a circle by straight lines. See [here](https://oeis.org/A000127).
maxRegions :: Int -- ^ \\( n \\)
           -> Integer
maxRegions = unsafePerformIO . conjugateGMP max_regions_ats
