module Lib where

import Data.IORef (IORef, readIORef, writeIORef)

incRef :: IORef Int -> IO ()
incRef var = do
  val <- readIORef var
  writeIORef var (val + 1)

sayHello :: IO ()
sayHello = putStrLn "Hello world!"

nTimes :: Int -> IO () -> IO ()
nTimes n action 
  | n <= 0 = return ()
  | otherwise = do
      putStr $ (show n) ++ ": "
      action
      nTimes (n-1) action


