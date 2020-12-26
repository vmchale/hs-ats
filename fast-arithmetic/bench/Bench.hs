module Main (main) where

import           Criterion.Main
import qualified Math.Combinat.Numbers                 as Ext
import qualified Math.Combinatorics.Exact.Binomial     as Exact
import qualified Math.Combinatorics.Exact.Factorial    as Exact
import qualified Math.NumberTheory.ArithmeticFunctions as Ext
import           Numeric.Combinatorics
import           Numeric.Haskell
import           Numeric.NumberTheory

main :: IO ()
main =
    defaultMain [ bgroup "primality check"
                      [ bench "isPrime" $ nf isPrime 2017
                      , bench "hsIsPrime" $ nf hsIsPrime (2017 :: Int)
                      ]
                , bgroup "semiprimality check"
                      [ bench "isSemiprime" $ nf isSemiprime 57
                      , bench "hsIsSemiprime" $ nf hsIsSemiprime (57 :: Int)
                      ]
                , bgroup "factorial"
                      [ bench "factorial" $ nf factorial 160
                      , bench "Ext.factorial" $ nf Ext.factorial (160 :: Integer)
                      , bench "Exact.factorial" $ nf (Exact.factorial :: Int -> Integer) 160
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
                      , bench "Ext.sigma" $ nf ((Ext.sigma :: Word -> Int -> Int) 1) (115 :: Int)
                      ]
                , bgroup "doubleFactorial"
                      [ bench "doubleFactorial" $ nf doubleFactorial 79
                      , bench "Ext.doubleFactorial" $ nf Ext.doubleFactorial (79 :: Integer)
                      ]
                , bgroup "choose"
                      [ bench "choose" $ nf (choose 322) 16
                      , bench "Ext.binomial" $ nf (Ext.binomial 322) (16 :: Int)
                      , bench "Exact.choose" $ nf (Exact.choose 322) (16 :: Integer)
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
                      [ bench "maxRegions" $ nf maxRegions (45000 :: Int)
                      , bench "hsMaxRegions" $ nf hsMaxRegions (45000 :: Int)
                      ]
                , bgroup "stirling"
                      [ bench "stirling2" $ nf (stirling2 25) 8
                      , bench "Ext.stirling2nd" $ nf (Ext.stirling2nd (25 :: Int)) 8
                      ]
                , bgroup "bell"
                      [ bench "Ext.bell" $ nf Ext.bellNumber (30 :: Int) ]
                ]
