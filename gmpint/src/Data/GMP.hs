{-|
Module      : Data.GMP
Copyright   : Copyright (c) 2018 Vanessa McHale

This module defines a storable instance for GMP's @mpz@ integer type.
-}

module Data.GMP ( GMPInt (..)
                , gmpToInteger
                , integerToGMP
                , gmpForeignPtr
                , conjugateGMP
                , conjugateGMP'
                ) where

import           Control.Applicative
import           Control.Composition
import           Control.Monad       ((<=<))
import           Data.Word
import           Foreign
import           Foreign.C

-- | The GMP integer type holds information about array size as well as
-- a pointer to an array.
data GMPInt = GMPInt {
                       _mp_alloc :: !Word32 -- ^ Number of limbs allocated.
                     , _mp_size  :: !Word32 -- ^ Number of limbs used.
                     , _mp_d     :: !(Ptr Word) -- ^ Pointer to an array containing the limbs.
                     }

foreign import ccall "&__gmpz_clear" mpz_clear :: FunPtr (Ptr GMPInt -> IO ())

wordWidth :: Int
wordWidth = sizeOf (undefined :: Word32)

ptrWidth :: Int
ptrWidth = sizeOf (undefined :: Ptr Word)

gmpToList :: GMPInt -> IO [Word]
gmpToList (GMPInt _ s aptr) = peekArray (fromIntegral s) aptr

base :: Integer
base = 2 ^ (64 :: Int)

integerToWordList :: Integer -> [Word]
integerToWordList i | i < base = [fromIntegral i]
                    | otherwise = fromIntegral (i `rem` base) : integerToWordList (i `quot` base)

wordListToInteger :: [Word] -> Integer
wordListToInteger []     = 0
wordListToInteger (x:xs) = fromIntegral x + base * wordListToInteger xs

integerToGMP :: Integer -> IO GMPInt
integerToGMP i = GMPInt l l <$> newArray ls
    where l = fromIntegral (length ls)
          ls = integerToWordList i

gmpForeignPtr :: Ptr GMPInt -> IO (ForeignPtr GMPInt)
gmpForeignPtr = newForeignPtr mpz_clear

{-# INLINE conjugateGMP' #-}
conjugateGMP' :: (CInt -> CInt -> Ptr GMPInt) -> Int -> Int -> IO Integer
conjugateGMP' f = (gmpToInteger <=<) . (peek .* on f fromIntegral)

conjugateGMP :: (CInt -> Ptr GMPInt) -> Int -> IO Integer
conjugateGMP f = gmpToInteger
    <=< flip withForeignPtr peek
    <=< (gmpForeignPtr . f . fromIntegral)

-- | Convert a GMP @mpz@ to Haskell's 'Integer' type.
gmpToInteger :: GMPInt -> IO Integer
gmpToInteger = fmap wordListToInteger . gmpToList
-- FIXME: figure out SIGSEVs?
-- particularly failure to open a REPL (which is occasional)

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
