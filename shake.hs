#!/usr/bin/env stack
-- stack runghc --resolver lts-10.2 --package shake --package split --install-ghc

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

    want [ "cbits/numerics.c"
         , "cbits/number-theory.c"
         , "cbits/combinatorics.c"
         ]

    "dist-newstyle/build/x86_64-linux/ghc-8.2.2/fast-arithmetic-0.3.0.0/opt/build/fast-arithmetic-bench/fast-arithmetic-bench" %> \_ ->
        cmd ["cabal", "new-build"]

    "//*.html" %> \out -> do
        need ["dist-newstyle/build/x86_64-linux/ghc-8.2.2/fast-arithmetic-0.3.0.0/opt/build/fast-arithmetic-bench/fast-arithmetic-bench"]
        cmd ["dist-newstyle/build/x86_64-linux/ghc-8.2.2/fast-arithmetic-0.3.0.0/opt/build/fast-arithmetic-bench/fast-arithmetic-bench", "--output=" ++ out]

    "ci" ~> do
        need ["cbits/number-theory.c", "cbits/numerics.c", "cbits/combinatorics.c"]
        cmd_ ["cabal", "new-build"]
        cmd_ ["cabal", "new-test"]
        cmd_ ["cabal", "new-build", "-w", "ghc-8.0.2"]
        cmd_ ["cabal", "new-build", "-w", "ghc-7.10.3"]
        cmd_ ["cabal", "new-build", "-w", "ghc-7.8.4"]
        cmd_ ["hlint", "bench", "src", "test/", "Setup.hs", "shake.hs"]
        cmd_ ["tomlcheck", "--file", ".atsfmt.toml"]
        cmd_ ["yamllint", ".travis.yml"]
        cmd_ ["yamllint", ".hlint.yaml"]
        cmd_ ["yamllint", ".stylish-haskell.yaml"]
        cmd_ ["yamllint", ".yamllint"]
        cmd_ ["stack", "build", "--test", "--bench", "--no-run-tests", "--no-run-benchmarks"]
        cmd_ ["cabal", "new-haddock"]
        cmd_ ["weeder"]

    "build" %> \_ -> do
        need ["shake.hs"]
        cmd_ ["sn", "c"]
        cmd_ ["cp", "shake.hs", ".shake/shake.hs"]
        command_ [Cwd ".shake"] "ghc-8.2.2" ["-O", "shake.hs", "-o", "build", "-threaded", "-rtsopts", "-with-rtsopts=-I0 -qg -qb"]
        cmd ["cp", "-f", ".shake/build", "."]

    "//*.c" %> \out -> do
        let patshome = "/usr/local/lib/ats2-postiats-0.3.8"
        let preSource = dropDirectory1 out
        let sourcePlain = preSource -<.> "dats"
        let sourceFile = replace ".dats" "-ffi.dats" sourcePlain
        need (("ats-src/" ++) <$> [sourceFile, sourcePlain])
        (Exit c, Stderr err) <- command [EchoStderr False, AddEnv "PATSHOME" patshome] "patsopt" ["--output", out, "-dd", "ats-src/" ++ sourceFile, "-cc"]
        cmd_ [Stdin err] Shell "pats-filter" -- TODO automatically build compiler?
        if c /= ExitSuccess
            then error "patscc failure"
            else pure ()

    "poly" ~> do
        cmd_ ["sn", "c"]
        removeFilesAfter "." ["//*.c", "tags"]
        cmd ["poly", "src", "Setup.hs", "test", "bench", "shake.hs", "ats-src/"]

    "clean" ~> do
        cmd_ ["sn", "c"]
        removeFilesAfter "." ["//*.c", "//tags"]
        removeFilesAfter ".shake" ["//*"]
        removeFilesAfter "ats-deps" ["//*"]
