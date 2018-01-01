#!/usr/bin/env stack
-- stack runghc --resolver lts-10.0 --package shake --package split --install-ghc

import           Data.List                  (intercalate)
import           Data.List.Split            (splitOn)
import           Data.Maybe                 (fromMaybe)
import           Data.Monoid
import           Development.Shake
import           Development.Shake.FilePath
import           System.Exit                (ExitCode (..))
import           System.FilePath.Posix

replace :: Eq a => [a] -> [a] -> [a] -> [a]
replace old new = intercalate new . splitOn old

main :: IO ()
main = shakeArgs shakeOptions { shakeFiles = ".shake"
                              , shakeProgress = progressSimple
                              , shakeThreads = 4
                              } $ do

    want [ "cbits/combinatorics-ffi.c"
         , "cbits/numerics-ffi.c"
         , "cbits/number-theory-ffi.c"
         ]

    "ci" ~> do
        cmd_ ["cabal", "new-build"]
        cmd_ ["cabal", "new-test"]
        cmd_ ["cabal", "new-haddock"]
        cmd_ ["hlint", "bench", "src", "test/", "Setup.hs"]
        cmd_ ["tomlcheck", "--file", ".atsfmt.toml"]
        cmd_ ["yamllint", ".travis.yml"]
        cmd_ ["yamllint", ".hlint.yaml"]
        cmd_ ["yamllint", ".stylish-haskell.yaml"]
        cmd_ ["yamllint", ".yamllint"]
        cmd_ ["stack", "build", "--test", "--bench", "--no-run-tests", "--no-run-benchmarks"]
        cmd_ ["weeder"]

    "build" %> \_ -> do
        need ["shake.hs"]
        cmd_ ["cp", "shake.hs", ".shake/shake.hs"]
        command_ [Cwd ".shake"] "ghc-8.2.2" ["-O", "shake.hs", "-o", "build", "-threaded", "-rtsopts", "-with-rtsopts=-I0 -qg -qb"]
        cmd ["cp", ".shake/build", "."]

    "//*.c" %> \out -> do
        let patshome = "/usr/local/lib/ats2-postiats-0.3.8"
        let preSource = dropDirectory1 out
        let sourceFile = preSource -<.> "dats"
        let sourcePlain = replace "-ffi" "" sourceFile
        need (("ats-src/" ++) <$> [sourceFile, sourcePlain])
        (Exit c, Stderr err, Stdout output) <- command [EchoStderr False, AddEnv "PATSHOME" patshome] "patsopt" ["-dd", "ats-src/" ++ sourceFile, "-cc"]
        cmd_ [Stdin err] Shell "pats-filter"
        if c /= ExitSuccess
            then error "patscc failure"
            else pure ()
        liftIO $ writeFile out output

    "clean" ~> do
        cmd_ ["sn", "c"]
        removeFilesAfter "." ["//*.c", "//tags"]
        removeFilesAfter ".shake" ["//*"]
        removeFilesAfter "ATS2-Postiats-include-0.3.8" ["//*"]
