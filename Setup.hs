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

-- TODO make this pre-configure?
main = defaultMainWithHooks myHooks
    where myHooks = simpleUserHooks { preConf = buildScript
                                    , postClean = cleanATS }

cleanATS :: Args -> CleanFlags -> PackageDescription -> () -> IO ()
cleanATS _ _ _ _ = removeDirectoryRecursive "ATS2-Postiats-include-0.3.8"

buildScript :: Args -> ConfigFlags -> IO HookedBuildInfo
buildScript _ _ = do

    needsSetup <- not <$> doesDirectoryExist "ATS2-Postiats-include-0.3.8/prelude"

    when needsSetup $ do

        putStrLn "Fetching libraries..."
        manager <- newManager tlsManagerSettings
        initialRequest <- parseRequest "https://downloads.sourceforge.net/project/ats2-lang/ats2-lang/ats2-postiats-0.3.8/ATS2-Postiats-include-0.3.8.tgz"
        response <- responseBody <$> httpLbs (initialRequest { method = "GET" }) manager

        putStrLn "Unpacking libraries..."
        Tar.unpack "." . Tar.read . decompress $ response

    pure emptyHookedBuildInfo
