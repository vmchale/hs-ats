-- vim: filetype=hspec
module Main (main) where

import qualified Math.Combinat.Numbers                 as Ext
import qualified Math.NumberTheory.ArithmeticFunctions as Ext
import           Numeric.Combinatorics
import           Numeric.Haskell
import           Numeric.NumberTheory
import           Test.Hspec
import           Test.Hspec.QuickCheck
import           Test.QuickCheck                       hiding (choose)

agreeL :: (Eq a, Show b, Integral b, Arbitrary b) => b -> String -> (b -> a) -> (b -> a) -> SpecWith ()
agreeL lower s f g = describe s $
    prop "should agree with the pure Haskell function" $
        \n -> n < lower || f n == g n

agree :: (Eq a, Show b, Integral b, Arbitrary b) => String -> (b -> a) -> (b -> a) -> SpecWith ()
agree = agreeL 1

main :: IO ()
main = hspec $ parallel $ do

    sequence_ $ zipWith3 agree
        ["totient", "tau", "littleOmega", "sumDivisors"]
        [totient, tau, littleOmega, sumDivisors]
        [Ext.totient, Ext.tau, Ext.smallOmega, Ext.sigma 1]

    sequence_ $ zipWith3 (agreeL 0)
        ["catalan", "doubleFactorial", "factorial", "maxRegions"]
        [catalan, doubleFactorial, factorial, maxRegions]
        [Ext.catalan, Ext.doubleFactorial, Ext.factorial, hsMaxRegions]

    sequence_ $ zipWith3 agree
        ["isPrime"]
        [isPrime]
        [hsIsPrime]

    describe "jacobi" $
        prop "should match the arithmoi function" $
            pendingWith "not yet" -- \p q -> p < 0 || not (isPrime q) || q <= 2 || jacobi p q == toInt (Ext.jacobi p q)
    describe "stirling2" $
        prop "should agree" $
            \n k -> n < 0 || k < 0 || stirling2 n k == Ext.stirling2nd n k
    describe "choose" $
        prop "should agree" $
            \a b -> a < 0 || b < 0 || choose b a == Ext.binomial b a
    describe "derangement" $
        prop "should agree" $
            \a -> a < 1 || derangement a == hsDerangement a
    describe "permutations" $
        prop "should agree" $
            \n k -> k < 1 || k > n || permutations n k == hsPermutations (fromIntegral n) (fromIntegral k)
    describe "derangement" $
        prop "should be equal to [n!/e]" $
            \n -> n < 1 || n > 18 || (derangement n :: Integer) == floor ((fromIntegral (Ext.factorial (fromIntegral n :: Int) :: Integer) :: Double) / exp 1 + 0.5)
    describe "totient" $
        prop "should satisfy Fermat's little theorem" $
            \a m -> a < 1 || m < 2 || gcd a m /= 1 || ((a ^ totient (fromIntegral m)) `mod` m == (1 :: Integer))
    describe "totient" $
        prop "should be equal to p-1 for p prime" $
            \p -> p < 1 || not (isPrime p) || totient p == p - 1
    describe "stirling" $
        prop "should obey the identity I found on Wolfram MathWorld" $
            \n -> n <= 1 || sum [ ((-1) ^ m) * factorial (m-1) * stirling2 n m | m <- [1..n] ] == 0
