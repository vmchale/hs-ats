{-# LANGUAGE CPP #-}

module Numeric.Common ( conjugate
                      , asTest
                      , conjugateTwo
                      ) where

import           Control.Composition
import           Data.Word
import           Foreign.C

#if __GLASGOW_HASKELL__ >= 820
asTest :: Integral a => (CInt -> CBool) -> a -> Bool
#else
asTest :: Integral a => (CInt -> CUChar) -> a -> Bool
#endif
asTest f = convertBool . f . fromIntegral

conjugateTwo :: (Integral a, Integral b) => (CInt -> CInt -> CInt) -> a -> a -> b
conjugateTwo f = fromIntegral .* on f fromIntegral

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
