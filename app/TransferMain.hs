module TransferMain where

import Control.Concurrent.STM (readTVar, writeTVar, TVar, STM, atomically, newTVar)

type Applicant = String
type Amount = TVar Int
data Account = Account {
  applicant :: Applicant,
  balance :: Amount
}

withdraw :: Account -> Int -> STM ()
withdraw acc amount = do
  bal <- readTVar $ balance acc
  writeTVar (balance acc) (bal - amount)

deposit :: Account -> Int -> STM ()
deposit acc amount = withdraw acc (- amount)

transfer :: Account -> Account -> Int -> IO ()
transfer from to amount = atomically $ do
  withdraw from amount
  deposit to amount

showAccount :: Account -> IO ()
showAccount acc = do
  bal <- atomically (readTVar $ balance acc)
  putStrLn $ "Amount(" ++ applicant acc ++ "):" ++ show bal

makeAccount :: Applicant -> Int -> IO Account
makeAccount applicant' amount = do
  tvar <- atomically (newTVar amount)
  return $ Account applicant' tvar

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

