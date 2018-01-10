{-# LANGUAGE CPP #-}

-- | Pure Haskell functions for testing and benchmarking.
module Numeric.Pure ( -- * Useful functions
                      derangement
                    , factorial
                    -- * Functions exported for testing and benchmarking
                    , hsIsPrime
                    , hsDoubleFactorial
                    , hsChoose
                    , hsTotient
                    , hsTau
                    , hsTotientSum
                    , hsLittleOmega
                    , hsIsPerfect
                    , hsSumDivisors
                    , hsCatalan
                    ) where

#if __GLASGOW_HASKELL__ <= 784
import           Control.Applicative
#endif

{-# SPECIALIZE factorial :: Int -> Integer #-}
{-# SPECIALIZE derangement :: Int -> Integer #-}
{-# SPECIALIZE hsLittleOmega :: Int -> Int #-}
{-# SPECIALIZE hsTau :: Int -> Int #-}
{-# SPECIALIZE hsTotient :: Int -> Int #-}
{-# SPECIALIZE hsIsPrime :: Int -> Bool #-}
{-# SPECIALIZE hsChoose :: Int -> Int -> Int #-}
{-# SPECIALIZE hsDoubleFactorial :: Int -> Int #-}

-- | See [here](http://mathworld.wolfram.com/Derangement.html).
derangement :: (Integral a) => Int -> a
derangement n = derangements !! n

derangements :: (Integral a) => [a]
derangements = fmap snd g
    where g = (0, 1) : (1, 0) : zipWith (\(_, n) (i, m) -> (i + 1, i * (n + m))) g (tail g)

divisors :: (Integral a) => a -> [a]
divisors n = filter ((== 0) . (n `mod`)) [1..n]

hsLittleOmega :: (Integral a) => a -> Int
hsLittleOmega = length . filter hsIsPrime . divisors

hsTau :: (Integral a) => a -> Int
hsTau = length . divisors

-- N.B. sum of proper divisors
hsSumDivisors :: (Integral a) => a -> a
hsSumDivisors = sum . init . divisors

hsCatalan :: (Integral a) => Int -> a
hsCatalan n = let n' = fromIntegral n in product [ n' + k | k <- [2..n']] `div` factorial n

hsIsPerfect :: (Integral a) => a -> Bool
hsIsPerfect = idem hsSumDivisors where idem = ((==) <*>)

hsTotientSum :: (Integral a) => a -> a
hsTotientSum k = sum [ hsTotient n | n <- [1..k] ]

hsTotient :: (Integral a) => a -> a
hsTotient n = (n * product [ p - 1 | p <- ps ]) `div` product ps
    where ps = filter (\k -> hsIsPrime k && n `mod` k == 0) [2..n]

hsIsPrime :: (Integral a) => a -> Bool
hsIsPrime 1 = False
hsIsPrime x = all ((/=0) . (x `mod`)) [2..m]
    where m = floor (sqrt (fromIntegral x :: Float))

factorials :: (Integral a) => [a]
factorials = 1 : 1 : zipWith (*) [2..] (tail factorials)

factorial :: (Integral a) => Int -> a
factorial = (factorials !!)

hsDoubleFactorial :: (Integral a) => a -> a
hsDoubleFactorial 0 = 1
hsDoubleFactorial 1 = 1
hsDoubleFactorial 2 = 2
hsDoubleFactorial n
    | even n = product [2, 4 .. n]
    | odd n = product [1, 3 .. n]
    | otherwise = 1

hsChoose :: (Integral a) => a -> Int -> a
hsChoose n k = product [ n + 1 - i | i <- [1..(fromIntegral k)] ] `div` factorial k
