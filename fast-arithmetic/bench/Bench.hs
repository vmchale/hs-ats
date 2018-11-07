module Main (main) where

import           Criterion.Main
import qualified Math.Combinat.Numbers                 as Ext
import qualified Math.NumberTheory.ArithmeticFunctions as Ext
import           Numeric.Combinatorics
import           Numeric.NumberTheory

hsPermutations :: Integral a => a -> a -> a
hsPermutations n k = product [(n-k+1)..n]

hsIsPrime :: (Integral a) => a -> Bool
hsIsPrime 1 = False
hsIsPrime x = all ((/=0) . (x `rem`)) [2..up]
    where up = floor (sqrt (fromIntegral x :: Double))

hsMaxRegions :: Int -> Integer
hsMaxRegions n = sum $ fmap (n `Ext.binomial`) [0..4]

main :: IO ()
main =
    defaultMain [ bgroup "primality check"
                      [ bench "isPrime" $ nf isPrime 2017
                      , bench "hsIsPrime" $ nf hsIsPrime (2017 :: Int)
                      ]
                , bgroup "factorial"
                      [ bench "factorial" $ nf factorial 160
                      , bench "Ext.factorial" $ nf Ext.factorial (160 :: Integer)
                      ]
                , bgroup "φ"
                      [ bench "totient" $ nf totient 2016
                      , bench "Ext.totient" $ nf Ext.totient (2016 :: Int)
                      ]
                , bgroup "τ"
                      [ bench "tau" $ nf tau 3018
                      , bench "Ext.tau" $ nf (Ext.tau :: Int -> Int) 3018
                      ]
                , bgroup "ω"
                      [ bench "littleOmega" $ nf littleOmega 91
                      , bench "Ext.smallOmega" $ nf (Ext.smallOmega :: Int -> Int) 91
                      ]
                , bgroup "σ"
                      [ bench "sumDivisors" $ nf sumDivisors 115
                      , bench "Ext.sigma" $ nf (Ext.sigma 1) (115 :: Int)
                      ]
                , bgroup "doubleFactorial"
                      [ bench "doubleFactorial" $ nf doubleFactorial 79
                      , bench "Ext.doubleFactorial" $ nf Ext.doubleFactorial (79 :: Integer)
                      ]
                , bgroup "choose"
                      [ bench "choose" $ nf (choose 322) 16
                      , bench "Ext.binomial" $ nf (Ext.binomial 322) (16 :: Int)
                      ]
                , bgroup "catalan"
                      [ bench "catalan" $ nf catalan 300
                      , bench "Ext.catalan" $ nf Ext.catalan (300 :: Int)
                      ]
                , bgroup "permutations"
                      [ bench "permutations" $ nf (permutations 10) 20
                      , bench "hsPermutations" $ nf (hsPermutations 10) (20 :: Integer)
                      ]
                , bgroup "maxRegions"
                      [ bench "maxRegions" $ nf maxRegions 45000
                      , bench "hsMaxRegions" $ nf hsMaxRegions 45000
                      ]
                , bgroup "stirling"
                      [ bench "striling2" $ nf (stirling2 25) 8
                      , bench "Ext.stirling2nd" $ nf (Ext.stirling2nd (25 :: Int)) 8
                      ]
                ]
