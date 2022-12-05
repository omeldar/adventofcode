use std::fs;

fn main() {
    let data_as_string: String = read_file(String::from("input/input.txt"));
    let mut floor: i16 = 0;
    for char in data_as_string.chars(){
        if char == '('{
            floor += 1;
        }
        else{
            floor -= 1;
        }
    }
    println!("{}", floor);
}

fn read_file(filepath: String) -> String{
    return fs::read_to_string(filepath).expect("Unable to read file");
}