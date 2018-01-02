-- | Pure Haskell functions for testing and benchmarking.
module Numeric.Pure ( hsIsPrime
                                  , hsFactorial
                                  , hsDoubleFactorial
                                  , hsChoose
                                  , hsTotient
                                  , hsTau
                                  , hsTotientSum
                                  , hsLittleOmega
                                  ) where

hsLittleOmega :: Int -> Int
hsLittleOmega n = length (filter (\k -> n `mod` k == 0 && hsIsPrime k) [2..n])

hsTau :: Int -> Int
hsTau n = length (filter ((== 0) . (n `mod`)) [1..n])

hsTotientSum :: Int -> Int
hsTotientSum k = sum [ hsTotient n | n <- [1..k] ]

hsTotient :: Int -> Int
hsTotient n = (n * product [ p - 1 | p <- ps ]) `div` product ps
    where ps = filter (\k -> hsIsPrime k && n `mod` k == 0) [2..n]

hsIsPrime :: Int -> Bool
hsIsPrime 1 = False
hsIsPrime x = all ((/=0) . (x `rem`)) [2..m]
    where m = floor (sqrt (fromIntegral x :: Float))

hsFactorial :: Int -> Int
hsFactorial n = product [1..n]

hsDoubleFactorial :: Int -> Int
hsDoubleFactorial 0 = 1
hsDoubleFactorial 1 = 1
hsDoubleFactorial 2 = 2
hsDoubleFactorial n
    | even n = product [2, 4 .. n]
    | odd n = product [1, 3 .. n]
    | otherwise = 1

hsChoose :: Int -> Int -> Int
hsChoose n k = product [ n + 1 - i | i <- [1..k] ] `div` hsFactorial k
