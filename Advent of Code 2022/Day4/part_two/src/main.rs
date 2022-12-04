use std::fs;
use itertools::Itertools;

fn main() {
    let data_string = read_file(String::from("input/input.txt"));
    let result = data_string
        .lines()
        .map(|l: &str| l.split(","))
        .map(|a| a.map(|s: &str| s.split("-").map(|u: &str| u.parse::<u32>().unwrap()).collect_tuple::<(_, _)>().unwrap()).collect_tuple::<(_, _)>().unwrap())
        .filter(|t: &((u32, u32), (u32, u32))| (t.0.1 >= t.1.0 && t.0.0 <= t.1.1))
        .count();

    println!("result: {}", result);
}

fn read_file(filepath: String) -> String{
    return fs::read_to_string(filepath).expect("Unable to read file");
}