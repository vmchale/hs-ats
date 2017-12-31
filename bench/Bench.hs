module Main where

import           Criterion.Main
import           Numeric.Combinatorics
import           Numeric.Pure.Combinatorics

main :: IO ()
main =
    defaultMain [ bgroup "factorial"
                      [ bench "factorial" $ nf factorial 12
                      , bench "hsFactorial" $ nf hsFactorial 12
                      ]
                , bgroup "choose"
                      [ bench "choose" $ nf (13 `choose`) 4
                      , bench "hsChoose" $ nf (13 `hsChoose`) 4
                      ]
                , bgroup "isPrime"
                      [ bench "isPrime" $ nf isPrime 2017
                      , bench "hsIsPrime" $ nf hsIsPrime 2017
                      ]
                , bgroup "integerExp"
                      [ bench "integerExp" $ nf (integerExp 3) 7
                      , bench "^" $ nf (3 ^) 7
                      ]
                ]
