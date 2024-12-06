module Main where

import System.Environment (getArgs)
import qualified DayTest as DT (run)
import qualified Day1 as D1 (run)
import qualified Day2 as D2 (run)
import qualified Day3 as D3 (run)
import qualified Day4 as D4 (run)
import qualified Day5 as D5 (run)
import qualified Day6 as D6 (run)

inputPath :: String
inputPath = "input.txt"

main :: IO ()
main = do
  args <- getArgs
  case args of
    [day]  -> runDay day
    []     -> putStrLn "Please provide a day."
    _      -> putStrLn "Invalid number of arguments. Provide exactly one day."

runDay :: String -> IO ()
-- cabal run day test
runDay "test" = do
    runWithInput DT.run

runDay "1" = do
    runWithInput D1.run

runDay "2" = do
    runWithInput D2.run

runDay "3" = do
    runWithInput D3.run

runDay "4" = do
    runWithInput D4.run

runDay "5" = do
    runWithInput D5.run

runDay "6" = do
    runWithInput D6.run

-- catch the rest
runDay day = putStrLn $ "Unknown day: " ++ day

runWithInput :: (String -> IO a) -> IO a
runWithInput f = f inputPath
