module DayTest (
    run,
    addTest
) where

-- This is an example for a day's puzzle implementation
run :: String -> IO()
run filePath = do
    contents <- readFile filePath
    putStrLn contents

-- This is an example for the test suite
addTest :: Integer -> Integer -> Integer
addTest x y = x + y
