module Day9 (run) where

import Data.Maybe

run :: String -> IO ()
run filePath = do
    content <- lines <$> readFile filePath
    let memAlloc = parse content
    print $ checksum $ compress memAlloc
    print $ checksum $ compress2 memAlloc

compress :: [(Int, Maybe Int)] -> [(Int, Maybe Int)]
compress = process []
  where
    process acc [] = reverse acc
    process acc xs
        | null xs = acc
        | isNothing (snd (last xs)) = process acc (init xs)
        | isJust (snd (head xs)) = process (head xs : acc) (tail xs)
        | otherwise = handleMiddle (head xs) (init (tail xs)) (last xs)
        where
            handleMiddle (n, Nothing) ys (m, Just z)
                | n == m = process ((m, Just z) : acc) ys
                | n > m = process ((m, Just z) : acc) ((n - m, Nothing) : ys)
                | otherwise = process ((n, Just z) : acc) (ys ++ [(m - n, Just z)])

compress2 :: [(Int, Maybe Int)] -> [(Int, Maybe Int)]
compress2 xs = processItems xs (reverse xs)
    where
        processItems xs [] = xs
        processItems xs (current : rest)
            | isJust (snd current) = processItems (updateList [] xs) rest
            | otherwise = processItems xs rest
            where
                updateList acc (item : remaining)
                    | snd item == snd current = xs
                    | isJust (snd item) = updateList (item : acc) remaining
                    | fst item < fst current = updateList (item : acc) remaining
                    | fst item == fst current = (reverse acc) ++ [current] ++ map adjustItem remaining
                    | fst item > fst current = (reverse acc) ++ [current, (fst item - fst current, Nothing)] ++ map adjustItem remaining

                adjustItem item
                    | item == current = (fst current, Nothing)
                    | otherwise = item

checksum :: [(Int, Maybe Int)] -> Int
checksum = calc 0 0
    where
        calc _ acc [] = acc
        calc pos acc ((n, Nothing) : xs) = calc (pos + n) acc xs
        calc pos acc ((n, Just x) : xs) = calc (pos + n) (acc + delta) xs
            where delta = sum [x * i | i <- [pos .. pos + n - 1]]

parse :: [String] -> [(Int, Maybe Int)]
parse [x] = reverse $ processStr [] 0 x
    where
        processStr acc i (a : b : cs) = processStr ((read [b], Nothing) : (read [a], Just i) : acc) (i + 1) cs
        processStr acc i (a : []) = (read [a], Just i) : acc