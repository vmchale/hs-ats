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
import           Foreign.C
import           Foreign.Ptr
import           Numeric.GMP.Raw.Unsafe (mpz_clear)
import           Numeric.GMP.Types
import           Numeric.GMP.Utils
import           System.IO.Unsafe       (unsafePerformIO)

foreign import ccall unsafe double_factorial_ats :: CInt -> Ptr MPZ
foreign import ccall unsafe factorial_ats :: CInt -> Ptr MPZ
foreign import ccall unsafe choose_ats :: CInt -> CInt -> Ptr MPZ
foreign import ccall unsafe catalan_ats :: CInt -> Ptr MPZ
foreign import ccall unsafe derangements_ats :: CInt -> Ptr MPZ
foreign import ccall unsafe permutations_ats :: CInt -> CInt -> Ptr MPZ
foreign import ccall unsafe max_regions_ats :: CInt -> Ptr MPZ
foreign import ccall unsafe stirling2_ats :: CInt -> CInt -> Ptr MPZ

conjugateMPZ :: (CInt -> Ptr MPZ) -> Int -> Integer
conjugateMPZ f n = unsafePerformIO (peekInteger mPtr <* mpz_clear mPtr)
    where mPtr = f (fromIntegral n)

conjugateMPZ' :: (CInt -> CInt -> Ptr MPZ) -> Int -> Int -> Integer
conjugateMPZ' f n k = unsafePerformIO (peekInteger mPtr <* mpz_clear mPtr)
    where mPtr = f (fromIntegral n) (fromIntegral k)

-- | \\( !n \\)
--
-- > λ:> derangement <$> [0..10]
-- > [1,0,1,2,9,44,265,1854,14833,133496,1334961]
derangement :: Int -> Integer
derangement = conjugateMPZ derangements_ats

-- | The @n@th Catalan number, with indexing beginning at @0@.
--
-- > λ:> catalan <$> [0..9]
-- > [1,1,2,5,14,42,132,429,1430,4862]
catalan :: Int -> Integer
catalan = conjugateMPZ catalan_ats

-- | \( \binom{n}{k} \)
choose :: Int -> Int -> Integer
choose = conjugateMPZ' choose_ats

permutations :: Int -> Int -> Integer
permutations = conjugateMPZ' permutations_ats

-- | Stirling numbers of the second kind.
stirling2 :: Int -> Int -> Integer
stirling2 = unsafePerformIO .* peekInteger .* on stirling2_ats fromIntegral

factorial :: Int -> Integer
factorial = conjugateMPZ factorial_ats

-- | \( n!! \)
doubleFactorial :: Int -> Integer
doubleFactorial = unsafePerformIO . peekInteger . double_factorial_ats . fromIntegral

-- | Compute the maximal number of regions obtained by joining \\( n \\) points
-- about a circle by straight lines. See [here](https://oeis.org/A000127).
maxRegions :: Int -- ^ \\( n \\)
           -> Integer
maxRegions = conjugateMPZ max_regions_ats
