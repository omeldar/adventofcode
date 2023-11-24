use std::fs;

fn main() {
    let data_as_string = read_file(String::from("input/input.txt"));
    let char_vec: Vec<char> = data_as_string.chars().collect::<Vec<char>>();

    for i in 3..char_vec.len(){
        if char_vec[i] != char_vec[i-1] && char_vec[i] != char_vec[i-3] && 
            char_vec[i] != char_vec[i-2] && char_vec[i-1] != char_vec[i-2] &&
            char_vec[i-1] != char_vec[i-3] && char_vec[i-3] != char_vec[i-2]{
                println!("first i: {}", i + 1);
                break;
        }
    }

}

fn read_file(filepath: String) -> String {
    return fs::read_to_string(filepath).expect("Unable to read file");
}
