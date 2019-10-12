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

import           Foreign.C
import           Foreign.Ptr
import           Numeric.GMP.Raw.Unsafe (mpz_clear)
import           Numeric.GMP.Types
import           Numeric.GMP.Utils
import           System.IO.Unsafe       (unsafeDupablePerformIO)

foreign import ccall unsafe double_factorial_ats :: CInt -> IO (Ptr MPZ)
foreign import ccall unsafe factorial_ats :: CInt -> IO (Ptr MPZ)
foreign import ccall unsafe choose_ats :: CInt -> CInt -> IO (Ptr MPZ)
foreign import ccall unsafe catalan_ats :: CInt -> IO (Ptr MPZ)
foreign import ccall unsafe derangements_ats :: CInt -> IO (Ptr MPZ)
foreign import ccall unsafe permutations_ats :: CInt -> CInt -> IO (Ptr MPZ)
foreign import ccall unsafe max_regions_ats :: CInt -> IO (Ptr MPZ)
foreign import ccall unsafe stirling2_ats :: CInt -> CInt -> IO (Ptr MPZ)

-- TODO: use withForeignPtr instead?
-- foreign import ccall "&__gmpz_clear" mpz_clear :: FunPtr (Ptr GMPInt -> IO ())

conjugateMPZ :: (CInt -> IO (Ptr MPZ)) -> Int -> Integer
conjugateMPZ f n = unsafeDupablePerformIO $ do
    mPtr <- f (fromIntegral n)
    peekInteger mPtr <* mpz_clear mPtr

conjugateMPZ' :: (CInt -> CInt -> IO (Ptr MPZ)) -> Int -> Int -> Integer
conjugateMPZ' f n k = unsafeDupablePerformIO $ do
    mPtr <- f (fromIntegral n) (fromIntegral k)
    peekInteger mPtr <* mpz_clear mPtr

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
stirling2 = conjugateMPZ' stirling2_ats

factorial :: Int -> Integer
factorial = conjugateMPZ factorial_ats

-- | \( n!! \)
doubleFactorial :: Int -> Integer
doubleFactorial = conjugateMPZ double_factorial_ats

-- | Compute the maximal number of regions obtained by joining \\( n \\) points
-- about a circle by straight lines. See [here](https://oeis.org/A000127).
maxRegions :: Int -- ^ \\( n \\)
           -> Integer
maxRegions = conjugateMPZ max_regions_ats
