module Day3Test where

import Control.Exception
import Test.HUnit
import qualified Day3 (part1, part2)

tests :: Test
tests = TestList [
    TestLabel "day3p1Test" testDay3Part1Test,
    TestLabel "day3p2Test" testDay3Part2Test
    ]

testDataP1 :: String
testDataP1 = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

testDataP2 :: String
testDataP2 = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

testDay3Part1Test :: Test
testDay3Part1Test = TestCase $ do
    assertEqual "Day 3, Part 1 Test" 161 (Day3.part1 testDataP1)

testDay3Part2Test :: Test
testDay3Part2Test = TestCase $ do
    assertEqual "Day 3, Part 2 Test" 48 (Day3.part2 testDataP2)