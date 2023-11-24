use std::fs;

fn main() {
    let data_as_string: String = read_file(String::from("input/input.txt"));
    let mut floor: i16 = 0;
    let mut result = -1;
    for (i,char) in data_as_string.chars().enumerate(){
        if floor == -1 && result == -1{
            result = i as i16;
        }
        if char == '('{
            floor += 1;
        }
        else{
            floor -= 1;
        }
    }
    println!("{}", result);
}

fn read_file(filepath: String) -> String{
    return fs::read_to_string(filepath).expect("Unable to read file");
}