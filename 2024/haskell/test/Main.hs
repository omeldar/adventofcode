module Main (main) where

import Test.HUnit
import DayTestTest

allTests :: Test
allTests = TestList [
    TestLabel "DayTestTest" DayTestTest.tests
    ]

main :: IO ()
main = do
    counts <- runTestTT allTests
    print counts
