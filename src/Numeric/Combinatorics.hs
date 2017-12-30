{-# LANGUAGE ForeignFunctionInterface #-}

module Numeric.Combinatorics
    ( factorial
    , choose
    , doubleFactorial
    , isPrime
    ) where

import           Control.Composition
import           Data.Word
import           Foreign.C

foreign import ccall unsafe factorial_ats :: CInt -> CInt
foreign import ccall unsafe choose_ats :: CInt -> CInt -> CInt
foreign import ccall unsafe double_factorial :: CInt -> CInt
foreign import ccall unsafe is_prime_ats :: CInt -> CBool

convertBool :: CBool -> Bool
convertBool = go . fromIntegral
    where
        go :: Word8 -> Bool
        go 0 = False
        go 1 = True
        go _ = False

isPrime :: Int -> Bool
isPrime = convertBool . is_prime_ats . fromIntegral

{-@ choose :: { n : Nat | n >= 0 } -> { k : Nat | k >= 0 && k <= n } -> Int @-}
choose :: Int -> Int -> Int
choose = fromIntegral .* on choose_ats fromIntegral

doubleFactorial :: Int -> Int
doubleFactorial = fromIntegral . double_factorial . fromIntegral

{-@ factorial :: { n : Nat | n <= 0 } -> Int @-}
factorial :: Int -> Int
factorial = fromIntegral . factorial_ats . fromIntegral
