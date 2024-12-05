# Zig

One may ask why I used zig here. Let me as you: Why not?

Yes, thats my only argument.

## How to run it

There are several ways to run the single days / challanges:

### Run by using the `run.sh`

You can use `run.sh` to run single days solutions. You can do this by first building the project with `zig build` and then run:

```
./run.sh <day>
```

For example for day01.zig, use: `./run.sh day01`.

This will directly run the compiled executable in `zig-out/bin/`.

### Run by using `zig run`

You can use `zig run` to compile the specified Zig source file into an executable. It executes the resulting binary. These build artifacts are not retained permanently, so they are **Temporary Build Artifacts**.

So from the root (of the zig project), you can use:

```
zig run src/<day>.zig
```

For example for day01.zig, use: `zig run src/day01.zig`.

## Structure

The structure is simple:

- `./src`: In here you can find the source files and solutions to the puzzles.
- `./zig-out/bin`: Here you'll find the executables after building with `zig build`.
- `input.txt`: It temporarily stores the Advent of Code puzzle input. My puzzle inputs are **not added** to version control to respect the creator's request for participants not to share them.