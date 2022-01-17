-- | This module contains functions that are common to the benchmark and test
-- suites.
module Numeric.Haskell ( hsPermutations
                       , hsIsPrime
                       , hsMaxRegions
                       , hsDerangement
                       , hsIsSemiprime
                       , hsPrimorial
                       , hsRisingFac
                       ) where

import qualified Math.Combinat.Numbers    as Ext
import           Math.NumberTheory.Primes (primes, unPrime)

hsRisingFac :: Integral a => a -> a -> a
hsRisingFac a n = product [a..(a+n-1)]

{-# SPECIALIZE hsIsSemiprime :: Int -> Bool #-}
hsIsSemiprime :: Integral a => a -> Bool
hsIsSemiprime 1 = False
hsIsSemiprime x = case filter ((== 0) . (x `rem`)) [2..up] of
    []  -> False
    [y] -> hsIsPrime (x `quot` y)
    _   -> False
    where up = floor (sqrt (fromIntegral x :: Double))

{-# SPECIALIZE hsPermutations :: Integer -> Integer -> Integer #-}
hsPermutations :: Integral a => a -> a -> a
hsPermutations n k = product [(n-k+1)..n]

{-# SPECIALIZE hsIsPrime :: Int -> Bool #-}
hsIsPrime :: (Integral a) => a -> Bool
hsIsPrime 1 = False
hsIsPrime x = all ((/=0) . (x `rem`)) [2..up]
    where up = floor (sqrt (fromIntegral x :: Double))

{-# SPECIALIZE hsMaxRegions :: Int -> Integer #-}
hsMaxRegions :: (Integral a) => a -> Integer
hsMaxRegions n = sum $ fmap (n `Ext.binomial`) [0..4]

{-# SPECIALIZE hsDerangement :: Int -> Integer #-}
hsDerangement :: (Integral a) => Int -> a
hsDerangement n = derangements !! n

derangements :: (Integral a) => [a]
derangements = fmap snd g
    where g = (0, 1) : (1, 0) : zipWith step g (tail g)
          step (_, n) (i, m) = (i + 1, i * (n + m))

{-# SPECIALIZE hsPrimorial :: Int -> Integer #-}
hsPrimorial :: Integral a => Int -> a
hsPrimorial n = product (unPrime <$> take n primes)
