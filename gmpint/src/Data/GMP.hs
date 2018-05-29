{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes       #-}
{-# LANGUAGE TypeFamilies     #-}

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

import           Control.Applicative
import           Control.Monad       ((<=<))
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

foreign import ccall "&__gmpz_clear" mpz_clear :: FunPtr (Ptr GMPInt -> IO ())

wordWidth :: Int
wordWidth = sizeOf (undefined :: Word32)

ptrWidth :: Int
ptrWidth = sizeOf (undefined :: Ptr Word64)

gmpToList :: GMPInt -> IO [Word64]
gmpToList (GMPInt _ s aptr) = peekArray (fromIntegral s) aptr

base :: Integer
base = 2 ^ (64 :: Int)

integerToWordList :: Integer -> [Word64]
integerToWordList i | i < base = [fromIntegral i]
                    | otherwise = fromIntegral (i `rem` base) : integerToWordList (i `quot` base)

wordListToInteger :: [Word64] -> Integer
wordListToInteger []     = 0
wordListToInteger (x:xs) = fromIntegral x + base * wordListToInteger xs

integerToGMP :: Integer -> IO GMPInt
integerToGMP i = GMPInt l l <$> newArray ls
    where l = fromIntegral (length ls)
          ls = integerToWordList i

gmpForeignPtr :: Ptr GMPInt -> IO (ForeignPtr GMPInt)
gmpForeignPtr = newForeignPtr mpz_clear

conjugateGMP :: (CInt -> Ptr GMPInt) -> Int -> IO Integer
conjugateGMP f = gmpToInteger
    <=< flip withForeignPtr peek
    <=< (gmpForeignPtr . f . fromIntegral)

-- | Convert a GMP @mpz@ to Haskell's 'Integer' type.
gmpToInteger :: GMPInt -> IO Integer
gmpToInteger = fmap wordListToInteger . gmpToList

instance Storable GMPInt where
    sizeOf _ = 2 * wordWidth + ptrWidth
    alignment _ = gcd wordWidth ptrWidth
    peek ptr = GMPInt
        <$> peekByteOff ptr 0
        <*> peekByteOff ptr wordWidth
        <*> peekByteOff ptr (wordWidth * 2)
    poke ptr (GMPInt a s d) = sequence_
        [ pokeByteOff ptr 0 a
        , pokeByteOff ptr wordWidth s
        , pokeByteOff ptr (wordWidth * 2) d
        ]
