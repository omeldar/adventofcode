use std::fs;

fn main() {
    let data_as_string = read_file(String::from("input/input.txt"));
    let char_vec: Vec<char> = data_as_string.chars().collect::<Vec<char>>();

    for i in 13..char_vec.len(){
        if !has_dup(&char_vec[i-13..=i]){
            println!("i: {}", i + 1);
            break;
        }
    }
}

fn has_dup<T: PartialEq>(slice: &[T]) -> bool {
    for i in 1..slice.len() {
        if slice[i..].contains(&slice[i - 1]) {
            return true;
        }
    }
    false
}

fn read_file(filepath: String) -> String {
    return fs::read_to_string(filepath).expect("Unable to read file");
}
