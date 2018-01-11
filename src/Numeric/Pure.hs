{-# LANGUAGE CPP #-}

-- | Pure Haskell functions
module Numeric.Pure ( -- * Useful functions
                      derangement
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
                    , hsFibonacci
                    , hsFactorial
                    ) where

#if __GLASGOW_HASKELL__ <= 784
import           Control.Applicative
#endif

{-# SPECIALIZE hsLittleOmega :: Int -> Int #-}
{-# SPECIALIZE hsTau :: Int -> Int #-}
{-# SPECIALIZE hsTotient :: Int -> Int #-}
{-# SPECIALIZE hsIsPrime :: Int -> Bool #-}
{-# SPECIALIZE hsChoose :: Int -> Int -> Int #-}
{-# SPECIALIZE hsDoubleFactorial :: Int -> Int #-}

-- | See [here](http://mathworld.wolfram.com/Derangement.html).
--
-- > λ:> fmap derangement [0..10] :: [Integer]
-- > [1,0,1,2,9,44,265,1854,14833,133496,1334961]
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

hsCatalan :: (Integral a) => a -> a
hsCatalan n = product [ n + k | k <- [2..n]] `div` hsFactorial n

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
hsChoose n k =  product [ n + 1 - i | i <- [1..k] ] `div` hsFactorial k

fibs :: (Integral a) => [a]
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

hsFibonacci :: (Integral a) => Int -> a
hsFibonacci = (fibs !!)
