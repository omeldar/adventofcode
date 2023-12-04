main = do
    input <- lines <$> readFile "test.txt"
    print $ input