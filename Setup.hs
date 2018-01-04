{-# LANGUAGE CPP               #-}
{-# LANGUAGE OverloadedStrings #-}

#if __GLASGOW_HASKELL__ <= 784
import           Control.Applicative
#endif
import qualified Codec.Archive.Tar                            as Tar
import           Codec.Compression.GZip                       (decompress)
import           Control.Concurrent.ParallelIO.Global
import           Control.Monad                                (unless, when)
import           Distribution.Simple
import           Distribution.Simple.Setup
import           Distribution.Types.GenericPackageDescription
import           Distribution.Types.HookedBuildInfo
import           Distribution.Types.LocalBuildInfo
import           Distribution.Types.PackageDescription
import           Network.HTTP.Client                          hiding (decompress)
import           Network.HTTP.Client.TLS                      (tlsManagerSettings)
import           System.Directory

main = defaultMainWithHooks myHooks

    where myHooks = simpleUserHooks { preConf = buildScript
                                    , postBuild = maybeCleanATS }

maybeCleanATS :: Args -> BuildFlags -> PackageDescription -> LocalBuildInfo -> IO ()
maybeCleanATS _ _ _ li =
    let cf = configConfigurationsFlags (configFlags li) in

    unless ((mkFlagName "development", True) `elem` cf) $
        putStrLn "Cleaning up ATS dependencies..." >>
        cleanATS

cleanATS :: IO ()
cleanATS = removeDirectoryRecursive "ats-deps"

buildScript :: Args -> ConfigFlags -> IO HookedBuildInfo
buildScript _ _ = do

    putStrLn "Setting up ATS dependencies..."

    let libs = zipWith3 buildHelper
            ["ats2-postiats-0.3.8-prelude", "atscntrb-hs-intinf-1.0.6", "atscntrb-libgmp-1.0.4"]
            ["ats-deps/prelude", "ats-deps/contrib/atscntrb-hx-intinf", "ats-deps/contrib/atscntrb-libgmp"]
            ["https://downloads.sourceforge.net/project/ats2-lang/ats2-lang/ats2-postiats-0.3.8/ATS2-Postiats-include-0.3.8.tgz", "https://registry.npmjs.org/atscntrb-hx-intinf/-/atscntrb-hx-intinf-1.0.6.tgz", "https://registry.npmjs.org/atscntrb-libgmp/-/atscntrb-libgmp-1.0.4.tgz" ]
    parallel_ libs >> stopGlobalPool

    pure emptyHookedBuildInfo

buildHelper libName dirName url = do

    needsSetup <- not <$> doesDirectoryExist dirName

    when needsSetup $ do

        putStrLn ("Fetching library " ++ libName ++ "...")
        manager <- newManager tlsManagerSettings
        initialRequest <- parseRequest url
        response <- responseBody <$> httpLbs (initialRequest { method = "GET" }) manager

        putStrLn ("Unpacking library " ++ libName ++ "...")
        Tar.unpack dirName . Tar.read . decompress $ response

        putStrLn ("Setting up library " ++ libName ++ "...")
        needsMove <- doesDirectoryExist (dirName ++ "/package")
        when needsMove $ do
            renameDirectory (dirName ++ "/package") "tempdir"
            removeDirectory dirName
            renameDirectory "tempdir" dirName
