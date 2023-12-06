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

-- WILL BE IMRPOVED USING THE QUADRATIC FORMULA:

-- Calculate the number of ways to break the record in a race:
-- Number of Ways = min(max(0, RaceDuration - 5), RecordDistance + 1)
-- Explanation:

-- RaceDuration: Duration of the race in milliseconds.
-- RecordDistance: Current record distance in millimeters.
-- max(0, RaceDuration - 5): Ensures the button press time isn't greater than the race duration. After 5 milliseconds, the maximum speed of 5 mm/ms is reached.
-- RecordDistance + 1: Represents how many different times could exist that would break the current record. Any time greater than or equal to the current record time can break the record.