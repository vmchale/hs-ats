import           Numeric.Combinatorics
import           Test.Hspec
import           Test.Hspec.QuickCheck
import qualified Math.Combinatorics.Binomial as Ext
import qualified Math.Combinatorics.Factorial as Ext
import qualified Math.NumberTheory.Primes.Testing as Ext

main :: IO ()
main = hspec $ do
    parallel $ describe "factorial" $
        prop "should agree with the pure Haskell function" $
            \x -> x < 1 || x > 12 || factorial x == Ext.factorial (fromIntegral x)
    parallel $ describe "choose" $
        prop "should agree with the pure Haskell function" $
            \x y -> x < 0 || y < 0 || x > 13 || y > 11 || (x `choose` y) == (x `Ext.choose` y)
    parallel $ describe "isPrime" $
        prop "should agree with the pure Haskell function" $
            \x -> x < 1 || isPrime x == Ext.isCertifiedPrime (fromIntegral x)
