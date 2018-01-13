import           Data.List                             (zipWith4)
import qualified Math.Combinat.Numbers                 as Ext
import qualified Math.NumberTheory.ArithmeticFunctions as Ext
import           Math.NumberTheory.Moduli.Jacobi       (JacobiSymbol (..))
import qualified Math.NumberTheory.Moduli.Jacobi       as Ext
import           Numeric.Combinatorics
import           Numeric.Integer
import           Numeric.NumberTheory
import           Numeric.Pure
import           Test.Hspec
import           Test.Hspec.QuickCheck
import           Test.QuickCheck                       hiding (choose)

toInt :: JacobiSymbol -> Int
toInt MinusOne = -1
toInt Zero     = 0
toInt One      = 1

tooBig :: Int -> Int -> Bool
tooBig x y = go x y >= 2 ^ (16 :: Integer)
    where
        go :: Int -> Int -> Integer
        go m n = fromIntegral m ^ (fromIntegral n :: Integer)

agree :: (Eq a, Show b, Integral b, Arbitrary b) => String -> (b -> a) -> (b -> a) -> SpecWith ()
agree s f g = describe s $
    prop "should agree with the pure Haskell function" $
        \n -> n < 1 || f n == g n

check :: (Eq a, Show a) => String -> (Int -> IO a) -> (Integer -> a) -> Int -> SpecWith ()
check s f g n = describe s $
    it ("should work for n=" ++ show n) $
        f n >>= (`shouldBe` g (fromIntegral n))

main :: IO ()
main = hspec $ parallel $ do

    sequence_ $ zipWith3 agree
        ["totient", "tau", "littleOmega", "sumDivisors"]
        [totient, tau, littleOmega, sumDivisors]
        [Ext.totient, Ext.tau, Ext.smallOmega, Ext.sigma 1]

    sequence_ $ zipWith3 agree
        ["isPrime"]
        [isPrime]
        [hsIsPrime]

    describe "jacobi" $
        it "should match the arithmoi function" $
            pendingWith (const "idk." $ jacobi 15 19 `shouldBe` toInt (Ext.jacobi (15 :: Int) 19))
    describe "totient" $
        prop "should be equal to m-1 for m prime" $
            \m -> m < 1 || not (isPrime m) || totient m == m - 1
    describe "derangement" $
        prop "should be equal to [n!/e]" $
            \n -> n < 1 || n > 18 || (derangement n :: Integer) == floor ((fromIntegral (Ext.factorial (fromIntegral n :: Int) :: Integer) :: Double) / exp 1 + 0.5)
    describe "totient" $
        prop "should satisfy Fermat's little theorem" $
            \a m -> a < 1 || m < 2 || gcd a m /= 1 || tooBig a m || (a ^ totient m) `mod` m == 1

    sequence_ $ zipWith4 check
        ["choose 101", "doubleFactorial", "catalan", "fibonacci", "factorial", "jacobi"]
        [choose 101, doubleFactorial, catalan, fibonacci, factorial]
        [Ext.binomial 101, Ext.doubleFactorial, Ext.catalan, hsFibonacci . fromIntegral, Ext.factorial]
        [16, 79, 300, 121, 231]
