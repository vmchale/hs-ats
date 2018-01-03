module Main where

import           Criterion.Main
import           Numeric.Integer
import           Numeric.NumberTheory
import           Numeric.Pure

main :: IO ()
main =
    defaultMain [ bgroup "primality check"
                      [ bench "isPrime" $ nf isPrime 2017
                      , bench "hsIsPrime" $ nf hsIsPrime (2017 :: Int)
                      ]
                , bgroup "totient"
                      [ bench "totient" $ nf totient 2016
                      , bench "hsTotient" $ nf (hsTotient :: Int -> Int) 2016
                      ]
                , bgroup "tau"
                      [ bench "tau" $ nf tau 3018
                      , bench "hsTau" $ nf hsTau (3018 :: Int)
                      ]
                , bgroup "littleOmega"
                      [ bench "littleOmega" $ nf littleOmega 91
                      , bench "hsLittleOmega" $ nf hsLittleOmega (91 :: Int)
                      ]
                , bgroup "fastGcd"
                      [ bench "fastGcd" $ nf (fastGcd 201 :: Int -> Int) 67
                      , bench "gcd" $ nf (gcd 201 :: Int -> Int) 67
                      ]
                , bgroup "isPerfect"
                      [ bench "isPerfect" $ nf isPerfect 318
                      , bench "hsIsPerfect" $ nf hsIsPerfect (318 :: Int)
                      ]
                ]
