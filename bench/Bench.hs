module Main where

import           Criterion.Main
import           Lib
import qualified Math.Combinatorics.Binomial as Ext
import qualified Math.Combinatorics.Factorial as Ext

hsIsPrime :: Int -> Bool
hsIsPrime x = null [ y | y <- [2..m], x `mod` y == 0]
    where m = floor (sqrt (fromIntegral x))

main :: IO ()
main =
    defaultMain [ bgroup "factorial"
                      [ bench "factorial" $ nf factorial 12
                      , bench "Ext.factorial" $ nf factorial 12
                      ]
                , bgroup "choose"
                      [ bench "choose" $ nf (13 `choose`) 4
                      , bench "Ext.choose" $ nf (13 `choose`) 4
                      ]
                , bgroup "isPrime"
                      [ bench "isPrime" $ nf isPrime 2017
                      , bench "hsIsPrime" $ nf hsIsPrime 2017
                      ]
                ]
