module Main where

import           Criterion.Main
import           Numeric.Combinatorics
import           Numeric.Integer
import           Numeric.Pure

main :: IO ()
main =
    defaultMain [ bgroup "factorial"
                      [ bench "factorial" $ nf factorial 12
                      , bench "hsFactorial" $ nf hsFactorial 12
                      ]
                , bgroup "combinations"
                      [ bench "choose" $ nf (13 `choose`) 4
                      , bench "hsChoose" $ nf (13 `hsChoose`) 4
                      ]
                , bgroup "double factorial"
                      [ bench "doubleFactorial" $ nf doubleFactorial 19
                      , bench "hsDoubleFactorial" $ nf hsDoubleFactorial 19
                      ]
                , bgroup "primality check"
                      [ bench "isPrime" $ nf isPrime 2017
                      , bench "hsIsPrime" $ nf hsIsPrime 2017
                      ]
                , bgroup "integer exponentiation"
                      [ bench "integerExp" $ nf (integerExp 3) 7
                      , bench "^" $ nf ((3 :: Int) ^) (7 :: Int)
                      ]
                ]
