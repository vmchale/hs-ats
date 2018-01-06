module Numeric.Combinatorics ( factorialRaw
                             ) where

import           Foreign.C

foreign import ccall unsafe factorial_ats :: CInt -> CString

-- | This currently returns a byte array representing the integer value.
factorialRaw :: Int -> CString
factorialRaw = factorial_ats . fromIntegral
