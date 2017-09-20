module IORefMain where

import Lib(incRef)

import System.IO (stdout, hPutStrLn)
import Data.IORef (readIORef, newIORef)

main :: IO ()
main = do
  var <- newIORef 42
  oldval <- readIORef var
  hPutStrLn stdout $ "Before Inc:" ++ (show oldval)
  incRef var
  val <- readIORef var
  hPutStrLn stdout $ "After Inc :" ++ (show val)
