module Numeric.Integer ( integerExp
                       ) where

import           Control.Composition
import           Foreign.C

foreign import ccall unsafe exp_ats :: CInt -> CInt -> CInt

integerExp :: Int -> Int -> Int
integerExp = fromIntegral .* on exp_ats fromIntegral
