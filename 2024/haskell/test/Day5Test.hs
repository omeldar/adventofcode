module Day5Test where

import Control.Exception
import Test.HUnit
import qualified Day5 (part1, part2, parse)

tests :: Test
tests = TestList [
    TestLabel "day5p1Test" testDay5Part1Test,
    TestLabel "day5p2Test" testDay5Part2Test
    ]

testData :: String
testData = unlines
    [ "47|53"
    , "97|13"
    , "97|61"
    , "97|47"
    , "75|29"
    , "61|13"
    , "75|53"
    , "29|13"
    , "97|29"
    , "53|29"
    , "61|53"
    , "97|53"
    , "61|29"
    , "47|13"
    , "75|47"
    , "97|75"
    , "47|61"
    , "75|61"
    , "47|29"
    , "75|13"
    , "53|13"
    , ""
    , "75,47,61,53,29"
    , "97,61,53,29,13"
    , "75,29,13"
    , "75,97,47,61,53"
    , "61,13,29"
    , "97,13,75,29,47"
    ]

testDay5Part1Test :: Test
testDay5Part1Test = TestCase $ do
    assertEqual "Day 5, Part 1 Test" 143 (Day5.part1 (fst $ Day5.parse testData) (snd $ Day5.parse testData))

testDay5Part2Test :: Test
testDay5Part2Test = TestCase $ do
    assertEqual "Day 5, Part 2 Test" 123 (Day5.part2 (fst $ Day5.parse testData) (snd $ Day5.parse testData))