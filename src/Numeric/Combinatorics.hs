{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric  #-}

-- | This module is somewhat experimental.
module Numeric.Combinatorics ( factorial
                             , choose
                             ) where

import           Control.Composition
import           Control.DeepSeq       (NFData)
import           Data.Word
import           Foreign.C
import           Foreign.Marshal.Array
import           Foreign.Ptr
import           Foreign.Storable
import           GHC.Generics          (Generic)

data GMPInt = GMPInt { _mp_alloc :: Word32, _mp_size :: Word32, _mp_d :: Ptr Word8 }
    deriving (Generic, NFData, Show)

wordWidth :: Int
wordWidth = sizeOf (undefined :: Word32)

ptrWidth :: Int
ptrWidth = sizeOf (undefined :: Ptr Word8)

gmpToList :: GMPInt -> IO [Word8]
gmpToList (GMPInt a _ aptr) = peekArray (fromIntegral a) aptr

wordListToInteger :: [Word8] -> Integer
wordListToInteger []     = 0
wordListToInteger (x:xs) = fromIntegral x + 256 * (wordListToInteger xs)

gmpToInteger :: GMPInt -> IO Integer
gmpToInteger = fmap wordListToInteger . gmpToList

instance Storable GMPInt where
    sizeOf _ = 2 * wordWidth + ptrWidth
    alignment _ = gcd wordWidth ptrWidth
    peek ptr = GMPInt <$> peekByteOff ptr 0 <*> peekByteOff ptr wordWidth <*> peekByteOff ptr (wordWidth * 2)
    poke = undefined

foreign import ccall unsafe factorial_ats :: CInt -> Ptr GMPInt
foreign import ccall unsafe choose_ats :: CInt -> CInt -> Ptr GMPInt

factorial :: Int -> IO Integer
factorial = gmpToInteger <=< (peek . factorial_ats . fromIntegral)

choose :: Int -> Int -> IO Integer
choose = (gmpToInteger <=<) . (peek .* on choose_ats fromIntegral)
