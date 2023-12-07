use std::collections::HashMap;
use std::fs;

const GRID_SIZE: usize = 1000;

// This function takes a string like "0,0" and returns a tuple of two usize values
fn parse_coordinate(s: &str) -> (usize, usize) {
    let coords: Vec<&str> = s.split(',').collect();
    let x = coords[0].parse().unwrap();
    let y = coords[1].parse().unwrap();
    (x, y)
}

// This function takes a string like "turn on 0,0 through 999,999" and returns a
// tuple of the action (0 for decrease, 1 for increase, 2 for toggle), and the
// coordinates of the two corners of the rectangle
fn parse_instruction(s: &str) -> (usize, (usize, usize), (usize, usize)) {
    let parts: Vec<&str> = s.split(' ').collect();
    let action = match parts[0] {
        "turn" => {
            if parts[1] == "off" {
                0
            } else if parts[1] == "on" {
                1
            } else {
                panic!("Invalid action");
            }
        }
        "toggle" => 2,
        _ => panic!("Invalid action"),
    };
    let coords1: (usize, usize);
    let coords2: (usize, usize);

    if parts[0] == "toggle"{
        coords1 = parse_coordinate(parts[1]);
        coords2 = parse_coordinate(parts[3]);
    }
    else{
        coords1 = parse_coordinate(parts[2]);
        coords2 = parse_coordinate(parts[4]);
    }
    (action, coords1, coords2)
}

// This function takes a vector of instructions and returns a HashMap representing
// the state of the grid after all the instructions have been applied
fn apply_instructions(instructions: Vec<&str>) -> HashMap<(usize, usize), u64> {
    let mut grid = HashMap::new();

    // Initialize all lights to 0 brightness
    for x in 0..GRID_SIZE {
        for y in 0..GRID_SIZE {
            grid.insert((x, y), 0);
        }
    }

    for instruction in instructions {
        let (action, coords1, coords2) = parse_instruction(instruction);
        for x in coords1.0..=coords2.0 {
            for y in coords1.1..=coords2.1 {
                let current_brightness = *grid.get(&(x, y)).unwrap();
                let new_brightness = match action {
                    0 => if current_brightness > 0 { current_brightness - 1 } else { 0 }, // decrease
                    1 => current_brightness + 1, // increase
                    2 => current_brightness + 2, // toggle
                    _ => panic!("Invalid action"),
                };
                grid.insert((x, y), new_brightness);
            }
        }
    }

    grid
}

fn total_brightness(grid: &HashMap<(usize, usize), u64>) -> u64 {
    let mut brightness = 0;
    for (_, value) in grid.iter() {
        brightness += *value;
    }
    brightness
}

fn main() {
    let instructions = read_file(String::from("input/input.txt"));
    let instructions = instructions.lines().collect::<Vec<&str>>();
    let grid = apply_instructions(instructions);

    //only lines i wrote
    let total_brightness = total_brightness(&grid);     
    println!("{}", total_brightness);
}

// from me
fn read_file(filepath: String) -> String{
    return fs::read_to_string(filepath).expect("Unable to read file");
}