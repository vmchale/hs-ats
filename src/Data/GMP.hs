{-# LANGUAGE CPP #-}

{-|
Module      : Data.GMP
Copyright   : Copyright (c) 2017 Vanessa McHale

This module defines a storable instance for GMP's @mpz@ integer type.
-}



module Data.GMP ( GMPInt (..)
                , gmpToInteger
                , conjugateGMP
                ) where

#if __GLASGOW_HASKELL__ <= 784
import           Control.Applicative
#endif
import           Data.Functor.Foldable
import           Data.Word
import           Foreign.Marshal.Array
import           Foreign.Ptr
import           Foreign.Storable

-- | The GMP integer type holds information about array size as well as
-- a pointer to an array.
data GMPInt = GMPInt {
                       _mp_alloc :: Word32 -- ^ Number of limbs allocated.
                     , _mp_size  :: Word32 -- ^ Number of limbs used.
                     , _mp_d     :: Ptr Word64 -- ^ Pointer to an array containing the limbs.
                     }

wordWidth :: Int
wordWidth = sizeOf (undefined :: Word32)

ptrWidth :: Int
ptrWidth = sizeOf (undefined :: Ptr Word64)

gmpToList :: GMPInt -> IO [Word64]
gmpToList (GMPInt _ s aptr) = peekArray (fromIntegral s) aptr

wordListToInteger :: [Word64] -> Integer
wordListToInteger = cata a where
    a Nil         = 0
    a (Cons x xs) = fromIntegral x + (2 ^ (64 :: Integer)) * xs

conjugateGMP :: (CInt -> Ptr GMPInt) -> Int -> IO Integer
conjugateGMP f = gmpToInteger <=< (peek . f . fromIntegral)

-- | Convert a GMP @mpz@ to Haskell's 'Integer' type.
gmpToInteger :: GMPInt -> IO Integer
gmpToInteger = fmap wordListToInteger . gmpToList

instance Storable GMPInt where
    sizeOf _ = 2 * wordWidth + ptrWidth
    alignment _ = gcd wordWidth ptrWidth
    peek ptr = GMPInt <$> peekByteOff ptr 0 <*> peekByteOff ptr wordWidth <*> peekByteOff ptr (wordWidth * 2)
    poke ptr (GMPInt a s d) =
        pokeByteOff ptr 0 a >>
        pokeByteOff ptr wordWidth s >>
        pokeByteOff ptr (wordWidth * 2) d

