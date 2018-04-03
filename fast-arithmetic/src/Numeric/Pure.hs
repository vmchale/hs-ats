-- | Pure Haskell functions. These tend to be more general than the equivalents
-- in ATS.
module Numeric.Pure ( -- * Useful functions
                      derangement
                    -- * Functions exported for testing and benchmarking
                    , hsIsPrime
                    , hsFibonacci
                    ) where

{-# SPECIALIZE hsIsPrime :: Int -> Bool #-}

-- | See [here](http://mathworld.wolfram.com/Derangement.html).
--
-- > λ:> fmap derangement [0..10] :: [Integer]
-- > [1,0,1,2,9,44,265,1854,14833,133496,1334961]
derangement :: (Integral a) => Int -> a
derangement n = derangements !! n

derangements :: (Integral a) => [a]
derangements = fmap snd g
    where g = (0, 1) : (1, 0) : zipWith step g (tail g)
          step (_, n) (i, m) = (i + 1, i * (n + m))

hsIsPrime :: (Integral a) => a -> Bool
hsIsPrime 1 = False
hsIsPrime x = all ((/=0) . (x `mod`)) [2..up]
    where up = floor (sqrt (fromIntegral x :: Float))

fibs :: (Integral a) => [a]
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

hsFibonacci :: (Integral a) => Int -> a
hsFibonacci = (fibs !!)
