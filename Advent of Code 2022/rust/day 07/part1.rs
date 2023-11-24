use std::fs;
use std::collections::HashMap;
use std::path::PathBuf;
use std::time::Instant;

fn main() {
    let now = Instant::now();   // Starting stopwatch
    let data_as_string = read_file(String::from("input/input.txt"));
    let mut current_path = PathBuf::new();
    let mut directories: HashMap<PathBuf, u64> = HashMap::new();

    for line in data_as_string.lines(){
        if line.starts_with("$"){
            if line.split_whitespace_vec()[1] == "cd" {
                if line.split_whitespace_vec()[2] != ".."{
                    current_path.push(line.split_whitespace_vec()[2]);
                }
                else{
                    current_path.pop();
                }
            }
        } else {
            if let Ok(parse_result) = line.split_whitespace_vec()[0].parse::<u64>(){
                directories.entry(current_path.clone()).and_modify(|size| *size += parse_result).or_insert(parse_result);

                // add parseresult on all parent directories sizes
                let path: Vec<std::path::Component> = current_path.components().collect();
                for i in 0..path.len() {
                    let mut parentpath: PathBuf = PathBuf::new();
                    for a in 0..i{
                        parentpath.push(path[a]);
                    }
                    directories.entry(parentpath.clone()).and_modify(|size| *size += parse_result).or_insert(parse_result);
                }
            }
        }
    }

    let result: u64 = directories.iter()
        .map(|dir| if dir.1 <= &100000 {dir.1} else { &0 })
        .sum();

    // Stopping stopwatch
    let elapsed_ms = (now.elapsed().as_micros() as f64) / 1_000.0;

    println!("elapsed: {} ms", elapsed_ms);
    println!("result: {}", result);
}

// Extending &str to be able to split on white space and directly return a String Vector
trait SplitWhitespaceAsVec {
    fn split_whitespace_vec(&self) -> Vec<&str>;
}

impl SplitWhitespaceAsVec for &str{
    fn split_whitespace_vec(&self) -> Vec<&str>{
        return self.split_whitespace().collect();
    }
}

fn read_file(filepath: String) -> String {
    return fs::read_to_string(filepath).expect("Unable to read file");
}