module Day4Test where

import Control.Exception
import Test.HUnit
import qualified Day4 (part1, part2, parse)

tests :: Test
tests = TestList [
    TestLabel "day4p1Test" testDay4Part1Test,
    TestLabel "day4p2Test" testDay4Part2Test
    ]

testDataP1 :: String
testDataP1 = unlines [
    "MMMSXXMASM",
    "MSAMXMSMSA",
    "AMXSXMAAMM",
    "MSAMASMSMX",
    "XMASAMXAMM",
    "XXAMMXXAMA",
    "SMSMSASXSS",
    "SAXAMASAAA",
    "MAMMMXMMMM",
    "MXMXAXMASX"
    ]

testDataP2 :: String
testDataP2 = unlines [
    ".M.S......",
    "..A..MSMS.",
    ".M.S.MAA..",
    "..A.ASMSM.",
    ".M.S.M....",
    "..........",
    "S.S.S.S.S.",
    ".A.A.A.A..",
    "M.M.M.M.M.",
    ".........."
    ]

testDay4Part1Test :: Test
testDay4Part1Test = TestCase $ do
    assertEqual "Day 4, Part 1 Test" 18 (Day4.part1 $ Day4.parse testDataP1)

testDay4Part2Test :: Test
testDay4Part2Test = TestCase $ do
    assertEqual "Day 4, Part 2 Test" 9 (Day4.part2 $ Day4.parse testDataP2)