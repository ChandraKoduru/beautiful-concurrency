module BankingSystem where

import Control.Concurrent.STM (readTVar, writeTVar, TVar, STM, atomically, newTVar)

type Applicant = String
type Amount = TVar Int

data Account = Account {
  applicant :: Applicant,
  balance :: Amount
}

getBalance :: Account -> IO Int
getBalance account = atomically (readTVar $ balance account)

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


