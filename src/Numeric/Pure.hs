{-# LANGUAGE CPP #-}

-- | Pure Haskell functions. These tend to be more general than the equivalents
-- in ATS.
module Numeric.Pure ( -- * Useful functions
                      derangement
                    -- * Functions exported for testing and benchmarking
                    , hsIsPrime
                    , hsTau
                    , hsIsPerfect
                    , hsSumDivisors
                    , hsCatalan
                    , hsFibonacci
                    , hsFactorial
                    ) where

#if __GLASGOW_HASKELL__ <= 784
import           Control.Applicative
#endif

{-# SPECIALIZE hsTau :: Int -> Int #-}
{-# SPECIALIZE hsIsPrime :: Int -> Bool #-}

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

hsTau :: (Integral a) => a -> Int
hsTau = length . divisors

-- N.B. sum of divisors
hsSumDivisors :: (Integral a) => a -> a
hsSumDivisors = sum . divisors

hsCatalan :: (Integral a) => a -> a
hsCatalan n = product [ n + k | k <- [2..n]] `div` hsFactorial n

hsIsPerfect :: (Integral a) => a -> Bool
hsIsPerfect = idem hsSumDivisors where idem = ((==) <*>)

hsIsPrime :: (Integral a) => a -> Bool
hsIsPrime 1 = False
hsIsPrime x = all ((/=0) . (x `mod`)) [2..m]
    where m = floor (sqrt (fromIntegral x :: Float))

hsFactorial :: (Integral a) => a -> a
hsFactorial n = product [1..n]

fibs :: (Integral a) => [a]
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

hsFibonacci :: (Integral a) => Int -> a
hsFibonacci = (fibs !!)
