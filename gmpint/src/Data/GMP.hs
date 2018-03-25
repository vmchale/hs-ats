{-# LANGUAGE CApiFFI #-}

{-|
Module      : Data.GMP
Copyright   : Copyright (c) 2018 Vanessa McHale

This module defines a storable instance for GMP's @mpz@ integer type.
-}

module Data.GMP ( GMPInt (..)
                , gmpToInteger
                , conjugateGMP
                , integerToGMP
                ) where

import           Control.Monad         ((<=<))
import           Data.Functor.Foldable
import           Data.Word
import           Foreign
import           Foreign.C

-- | The GMP integer type holds information about array size as well as
-- a pointer to an array.
data GMPInt = GMPInt {
                       _mp_alloc :: !Word32 -- ^ Number of limbs allocated.
                     , _mp_size  :: !Word32 -- ^ Number of limbs used.
                     , _mp_d     :: !(Ptr Word64) -- ^ Pointer to an array containing the limbs.
                     }

foreign import capi "&mpz_free" mpz_free :: FunPtr (Ptr GMPInt -> IO ())

wordWidth :: Int
wordWidth = sizeOf (undefined :: Word32)

ptrWidth :: Int
ptrWidth = sizeOf (undefined :: Ptr Word64)

gmpToList :: GMPInt -> IO [Word64]
gmpToList (GMPInt _ s aptr) = peekArray (fromIntegral s) aptr

integerToWordList :: Integer -> [Word64]
integerToWordList i
    | i < 2 ^ (64 :: Int) = [fromIntegral i]
    | otherwise = fromIntegral (i `mod` (2 ^ (64 :: Int))) : integerToWordList (i `div` (2 ^ (64 :: Int)))
{-# INLINEABLE integerToWordList #-}

wordListToInteger :: [Word64] -> Integer
wordListToInteger = cata a where
    a Nil         = 0
    a (Cons x xs) = fromIntegral x + (2 ^ (64 :: Int)) * xs
{-# INLINEABLE wordListToInteger #-}

integerToGMP :: Integer -> IO GMPInt
integerToGMP i = GMPInt l l <$> newArray ls
    where l = fromIntegral . length $ ls
          ls = integerToWordList i

gmpForeignPtr :: Ptr GMPInt -> IO (ForeignPtr GMPInt)
gmpForeignPtr = newForeignPtr mpz_free

conjugateGMP :: (CInt -> Ptr GMPInt) -> Int -> IO Integer
conjugateGMP f = gmpToInteger <=< flip withForeignPtr peek <=< (gmpForeignPtr . f . fromIntegral)

-- | Convert a GMP @mpz@ to Haskell's 'Integer' type.
gmpToInteger :: GMPInt -> IO Integer
gmpToInteger = fmap wordListToInteger . gmpToList

instance Storable GMPInt where
    sizeOf _ = 2 * wordWidth + ptrWidth
    {-# INLINEABLE sizeOf #-}
    alignment _ = gcd wordWidth ptrWidth
    {-# INLINEABLE alignment #-}
    peek ptr = GMPInt <$> peekByteOff ptr 0 <*> peekByteOff ptr wordWidth <*> peekByteOff ptr (wordWidth * 2)
    {-# INLINEABLE peek #-}
    poke ptr (GMPInt a s d) =
        pokeByteOff ptr 0 a >>
        pokeByteOff ptr wordWidth s >>
        pokeByteOff ptr (wordWidth * 2) d
    {-# INLINEABLE poke #-}
