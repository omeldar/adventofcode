use std::fs;

fn main() {
    let data_as_string = read_file(String::from("input/test.txt"));
}

fn read_file(filepath: String) -> String{
    return fs::read_to_string(filepath).expect("Unable to read file");
}