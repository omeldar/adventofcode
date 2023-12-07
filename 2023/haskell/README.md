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
