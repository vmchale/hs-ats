-- | Pure Haskell functions for testing and benchmarking. Specialized for
-- 'Int's.
module Numeric.Pure ( hsIsPrime
                    , hsFactorial
                    , hsDoubleFactorial
                    , hsChoose
                    , hsTotient
                    , hsTau
                    , hsTotientSum
                    , hsLittleOmega
                    , hsSumDivisors
                    , hsIsPerfect
                    ) where

{-# SPECIALIZE hsLittleOmega :: Int -> Int #-}
{-# SPECIALIZE hsFactorial :: Int -> Int #-}
{-# SPECIALIZE hsTau :: Int -> Int #-}
{-# SPECIALIZE hsTotient :: Int -> Int #-}
{-# SPECIALIZE hsIsPrime :: Int -> Bool #-}
{-# SPECIALIZE hsChoose :: Int -> Int -> Int #-}
{-# SPECIALIZE hsIsPerfect :: Int -> Bool #-}
{-# SPECIALIZE hsDoubleFactorial :: Int -> Int #-}

-- N.B. only works on positive integers
divisors :: (Integral a) => a -> [a]
divisors n = filter ((== 0) . (n `mod`)) [1..n]

hsLittleOmega :: (Integral a) => a -> Int
hsLittleOmega = length . filter hsIsPrime . divisors

hsTau :: (Integral a) => a -> Int
hsTau = length . divisors

-- N.B. sum of proper divisors
hsSumDivisors :: (Integral a) => a -> a
hsSumDivisors = sum . init . divisors

hsIsPerfect :: (Integral a) => a -> Bool
hsIsPerfect = ((==) <*>) hsSumDivisors

hsTotientSum :: (Integral a) => a -> a
hsTotientSum k = sum [ hsTotient n | n <- [1..k] ]

hsTotient :: (Integral a) => a -> a
hsTotient n = (n * product [ p - 1 | p <- ps ]) `div` product ps
    where ps = filter (\k -> hsIsPrime k && n `mod` k == 0) [2..n]

hsIsPrime :: (Integral a) => a -> Bool
hsIsPrime 1 = False
hsIsPrime x = all ((/=0) . (x `rem`)) [2..m]
    where m = floor (sqrt (fromIntegral x :: Float))

hsFactorial :: (Integral a) => a -> a
hsFactorial n = product [1..n]

hsDoubleFactorial :: (Integral a) => a -> a
hsDoubleFactorial 0 = 1
hsDoubleFactorial 1 = 1
hsDoubleFactorial 2 = 2
hsDoubleFactorial n
    | even n = product [2, 4 .. n]
    | odd n = product [1, 3 .. n]
    | otherwise = 1

hsChoose :: (Integral a) => a -> a -> a
hsChoose n k = product [ n + 1 - i | i <- [1..k] ] `div` hsFactorial k
