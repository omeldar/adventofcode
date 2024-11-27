module DayTest (
    run,
    addTest
) where

run :: Integer -> Integer -> IO()
run x y = print $ addTest x y

addTest :: Integer -> Integer -> Integer
addTest x y = x + y
