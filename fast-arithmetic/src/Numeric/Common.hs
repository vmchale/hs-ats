module Numeric.Common ( conjugate
                      , asTest
                      , conjugateMPZ
                      ) where

import           Foreign.C
import           Foreign.Ptr            (Ptr)
import           Numeric.GMP.Raw.Unsafe (mpz_clear)
import           Numeric.GMP.Types
import           Numeric.GMP.Utils
import           System.IO.Unsafe       (unsafeDupablePerformIO)

conjugateMPZ :: (CInt -> IO (Ptr MPZ)) -> Int -> Integer
conjugateMPZ f n = unsafeDupablePerformIO $ do
    mPtr <- f (fromIntegral n)
    peekInteger mPtr <* mpz_clear mPtr

asTest :: Integral a => (CInt -> CBool) -> a -> Bool
asTest f = convertBool . f . fromIntegral

conjugate :: (Integral a, Integral b) => (CInt -> CInt) -> a -> b
conjugate f = fromIntegral . f . fromIntegral

convertBool :: CBool -> Bool
convertBool = toEnum . fromEnum
