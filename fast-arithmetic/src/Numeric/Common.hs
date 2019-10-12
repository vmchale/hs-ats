module Numeric.Common ( conjugate
                      , asTest
                      ) where

import           Foreign.C

asTest :: Integral a => (CInt -> CBool) -> a -> Bool
asTest f = convertBool . f . fromIntegral

conjugate :: (Integral a, Integral b) => (CInt -> CInt) -> a -> b
conjugate f = fromIntegral . f . fromIntegral

convertBool :: CBool -> Bool
convertBool = toEnum . fromEnum
