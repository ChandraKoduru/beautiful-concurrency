module Lib where

import Data.IORef (IORef, readIORef, writeIORef)

incRef :: IORef Int -> IO ()
incRef var = do
  val <- readIORef var
  writeIORef var (val + 1)

sayHello :: IO ()
sayHello = putStrLn "Hello world!"
