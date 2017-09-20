module IOForkMain where

import System.IO (hPutStr, stdout)
import Control.Concurrent (forkIO)

main :: IO ()
main = do
  tid <- forkIO (hPutStr stdout "Hello")
  hPutStr stdout (" world. Tid:" ++ (show tid) ++ "\n")
