{-# LANGUAGE ScopedTypeVariables #-}
module IORefTest where

import Lib (incRef)
import Data.IORef (newIORef, readIORef)
-- import Test.Tasty(TestTree)
import Test.Tasty.HUnit ((@?=), Assertion, assert)
-- import Test.Tasty.Hspec (Spec, describe, it, shouldBe)
-- import Test.Tasty.QuickCheck(testProperty)

-- HUnit test case
unit_ioref_increment_by_one :: Assertion
unit_ioref_increment_by_one = do
  var <- newIORef 1
  incRef var
  val <- readIORef var
  val @?= (2 :: Int)

-- Hspec specification
-- spec_two_minus_one_equal_to_one :: Spec
-- spec_two_minus_one_equal_to_one = do
--   describe "Prelude.head" $ do
--     it "returns the first element of a list" $ do
--       head [23 ..] `shouldBe` (23 :: Int)

-- QuickCheck property
prop_incrementOnlyByOne :: Int -> IO ()
prop_incrementOnlyByOne a = do
  var <- newIORef a
  incRef var
  val <- readIORef var
  --val @?= ((a+1) :: Int)
  assert (val == (a+1))
