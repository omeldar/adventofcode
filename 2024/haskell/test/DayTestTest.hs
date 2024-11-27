{-# LANGUAGE ScopedTypeVariables #-}

module DayTestTest where

import Control.Exception
import Test.HUnit
import qualified DayTest (addTest)

tests :: Test
tests = TestList [
    TestLabel "testDayTest" testDayTest
    ]

testDayTest :: Test
testDayTest = TestCase $ do
    assertEqual "Test day test" 10 (DayTest.addTest 8 2)