use std::fs;
use itertools::Itertools;

fn main() {
    let data_as_string = read_file(String::from("input/input.txt"));
    let result:u32 = data_as_string
        .lines()
        .map(|line: &str| line.split("x").map(|s: &str| s.parse::<u32>().unwrap()).collect_tuple::<(_, _, _)>().unwrap())
        .map(|t: (u32,u32,u32)| calculate_ribbon_in_feet(t))
        .sum();
    println!("{}", result);
}

fn calculate_ribbon_in_feet((length, width, height): (u32, u32, u32)) -> u32{
    let mut sides = [length, width, height].to_vec();
    sides.sort();
    return (sides[0] * 2 + sides[1] * 2) + (sides[0] * sides[1] * sides[2]);
}

fn read_file(filepath: String) -> String{
    return fs::read_to_string(filepath).expect("Unable to read file");
}