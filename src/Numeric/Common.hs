{-# LANGUAGE CPP #-}

module Numeric.Common ( convertBool
                      , conjugate
                      ) where

import           Data.Word
import           Foreign.C

conjugate :: (Integral a, Integral b) => (CInt -> CInt) -> a -> b
conjugate f = fromIntegral . f . fromIntegral

#if __GLASGOW_HASKELL__ >= 820
convertBool :: CBool -> Bool
#else
convertBool :: CUChar -> Bool
#endif
convertBool = go . fromIntegral
    where
        go :: Word8 -> Bool
        go 0 = False
        go 1 = True
        go _ = False
