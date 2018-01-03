{-# OPTIONS_GHC -Wall -Werror -Wincomplete-uni-patterns -Wincomplete-record-updates -Wcompat -fno-warn-missing-signatures #-}
{-# LANGUAGE CPP               #-}
{-# LANGUAGE OverloadedStrings #-}

#if __GLASGOW_HASKELL__ <= 784
import           Control.Applicative
#endif
import qualified Codec.Archive.Tar                     as Tar
import           Codec.Compression.GZip                (decompress)
import           Control.Monad                         (when)
import           Distribution.Simple
import           Distribution.Simple.Setup
import           Distribution.Types.HookedBuildInfo
import           Distribution.Types.PackageDescription
import           Network.HTTP.Client                   hiding (decompress)
import           Network.HTTP.Client.TLS               (tlsManagerSettings)
import           System.Directory

-- TODO add a
-- ideally controllable with a build flag?
main = defaultMainWithHooks myHooks
    where myHooks = simpleUserHooks { preConf = buildScript
                                    , postClean = cleanATS }

cleanATS :: Args -> CleanFlags -> PackageDescription -> () -> IO ()
cleanATS _ _ _ _ =
    removeDirectoryRecursive "ATS2-Postiats-include-0.3.8" >>
    removeDirectoryRecursive "node_modules"

buildScript :: Args -> ConfigFlags -> IO HookedBuildInfo
buildScript _ _ =
    buildHelper "ats2-postiats-0.3.8-prelude" "ats-deps/prelude" "https://downloads.sourceforge.net/project/ats2-lang/ats2-lang/ats2-postiats-0.3.8/ATS2-Postiats-include-0.3.8.tgz" >>
    buildHelper "atscntrb-hs-intinf-1.0.6" "ats-deps/contrib/atscntrb-hx-intinf" "https://registry.npmjs.org/atscntrb-hx-intinf/-/atscntrb-hx-intinf-1.0.6.tgz" >>
    buildHelper "atscntrb-libgmp-1.0.4" "ats-deps/contrib/atscntrb-libgmp" "https://registry.npmjs.org/atscntrb-libgmp/-/atscntrb-libgmp-1.0.4.tgz"

buildHelper libName dirName url = do

    needsSetup <- not <$> doesDirectoryExist dirName

    when needsSetup $ do

        putStrLn ("Fetching library " ++ libName ++ "...")
        manager <- newManager tlsManagerSettings
        initialRequest <- parseRequest url
        response <- responseBody <$> httpLbs (initialRequest { method = "GET" }) manager

        putStrLn ("Unpacking library " ++ libName ++ "...")
        Tar.unpack dirName . Tar.read . decompress $ response

        needsMove <- doesDirectoryExist (dirName ++ "/package")
        when needsMove $ do
            renameDirectory (dirName ++ "/package") "tempdir"
            removeDirectory dirName
            renameDirectory "tempdir" dirName

    pure emptyHookedBuildInfo
