# Haskell solutions

Its my first time using haskell (but a tutorial I did). So it was kind of hart wrapping my mind about the declarative style of programming since I've never done it before. My solutions aren't the best ones but I tried ...

## Day 01

_Not completed yet, I made day 01 in c#_

Its about reading the first and last number out of a line. "a2bwd3dw4" would be 24.

Part 1: Sum up all values over all lines.

Part 2: Doing the same with numbers written as text ("2sixseven" would be 27)

Test Input:

```
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
```

## Day 02

Its about playing a game where an elf shows you cubes of a color. The game is only valid if there is not more than 12 red cubes, 13 green cubes and 14 blue cubes.

Part 1: Sum up all IDs of games, that are valid

Part 2: For each game, get the maximumm of cubes of one color shown at once. That determines how many cubes of that color at least were in the bag. Then we need to calculate the product of each colors maximum cubes in the bag for that game, and add up all the values from all games.

```
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
```

## Day 03

In this challenge, one needs to find the values (numbers), that are adjacent (horizontally, vertically or diagonally) to a symbol (but the symbol ".").

Part 1: Sum of all that numbers.

Part 2: Only find the values located next to the symbol `*`, where there is only one other value adjacent to it. In other words: Find all the places where there's a `*` with 2 numbers adjacent to it. Get the product of those two numbers, then sum all of these products.

```
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
```

## Day 04

Analyze scratching cards.

Part 1: Sum of the values of all scratchcards. A scratchcard with one matching number, is worth one. For each other matching number, the value duplicates.

Part 2: Instead of the scratchcard having a value, the matching numbers determine the scratchcards you get 1 more of. Each of that copies of the scratchcards, generate more copies of following scratchcards. The result is the sum of all scratchcards.

```
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
```

## Day 05

Mapping values to other values in ranges.

Part 1: You have some values, representing seeds at the top. And you have ranges described below `[FROM A] [FROM B] [FOR RANGE]`
and you have to map a seed that fits into one of the given ranges to another value. If your seed is 10 above `FROM A`, your target value is `FROM B` + 10. You'll have to do this for all levels (map them multiple times) for all seeds, then return the lowest target location for a seed found.

Part 2: The numbers representing seeds in part 1 now are ranges too. And you'll need to find the lowest target value for those seed ranges.

```
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
```

## Day 06

The input represents a number of races and for each race you see the total race time and the distance the current record in distance achieved in that race. The race works like this: For each millisecond you hold the button when the race starts, the boat gains 1mm/ms speed for the remaining time in the race.

Part 1: Find out how many different hold times beat the record for each race. The sum of all of them is the result.

Part 2: Now, its only one race. Concat all the numbers for time and distance to two single numbers and calculate all the different
possibilites for that race.

```
Time:      7  15   30
Distance:  9  40  200
```

## Day 07

The input represents hands in a card game similar to poker. Card values range from 2 to 14. Each hand has a bid value assigned.

Part 1: Rank all the hands depending on their value (first by type then by highest card), then multiply each hands rank with its bid value, and the sum of it is the total winnings result.

Part 2: The J now is a Joker, which could be any card. It will always however, be the card that adds most value to the hand. For this rules again: Calculate all the total winnings for the hands.

```
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
```

## Day 08

You have some instruction at the top of the input (Left and Right). Thats the value you need to take in the network map you're provided in the input.

Part 1: You start at AAA and you want to find out, how many steps it'll need until you reach ZZZ.

Part 2: You start at all points ending with A: **A and you want to find out, how much steps it needs until all those starting points can simultaniously be mapped to a value ending with Z: **Z.

```
Test inp for Part 1:        Test Inp for Part 2:
RL                          LR

AAA = (BBB, CCC)            11A = (11B, XXX)
BBB = (DDD, EEE)            11B = (XXX, 11Z)
CCC = (ZZZ, GGG)            11Z = (11B, XXX)
DDD = (DDD, DDD)            22A = (22B, XXX)
EEE = (EEE, EEE)            22B = (22C, 22C)
GGG = (GGG, GGG)            22C = (22Z, 22Z)
ZZZ = (ZZZ, ZZZ)            22Z = (22B, 22B)
                            XXX = (XXX, XXX)
```
