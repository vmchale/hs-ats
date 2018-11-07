module Main (main) where

import qualified Math.Combinat.Numbers                 as Ext
import qualified Math.NumberTheory.ArithmeticFunctions as Ext
import           Numeric.Combinatorics
import           Numeric.NumberTheory
import           Test.Hspec
import           Test.Hspec.QuickCheck
import           Test.QuickCheck                       hiding (choose)

hsPermutations :: Integral a => a -> a -> a
hsPermutations n k = product [(n-k+1)..n]

hsIsPrime :: (Integral a) => a -> Bool
hsIsPrime 1 = False
hsIsPrime x = all ((/=0) . (x `rem`)) [2..up]
    where up = floor (sqrt (fromIntegral x :: Float))

hsDerangement :: (Integral a) => Int -> a
hsDerangement n = derangements !! n

derangements :: (Integral a) => [a]
derangements = fmap snd g
    where g = (0, 1) : (1, 0) : zipWith step g (tail g)
          step (_, n) (i, m) = (i + 1, i * (n + m))

-- FIXME report bug in integer-gmp
tooBig :: Int -> Int -> Bool
tooBig x y = go x y >= 2 ^ (16 :: Integer)
    where
        go :: Int -> Int -> Integer
        go m n = fromIntegral m ^ n

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
        ["catalan", "doubleFactorial", "factorial"]
        [catalan, doubleFactorial, factorial]
        [Ext.catalan, Ext.doubleFactorial, Ext.factorial]

    sequence_ $ zipWith3 agree
        ["isPrime"]
        [isPrime]
        [hsIsPrime]

    describe "jacobi" $
        prop "should match the arithmoi function" $
            pendingWith "not yet" -- \p q -> p < 0 || not (isPrime q) || q <= 2 || jacobi p q == toInt (Ext.jacobi p q)
    describe "totient" $
        prop "should be equal to p-1 for p prime" $
            \p -> p < 1 || not (isPrime p) || totient p == p - 1
    describe "derangement" $
        prop "should be equal to [n!/e]" $
            \n -> n < 1 || n > 18 || (derangement n :: Integer) == floor ((fromIntegral (Ext.factorial (fromIntegral n :: Int) :: Integer) :: Double) / exp 1 + 0.5)
    describe "totient" $
        prop "should satisfy Fermat's little theorem" $
            \a m -> a < 1 || m < 2 || gcd a m /= 1 || tooBig a m || (a ^ totient m) `mod` m == 1
    describe "striling2" $
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
