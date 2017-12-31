import           Numeric.Combinatorics
import           Numeric.Integer
import           Numeric.Pure.Combinatorics
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
    parallel $ describe "choose" $
        prop "should agree with the pure Haskell function" $
            \x y -> x < 0 || y < 0 || x > 13 || y > 11 || (x `choose` y) == (x `hsChoose` y)
    parallel $ describe "isPrime" $
        prop "should agree with the pure Haskell function" $
            \x -> x < 1 || isPrime x == hsIsPrime x
    parallel $ describe "integerExp" $
        prop "should agree with the pure Haskell function" $
            \a k -> a < 0 || k < 0 || tooBig a k || (a == 0 && k == 0) || integerExp a k == a ^ k
