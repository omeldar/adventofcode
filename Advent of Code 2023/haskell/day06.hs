import Debug.Trace (trace)

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
calculateSolutions race = trace (show delta) x1 - x2
    where
        t = fromIntegral $ fst race
        r = fromIntegral $ snd race
        x1 = ceiling $ ((-t) + sqrt (delta) / (-2.0))
        x2 = floor $ ((-t) - sqrt (delta) / (-2.0))
        delta :: Double
        delta = (t^2-4*r)