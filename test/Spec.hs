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
main = hspec $ do
    parallel $ describe "factorial" $
        prop "should agree with the pure Haskell function" $
            \x -> x < 1 || x > 12 || factorial x == hsFactorial x
    parallel $ describe "doubleFactorial" $
        prop "should agree with the pure Haskell function" $
            \x -> x < 0 || x > 19 || doubleFactorial x == hsDoubleFactorial x
    parallel $ describe "choose" $
        prop "should agree with the pure Haskell function" $
            \x y -> x < 0 || y < 0 || x > 12 || y > 11 || (x `choose` y) == (x `hsChoose` y)
    parallel $ describe "isPrime" $
        prop "should agree with the pure Haskell function" $
            \x -> x < 1 || isPrime x == hsIsPrime x
    parallel $ describe "integerExp" $
        prop "should agree with the pure Haskell function" $
            \a k -> a < 0 || k < 0 || tooBig a k || (a == 0 && k == 0) || integerExp a k == a ^ k
    parallel $ describe "totient" $
        prop "should agree with the pure Haskell function" $
            \m -> m < 2 || totient m == hsTotient m
    parallel $ describe "totient" $
        prop "should be equal to m-1 for m prime" $
            \m -> m < 2 || not (isPrime m) || totient m == m - 1
    parallel $ describe "totient" $
        prop "should satisfy Fermat's little theorem" $
            \a m -> a < 1 || m < 2 || gcd a m /= 1 || tooBig a m || (a ^ (totient m)) `mod` m == 1
    parallel $ describe "tau" $
        prop "should agree with the pure Haskell function" $
            \n -> n < 1 || tau n == hsTau n
