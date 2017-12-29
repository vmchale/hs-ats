{-# LANGUAGE ForeignFunctionInterface #-}

module Lib
    ( factorial
    , choose
    ) where

import           Foreign.C

foreign import ccall unsafe factorial_ats :: CInt -> CInt
foreign import ccall unsafe choose_ats :: CInt -> CInt -> CInt

choose :: Int -> Int -> Int
choose n k = fromIntegral (choose_ats (fromIntegral n) (fromIntegral k))

factorial :: Int -> Int
factorial = fromIntegral . factorial_ats . fromIntegral
