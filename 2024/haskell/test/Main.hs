module Main (main) where

import Test.HUnit
import DayTestTest
import Day1Test
import Day2Test
import Day3Test
import Day4Test
import Day5Test
import Day6Test

allTests :: Test
allTests = TestList [
    TestLabel "DayTestTest" DayTestTest.tests,
    TestLabel "Day1Test" Day1Test.tests,
    TestLabel "Day2Test" Day2Test.tests,
    TestLabel "Day3Test" Day3Test.tests,
    TestLabel "Day4Test" Day4Test.tests,
    TestLabel "Day5Test" Day5Test.tests,
    TestLabel "Day6Test" Day6Test.tests
    ]

main :: IO ()
main = do
    counts <- runTestTT allTests
    print counts
