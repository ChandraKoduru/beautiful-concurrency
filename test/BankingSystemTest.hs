{-# OPTIONS_GHC -Wno-unused-imports #-}
{-# OPTIONS_GHC -Wno-orphans #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE InstanceSigs #-}
module BankingSystemTest where

import Control.Concurrent.STM (atomically)
import BankingSystem (makeAccount, transfer, withdraw, getBalance, deposit, Account(applicant))
-- import Test.Tasty(TestTree)
import Test.Tasty.HUnit (assert)
-- import Test.Tasty.Hspec (Spec, describe, it, shouldBe)
import Test.Tasty.QuickCheck (Arbitrary, arbitrary, NonNegative(getNonNegative), Gen)
-- import Test.QuickCheck.Monadic (monadicIO)
import System.IO.Unsafe (unsafePerformIO)

instance Arbitrary Account where
  arbitrary :: Gen Account
  arbitrary = do
    name <- arbitrary
    amount <- arbitrary :: Gen (NonNegative Int)
    return $ unsafePerformIO $ makeAccount name (getNonNegative amount)

instance Show Account where
  show acc = "Account {Name:" ++ (applicant acc) ++ ", Balance:" ++ show (unsafePerformIO $ getBalance acc) ++ "}"

prop_withdrawl_should_reduce_only_by_withdrawl_amount :: Account -> Int -> IO ()
prop_withdrawl_should_reduce_only_by_withdrawl_amount account withdrawlAmount = do
  oldBalance <- getBalance account
  atomically $ withdraw account withdrawlAmount
  newBalance <- getBalance account
  assert $ (oldBalance - withdrawlAmount) == newBalance

prop_deposit_should_increase_only_by_deposited_amount :: Account -> Int -> IO ()
prop_deposit_should_increase_only_by_deposited_amount account depositAmount = do
  oldBalance <- getBalance account
  atomically $ deposit account depositAmount
  newBalance <- getBalance account
  assert $ (oldBalance + depositAmount) == newBalance

prop_transfer_should_retain_the_total_value_before_and_after_transfer :: Account -> Account -> Int -> IO ()
prop_transfer_should_retain_the_total_value_before_and_after_transfer fromAcc toAcc  amount = do
  oldFromBalance <- getBalance fromAcc
  oldToBalance <- getBalance toAcc
  transfer fromAcc toAcc amount
  newFromBalance <- getBalance fromAcc
  newToBalance <- getBalance toAcc
  assert $ (oldFromBalance + oldToBalance) == (newFromBalance + newToBalance)

