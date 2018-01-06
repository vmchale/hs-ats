-- | The "Raw" versions of functions are included here for purposes of
-- benchmarking.
module Numeric.Combinatorics ( factorialRaw
                             , chooseRaw
                             ) where

import           Control.Composition
import           Foreign.C

foreign import ccall unsafe factorial_ats :: CInt -> CString
foreign import ccall unsafe choose_ats :: CInt -> CInt -> CString

-- | This currently returns a byte array representing the integer value.
factorialRaw :: Int -> CString
factorialRaw = factorial_ats . fromIntegral

chooseRaw :: Int -> Int -> CString
chooseRaw = on choose_ats fromIntegral
