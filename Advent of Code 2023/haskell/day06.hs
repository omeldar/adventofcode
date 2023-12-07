main = do
    let races = zip [53,89,76,98] [313,1090,1214,1201]
        oneRace = (53897698, 313109012141201)
    print $ product $ map (\race -> calculateSolutions race) races
    print $ calculateSolutions oneRace

calculateSolutions :: (Int, Int) -> Int
calculateSolutions (t, d) = floor x1 - ceiling x2 + 1
    where
        a = fromIntegral 1
        b = fromIntegral (-t)
        c = fromIntegral (d + 1)
        x1 = (-b + sqrt (b^2 - 4 * a * c)) / (2 * a)
        x2 = (-b - sqrt (b^2 - 4 * a * c)) / (2 * a)