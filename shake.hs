#!/usr/bin/env stack
-- stack runghc --resolver lts-10.3 --package shake --package split --package shake-ext-0.2.1.0 --install-ghc

import           Data.List                  (intercalate)
import           Data.List.Split            (splitOn)
import           Data.Maybe                 (fromMaybe)
import           Data.Monoid
import           Development.Shake
import           Development.Shake.ATS
import           Development.Shake.FilePath
import           Development.Shake.Linters
import           System.Exit                (ExitCode (..))
import           System.FilePath.Posix

replace :: Eq a => [a] -> [a] -> [a] -> [a]
replace old new = intercalate new . splitOn old

main :: IO ()
main = shakeArgs shakeOptions { shakeFiles = ".shake"
                              , shakeProgress = progressSimple
                              , shakeThreads = 4
                              } $ do

    want [ "cbits/numerics.c"
         , "cbits/number-theory.c"
         , "cbits/combinatorics.c"
         ]

    "ci" ~> do
        need ["cbits/number-theory.c", "cbits/numerics.c", "cbits/combinatorics.c"]
        cmd_ ["cabal", "new-build"]
        cmd_ ["cabal", "new-test"]
        cmd_ ["cabal", "new-build", "-w", "ghc-8.0.2"]
        cmd_ ["cabal", "new-build", "-w", "ghc-7.10.3"]
        cmd_ ["cabal", "new-build", "-w", "ghc-7.8.4"]
        tomlcheck
        yamllint
        cmd_ ["hlint", "bench", "src", "test/", "Setup.hs", "shake.hs"]
        cmd_ ["stack", "build", "--test", "--bench", "--no-run-tests", "--no-run-benchmarks"]
        cmd_ ["cabal", "new-haddock"]
        cmd_ ["weeder"]

    "build" %> \_ -> do
        need ["shake.hs"]
        cmd_ ["sn", "c"]
        cmd_ ["cp", "shake.hs", ".shake/shake.hs"]
        command_ [Cwd ".shake"] "ghc-8.2.2" ["-O", "shake.hs", "-o", "build", "-threaded", "-rtsopts", "-with-rtsopts=-I0 -qg -qb"]
        cmd ["cp", "-f", ".shake/build", "."]

    cgenPretty

    "poly" ~> do
        cmd_ ["sn", "c"]
        removeFilesAfter "." ["//*.c", "tags"]
        cmd ["poly", "src", "Setup.hs", "test", "bench", "shake.hs", "ats-src/"]

    cleanATS
