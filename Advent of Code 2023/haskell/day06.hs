type Race = (Int, Int)

main = do
    let time = [53,89,76,98]
        distance = [313,1090,1214,1201]
        ttime = [7,15,30]
        tdistance = [9,40,200]
        races = zip time distance
        traces = zip ttime tdistance
        oneRace = (53897698, 313109012141201)
    print $ product $ map (\race -> calculateSolutions race) traces

-- formula described in readme, not working yet
calculateSolutions :: Race -> Int
calculateSolutions race = (x1 - x2) `div` (2 * (-1))
    where
        t = fst race
        r = snd race
        x1 = ceiling $ fromIntegral (-t) + sqrt (fromIntegral delta)
        x2 = floor $ fromIntegral (-t) - sqrt (fromIntegral delta)
        delta :: Int
        delta = fromIntegral (t^2+4*r)