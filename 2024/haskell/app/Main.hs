module Main where
import DayTest as DT

main :: IO ()
main = do
  putStrLn "Hello, Haskell!"
  DT.run 2 5
