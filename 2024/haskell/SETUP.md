# Advent of Code - Haskell Setup

This project is a setup for solving Advent of Code puzzles using Haskell. The structure makes it easy to add new puzzle implementations, run them with minimal effort, and keep everything organized in a modular way.

## Project Structure

```
project-root/
├── app/
│   └── Main.hs            # Entry point to run the solutions
├── lib/
│   └── DayTest.hs         # Implementation of specific puzzle solutions
├── test/
│   ├── DayTestTest.hs     # Tests for the puzzle implementations
│   └── Main.hs            # Entry point for running tests
├── input.txt              # Input file for all puzzle solutions
├── aoc2024.cabal          # Cabal configuration file
└── .gitignore             # Git ignore file
```

### Key Directories and Files

- **`app/Main.hs`**: This is the entry point for the project. It handles command-line arguments and runs the corresponding puzzle solution based on the input.
- **`lib/DayTest.hs`**: Contains the implementation of a specific puzzle solution, for example, a simple function to test (`run`). Each puzzle day can be added in this folder as a new module.
- **`test/DayTestTest.hs`**: Contains the tests for the puzzle implementations, ensuring correctness.
- **`input.txt`**: A shared input file for all the puzzles. This file will not be pushed to version control.
- **`aoc2024.cabal`**: The Cabal configuration file that defines the project, including dependencies and executable settings.

## How to Run the Project

### Running a Solution
To run a specific solution, use the following command:
```bash
cabal run day test
```
This will execute the implementation specified in `Main.hs` based on the argument provided.

For example:
- `cabal run day test` will run the `test` implementation found in `lib/DayTest.hs`.
- You can extend the setup to add more days and run them similarly, e.g., `cabal run day 1`, `cabal run day 2`, etc.

### Adding a New Puzzle Solution
1. **Create a New Module**: Add a new `.hs` file in the `lib/` directory, for example, `Day01.hs`.
2. **Implement the Solution**: Define the function to solve the puzzle in the new module.
3. **Add to Main**: Import the new module in `app/Main.hs` and add a case to `runDay` to call the new solution.

### Example Usage
The `runDay` function in `Main.hs` determines which solution to run based on the command-line argument.
```haskell
runDay :: String -> IO ()
runDay "test" = do
    runWithInput DT.run
runDay day = putStrLn $ "Unknown day: " ++ day
```
This allows for easy extension to handle more days by simply adding more pattern matches.

### Input Handling
All puzzle solutions are expected to use the same input file, `input.txt`. The helper function `runWithInput` automatically provides this file to any function that needs it, simplifying the process of reading inputs.

```haskell
runWithInput :: (String -> IO a) -> IO a
runWithInput f = f inputPath
```
The `inputPath` variable is set to `"input.txt"`, which means the solutions will always use this file for their inputs.

## Running Tests
The tests are located in the `test/` directory. To run the tests, use:
```bash
cabal run test
```
This will execute all the test suites, ensuring that your implementations work correctly.

## Extending the Project
- **Add More Days**: Create a new module for each day's solution, and add a new case in `runDay` to call it.
- **Test Each Day**: Add corresponding tests in the `test/` directory to ensure correctness.

## Summary
This setup is designed to be **modular**, **extensible**, and **easy to use** for solving Advent of Code puzzles in Haskell. By centralizing input handling and providing a clear project structure, it helps you focus on solving puzzles without worrying about boilerplate code for input and execution management.
