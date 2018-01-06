-- | This module is somewhat experimental.
module Numeric.Combinatorics ( factorial
                             , choose
                             ) where

import           Control.Composition
import           Data.Word
import           Foreign.C
import           Foreign.Ptr
import           Foreign.Storable

-- useAsCString - fast parser?
-- TODO storable instance for mpz_t variables
-- field #1: _mp_size, number of limbs or negative of that. when it is zero, the
-- rest doesn't matter
-- field #2: _mp_d, a pointer to an array of limbs.

data GMPInt = GMPInt Int Int (Ptr Word8)

intWidth :: Int
intWidth = sizeOf (undefined :: Int)

ptrWidth :: Int
ptrWidth = sizeOf (undefined :: Int)

instance Storable GMPInt where
    sizeOf _ = 2 * intWidth + ptrWidth
    alignment _ = gcd intWidth ptrWidth
    peek ptr = GMPInt <$> peekByteOff ptr 0 <*> peekByteOff ptr intWidth <*> peekByteOff ptr 5
    poke = undefined

{- typedef struct -}
{- { -}
  {- int _mp_alloc; /* Number of *limbs* allocated and pointed to by the _mp_d field.  */ -}
  {- int _mp_size; /* abs(_mp_size) is the number of limbs the last field points to.  If _mp_size is negative this is a negative number.  */ -}
  {- mp_limb_t *_mp_d; /* Pointer to the limbs.  */ -}
{- } __mpz_struct; -}

{- A pointer to an array of limbs which is the magnitude. These are stored “little endian” as per the mpn functions, so _mp_d[0] is the least significant limb and _mp_d[ABS(_mp_size)-1] is the most significant. Whenever _mp_size is non-zero, the most significant limb is non-zero.  -}

-- pointer to the limbs is an array of limbs; we need to know how wide the limbs
-- are however.

foreign import ccall unsafe factorial_ats :: CInt -> Ptr GMPInt
foreign import ccall unsafe choose_ats :: CInt -> CInt -> Ptr GMPInt

factorial :: Int -> Ptr GMPInt
factorial = factorial_ats . fromIntegral

choose :: Int -> Int -> Ptr GMPInt
choose = on choose_ats fromIntegral
