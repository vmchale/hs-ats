module Numeric.Common ( conjugate
                      , asTest
                      ) where

import           Data.Word
import           Foreign.C

asTest :: Integral a => (CInt -> CUChar) -> a -> Bool
asTest f = convertBool . f . fromIntegral

conjugate :: (Integral a, Integral b) => (CInt -> CInt) -> a -> b
conjugate f = fromIntegral . f . fromIntegral

convertBool :: CUChar -> Bool
convertBool = go . fromIntegral
    where
        go :: Word8 -> Bool
        go 0 = False
        go 1 = True
        go _ = error "converBool failed"
