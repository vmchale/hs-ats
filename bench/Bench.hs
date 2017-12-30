module Main where

import           Criterion.Main
import           Lib
import qualified Math.Combinatorics.Binomial as MB
import qualified Math.Combinatorics.Factorial as MB

main :: IO ()
main =
    defaultMain [ bgroup "factorial"
                      [ bench "factorial" $ nf factorial 12
                      , bench "MB.factorial" $ nf factorial 12
                      ]
                , bgroup "choose"
                      [ bench "choose" $ nf (13 `choose`) 4
                      , bench "MB.choose" $ nf (13 `choose`) 4
                      ]
                ]
