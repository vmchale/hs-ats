{-# LANGUAGE DeriveFunctor #-}

module Control.Recursion ( Fix (..)
                         , ListF (..)
                         , coelgot
                         , cata
                         , project
                         , embed
                         ) where

import           Control.Arrow ((&&&))

coelgot :: Functor f => ((a, f b) -> b) -> (a -> f a) -> a -> b
coelgot f g = h where h = f . (id &&& fmap h . g)

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

embed :: ListF a [a] -> [a]
embed Nil         = []
embed (Cons x xs) = x : xs
