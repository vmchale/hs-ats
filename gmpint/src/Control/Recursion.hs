{-# LANGUAGE DeriveFunctor #-}

module Control.Recursion ( Fix (..)
                         , ListF (..)
                         , coelgot
                         , cata
                         , project
                         , embed
                         ) where

import           Control.Arrow ((&&&))

newtype Fix f = Fix { unFix :: f (Fix f) }

data ListF a x = Cons a x
               | Nil
               deriving (Functor)

coelgot :: Functor f => ((a, f b) -> b) -> (a -> f a) -> a -> b
coelgot f g = h where h = f . (id &&& fmap h . g)

cata :: Functor f => (f a -> a) -> (Fix f -> a)
cata a = g where g = a . fmap g . unFix

project :: [a] -> Fix (ListF a)
project []     = Fix Nil
project (x:xs) = Fix (Cons x (project xs))

embed :: ListF a [a] -> [a]
embed Nil         = []
embed (Cons x xs) = x : xs
