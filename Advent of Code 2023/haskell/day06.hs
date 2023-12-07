main = do
    let races = zip [53,89,76,98] [313,1090,1214,1201]
        race = (53897698, 313109012141201)
    print $ product $ map (\r -> countWays r) races
    print $ countWays race

countWays :: (Int, Int) -> Int
countWays (t, d) = floor x1 - ceiling x2 + 1
    where
        a = fromIntegral 1
        b = fromIntegral (-t)
        c = fromIntegral (d + 1)
        x1 = (-b + sqrt (b^2 - 4 * a * c)) / (2 * a)
        x2 = (-b - sqrt (b^2 - 4 * a * c)) / (2 * a)