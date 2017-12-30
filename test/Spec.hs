import           Lib
import           Test.Hspec
import           Test.Hspec.QuickCheck
import qualified Math.Combinatorics.Binomial as MB
import qualified Math.Combinatorics.Factorial as MB

main :: IO ()
main = hspec $ do
    parallel $ describe "factorial" $
        prop "should agree with the pure Haskell function" $
            \x -> x < 1 || x > 12 || factorial x == MB.factorial (fromIntegral x)
    parallel $ describe "choose" $
        prop "should agree with the pure Haskell function" $
            \x y -> x < 0 || y < 0 || x > 13 || y > 10 || (x `choose` y) == (x `MB.choose` y)
