{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
#if __GLASGOW_HASKELL__ >= 810
{-# OPTIONS_GHC -Wno-prepositive-qualified-module #-}
#endif
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_trabalhoLP (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath




bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "C:\\Users\\anton\\OneDrive\\Documentos\\LP\\.stack-work\\install\\c624e8ff\\bin"
libdir     = "C:\\Users\\anton\\OneDrive\\Documentos\\LP\\.stack-work\\install\\c624e8ff\\lib\\x86_64-windows-ghc-9.6.3\\trabalhoLP-0.1.0.0-ErZYHePSB1v2tc6lu8SIpP-trabalhoLP"
dynlibdir  = "C:\\Users\\anton\\OneDrive\\Documentos\\LP\\.stack-work\\install\\c624e8ff\\lib\\x86_64-windows-ghc-9.6.3"
datadir    = "C:\\Users\\anton\\OneDrive\\Documentos\\LP\\.stack-work\\install\\c624e8ff\\share\\x86_64-windows-ghc-9.6.3\\trabalhoLP-0.1.0.0"
libexecdir = "C:\\Users\\anton\\OneDrive\\Documentos\\LP\\.stack-work\\install\\c624e8ff\\libexec\\x86_64-windows-ghc-9.6.3\\trabalhoLP-0.1.0.0"
sysconfdir = "C:\\Users\\anton\\OneDrive\\Documentos\\LP\\.stack-work\\install\\c624e8ff\\etc"

getBinDir     = catchIO (getEnv "trabalhoLP_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "trabalhoLP_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "trabalhoLP_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "trabalhoLP_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "trabalhoLP_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "trabalhoLP_sysconfdir") (\_ -> return sysconfdir)



joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '\\'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/' || c == '\\'
