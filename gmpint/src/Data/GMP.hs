{-# LANGUAGE DeriveFunctor #-}

{-|
Module      : Data.GMP
Copyright   : Copyright (c) 2018 Vanessa McHale

This module defines a storable instance for GMP's @mpz@ integer type.
-}

module Data.GMP ( GMPInt (..)
                , gmpToInteger
                , conjugateGMP
                , integerToGMP
                , gmpForeignPtr
                ) where

import           Control.Applicative
import           Control.Arrow       ((&&&))
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

wordListToInteger :: [Word64] -> Integer
wordListToInteger []     = 0
wordListToInteger (x:xs) = fromIntegral x + base * wordListToInteger xs

coelgot :: Functor f => ((a, f b) -> b) -> (a -> f a) -> a -> b
coelgot f g = h where h = f . (id &&& fmap h . g)

integerToWordList :: Integer -> [Word64]
integerToWordList = coelgot pa c where
    c i = Cons (fromIntegral (i `rem` base)) (i `quot` base)
    pa (i, ws) | i < base = [fromIntegral i]
               | otherwise = embed ws

newtype Fix f = Fix { unFix :: f (Fix f) }

-- | Catamorphism or generic function fold.
cata :: Functor f => (f a -> a) -> (Fix f -> a)
cata a = go where go = a . fmap go . unFix

data ListF a x = Cons a x
               | Nil
               deriving (Functor)

project :: [a] -> Fix (ListF a)
project []     = Fix Nil
project (x:xs) = Fix (Cons x (project xs))

embed :: Fix (ListF a) -> [a]
embed (Fix Nil)         = []
embed (Fix (Cons x xs)) = x : embed xs

wordListToInteger' :: [Word64] -> Integer
wordListToInteger' = cata a . project where
    a Nil         = 0
    a (Cons x xs) = fromIntegral x + base * xs

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
