module Main (main) where

import Test.HUnit
import DayTestTest
import Day1Test

allTests :: Test
allTests = TestList [
    TestLabel "DayTestTest" DayTestTest.tests,
    TestLabel "Day1Test" Day1Test.tests
    ]

main :: IO ()
main = do
    counts <- runTestTT allTests
    print counts
