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
                , bgroup "φ"
                      [ bench "totient" $ nf totient 2016
                      , bench "hsTotient" $ nf (hsTotient :: Int -> Int) 2016
                      ]
                , bgroup "τ"
                      [ bench "tau" $ nf tau 3018
                      , bench "hsTau" $ nf hsTau (3018 :: Int)
                      ]
                , bgroup "ω"
                      [ bench "littleOmega" $ nf littleOmega 91
                      , bench "hsLittleOmega" $ nf hsLittleOmega (91 :: Int)
                      ]
                , bgroup "perfection check"
                      [ bench "isPerfect" $ nf isPerfect 318
                      , bench "hsIsPerfect" $ nf hsIsPerfect (318 :: Int)
                      ]
                ]
