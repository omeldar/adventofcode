module Main (main) where

import Test.HUnit
import DayTestTest
import Day1Test
import Day2Test
import Day3Test

allTests :: Test
allTests = TestList [
    TestLabel "DayTestTest" DayTestTest.tests,
    TestLabel "Day1Test" Day1Test.tests,
    TestLabel "Day2Test" Day2Test.tests,
    TestLabel "Day3Test" Day3Test.tests
    ]

main :: IO ()
main = do
    counts <- runTestTT allTests
    print counts
