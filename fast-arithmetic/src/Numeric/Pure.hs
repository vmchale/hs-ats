-- | Pure Haskell functions.
module Numeric.Pure ( hsDerangement
                    ) where

-- | See [here](http://mathworld.wolfram.com/Derangement.html).
--
-- > λ:> fmap derangement [0..10] :: [Integer]
-- > [1,0,1,2,9,44,265,1854,14833,133496,1334961]
hsDerangement :: (Integral a) => Int -> a
hsDerangement n = derangements !! n

derangements :: (Integral a) => [a]
derangements = fmap snd g
    where g = (0, 1) : (1, 0) : zipWith step g (tail g)
          step (_, n) (i, m) = (i + 1, i * (n + m))
