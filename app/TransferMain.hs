module TransferMain where

import BankingSystem (transfer, showAccount, makeAccount)

main :: IO ()
main = do
  from <- makeAccount "From" 100
  to <- makeAccount "To" 100
  putStrLn "Before Transfer:"
  showAccount from
  showAccount to
  putStrLn $ "Transferring...." ++ show (50 :: Integer)
  transfer from to 50
  putStrLn "After Transfer:"
  showAccount from
  showAccount to

