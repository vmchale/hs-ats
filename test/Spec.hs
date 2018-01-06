import           Numeric.Combinatorics
import           Numeric.Integer
import           Numeric.NumberTheory
import           Numeric.Pure
import           Test.Hspec
import           Test.Hspec.QuickCheck

tooBig :: Int -> Int -> Bool
tooBig x y = go x y >= 2 ^ (16 :: Integer)
    where
        go :: Int -> Int -> Integer
        go m n = fromIntegral m ^ (fromIntegral n :: Integer)

main :: IO ()
main = hspec $ parallel $ do
    describe "isPrime" $
        prop "should agree with the pure Haskell function" $
            \x -> x < 1 || isPrime x == hsIsPrime x
    describe "totient" $
        prop "should agree with the pure Haskell function" $
            \m -> m < 1 || totient m == hsTotient m
    describe "totient" $
        prop "should be equal to m-1 for m prime" $
            \m -> m < 1 || not (isPrime m) || totient m == m - 1
    describe "totient" $
        prop "should satisfy Fermat's little theorem" $
            \a m -> a < 1 || m < 2 || gcd a m /= 1 || tooBig a m || (a ^ totient m) `mod` m == 1
    describe "tau" $
        prop "should agree with the pure Haskell function" $
            \n -> n < 1 || tau n == hsTau n
    describe "littleOmega" $
        prop "should agree with the pure Haskell function" $
            \n -> n < 1 || littleOmega n == hsLittleOmega n
    describe "isPerfect" $
        prop "should agree with the pure Haskell function" $
            \n -> n < 1 || isPerfect n == hsIsPerfect n
    describe "factorial" $
        it "should agree with the pure Haskell function" $
            factorial 20 >>= (`shouldBe` hsFactorial 20)
