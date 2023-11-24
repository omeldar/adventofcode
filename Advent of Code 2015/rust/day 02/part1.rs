use std::fs;
use itertools::Itertools;

fn main() {
    let data_as_string = read_file(String::from("input/input.txt"));
    let result:u32 = data_as_string
        .lines()
        .map(|line: &str| line.split("x").map(|s: &str| s.parse::<u32>().unwrap()).collect_tuple::<(_, _, _)>().unwrap())
        .map(|t: (u32,u32,u32)| calculate_paper_wrapping_in_feet(t))
        .sum();
    println!("{}", result);
}

fn calculate_paper_wrapping_in_feet((width, length, height): (u32, u32, u32)) -> u32{
    let mut sides: Vec<u32> = [width * length, width * height, height * length].to_vec();
    sides.sort();
    let mut wrapping_needed = 0;
    for side in 0..sides.len(){
        wrapping_needed += sides[side] * 2;
    }
    wrapping_needed += sides[0];
    return wrapping_needed;
}

fn read_file(filepath: String) -> String{
    return fs::read_to_string(filepath).expect("Unable to read file");
}
