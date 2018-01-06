{-# LANGUAGE CPP #-}

-- | This module defines a storable instance for GMP's integer type.

module Data.GMP ( GMPInt (..)
                , gmpToInteger
                ) where

#if __GLASGOW_HASKELL__ <= 784
import           Control.Applicative
#endif
import           Data.Word
import           Foreign.Marshal.Array
import           Foreign.Ptr
import           Foreign.Storable

data GMPInt = GMPInt { _mp_alloc :: Word32, _mp_size :: Word32, _mp_d :: Ptr Word64 }

wordWidth :: Int
wordWidth = sizeOf (undefined :: Word32)

ptrWidth :: Int
ptrWidth = sizeOf (undefined :: Ptr Word64)

gmpToList :: GMPInt -> IO [Word64]
gmpToList (GMPInt a _ aptr) = peekArray (fromIntegral a) aptr

wordListToInteger :: [Word64] -> Integer
wordListToInteger []     = 0
wordListToInteger (x:xs) = fromIntegral x + (2 ^ (64 :: Integer)) * wordListToInteger xs

gmpToInteger :: GMPInt -> IO Integer
gmpToInteger = fmap wordListToInteger . gmpToList

instance Storable GMPInt where
    sizeOf _ = 2 * wordWidth + ptrWidth
    alignment _ = gcd wordWidth ptrWidth
    peek ptr = GMPInt <$> peekByteOff ptr 0 <*> peekByteOff ptr wordWidth <*> peekByteOff ptr (wordWidth * 2)
    poke = undefined

