type Race = (Int, Int)

main = do
    let time = [53,89,76,98]
        distance = [313,1090,1214,1201]
        races = zip time distance
        oneRace = (53897698, 313109012141201)

    print $ product $ map (\race -> getSolutionAmtForRace race 0 0) races -- PART 1
    print $ getSolutionAmtForRace oneRace 0 0 -- PART 2

getSolutionAmtForRace :: Race -> Int -> Int -> Int
getSolutionAmtForRace race charge recN
    | bHold < (snd race) = getSolutionAmtForRace race (bHold + 1) (if beatsRecord then recN + 1 else recN)
    | otherwise = recN
    where 
        beatsRecord = (bHold * (fst race - bHold) > snd race)