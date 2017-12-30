{-# LANGUAGE ForeignFunctionInterface #-}

module Lib
    ( factorial
    , choose
    , doubleFactorial
    ) where

import Control.Composition
import           Foreign.C

foreign import ccall unsafe factorial_ats :: CInt -> CInt
foreign import ccall unsafe choose_ats :: CInt -> CInt -> CInt
foreign import ccall unsafe double_factorial :: CInt -> CInt

{-@ choose :: { n : Nat | n >= 0 } -> { k : Nat | k >= 0 && k <= n } -> Int @-}
choose :: Int -> Int -> Int
choose = fromIntegral .* on choose_ats fromIntegral

doubleFactorial :: Int -> Int
doubleFactorial = fromIntegral . double_factorial . fromIntegral

{-@ factorial :: { n : Nat | n <= 0 } -> Int @-}
factorial :: Int -> Int
factorial = fromIntegral . factorial_ats . fromIntegral
