{-# OPTIONS_GHC -Wno-unused-imports #-}
{-# LANGUAGE ScopedTypeVariables #-}
module BankingSystemTest where

import Control.Concurrent.STM (atomically)
import BankingSystem (makeAccount, transfer, withdraw, getBalance, deposit)
-- import Test.Tasty(TestTree)
import Test.Tasty.HUnit (assert)
-- import Test.Tasty.Hspec (Spec, describe, it, shouldBe)
-- import Test.Tasty.QuickCheck (testProperty, Arbitrary, arbitrary)
-- import Test.QuickCheck.Monadic (monadicIO)

{-
instance Arbitrary Account where
  arbitrary = monadicIO $ do
    name <- arbitrary
    amount <- arbitrary
    return $ makeAccount name amount
 -}

prop_withdrawl_should_reduce_only_by_withdrawl_amount :: Int -> Int -> IO ()
prop_withdrawl_should_reduce_only_by_withdrawl_amount accountBalance withdrawlAmount = do
  account <- makeAccount "From" accountBalance
  oldBalance <- getBalance account
  atomically $ withdraw account withdrawlAmount
  newBalance <- getBalance account
  assert $ (oldBalance - withdrawlAmount) == newBalance

prop_deposit_should_increase_only_by_deposited_amount :: Int -> Int -> IO ()
prop_deposit_should_increase_only_by_deposited_amount accountBalance depositAmount = do
  account <- makeAccount "From" accountBalance
  oldBalance <- getBalance account
  atomically $ deposit account depositAmount
  newBalance <- getBalance account
  assert $ (oldBalance + depositAmount) == newBalance

prop_zeroSumTransfer :: Int -> Int -> Int -> IO ()
prop_zeroSumTransfer fromAccountBalance toAccountBalance amount = do
  fromAcc <- makeAccount "From" fromAccountBalance
  toAcc <- makeAccount "To" toAccountBalance
  oldFromBalance <- getBalance fromAcc
  oldToBalance <- getBalance toAcc
  transfer fromAcc toAcc amount
  newFromBalance <- getBalance fromAcc
  newToBalance <- getBalance toAcc
  assert $ (oldFromBalance + oldToBalance) == (newFromBalance + newToBalance)

