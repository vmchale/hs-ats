module Main where

import           Criterion.Main
import qualified Math.Combinat.Numbers                 as Ext
import qualified Math.NumberTheory.ArithmeticFunctions as Ext
import qualified Math.NumberTheory.MoebiusInversion    as Ext
import           Numeric.Combinatorics
import           Numeric.Integer
import           Numeric.NumberTheory

{-# SPECIALIZE hsIsPrime :: Int -> Bool #-}

hsIsPrime :: (Integral a) => a -> Bool
hsIsPrime 1 = False
hsIsPrime x = all ((/=0) . (x `rem`)) [2..up]
    where up = floor (sqrt (fromIntegral x :: Float))

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
                ]
