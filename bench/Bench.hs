module Main where

import           Criterion.Main
import           Numeric.Combinatorics
import           Numeric.Integer
import           Numeric.NumberTheory
import           Numeric.Pure

main :: IO ()
main =
    defaultMain [ bgroup "factorial"
                      [ bench "factorial" $ nf factorial 12
                      , bench "hsFactorial" $ nf (hsFactorial :: Int -> Int) 12
                      ]
                , bgroup "combinations"
                      [ bench "choose" $ nf (13 `choose`) 4
                      , bench "hsChoose" $ nf ((13 `hsChoose`) :: Int -> Int) 4
                      ]
                , bgroup "double factorial"
                      [ bench "doubleFactorial" $ nf doubleFactorial 19
                      , bench "hsDoubleFactorial" $ nf (hsDoubleFactorial :: Int -> Int) 19
                      ]
                , bgroup "primality check"
                      [ bench "isPrime" $ nf isPrime 2017
                      , bench "hsIsPrime" $ nf hsIsPrime (2017 :: Int)
                      ]
                , bgroup "integer exponentiation"
                      [ bench "integerExp" $ nf (integerExp 3) 7
                      , bench "^" $ nf ((3 :: Int) ^) (7 :: Int)
                      ]
                , bgroup "totient"
                      [ bench "totient" $ nf totient 2016
                      , bench "hsTotient" $ nf (hsTotient :: Int -> Int) 2016
                      ]
                , bgroup "tau"
                      [ bench "tau" $ nf tau 3018
                      , bench "hsTau" $ nf hsTau (3018 :: Int)
                      ]
                , bgroup "totientSum"
                      [ bench "totientSum" $ nf totientSum 1280
                      , bench "hsTotientSum" $ nf (hsTotientSum :: Int -> Int) 1280
                      ]
                , bgroup "littleOmega"
                      [ bench "littleOmega" $ nf littleOmega 91
                      , bench "hsLittleOmega" $ nf hsLittleOmega (91 :: Int)
                      ]
                , bgroup "fastGcd"
                      [ bench "fastGcd" $ nf (fastGcd 201 :: Int -> Int) 67
                      , bench "gcd" $ nf (gcd 201 :: Int -> Int) 67
                      ]
                , bgroup "fastLcm"
                      [ bench "fastLcm" $ nf (fastLcm 201 :: Int -> Int) 67
                      , bench "lcm" $ nf (lcm 201 :: Int -> Int) 67
                      ]
                , bgroup "isPerfect"
                      [ bench "isPerfect" $ nf isPerfect 318
                      , bench "hsIsPerfect" $ nf hsIsPerfect (318 :: Int)
                      ]
                ]
