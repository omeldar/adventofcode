use std::fs;

// only 2 in test should pass
fn main() {
    let data_as_string = read_file(String::from("input/input.txt"));
    let result: usize = data_as_string
        .lines()
        .map(|string| is_nice(String::from(string)))
        .filter(|b| b == &true)
        .collect::<Vec<bool>>()
        .len();

    println!("{:?}", result);
}

fn is_nice(string: String) -> bool {
    let char_vec: Vec<char> = string.chars().collect::<Vec<char>>();

    // check if has any pair repeating without overlapping
    let mut has_double_pair: bool = false;
    for char_index in 1..char_vec.len(){
        let pair: String = String::from(char_vec[char_index-1]) + &String::from(char_vec[char_index]);
        let string_without_pair = get_string_without_chars_between_positions(string.clone(), char_index-1 , char_index);
        
        if string_without_pair.0.contains(&pair) || string_without_pair.1.contains(&pair){
            has_double_pair = true;
        }
    }

    // check if has any char repeating with exactly one letter between them
    let mut has_repeating_seperated_letter = false;
    for char_index in 2..char_vec.len(){
        if char_vec[char_index] == char_vec[char_index - 2]{
            has_repeating_seperated_letter = true;
        }
    }

    println!("string: {}, dp: {}, rsl: {}", string, has_double_pair, has_repeating_seperated_letter);

    if has_double_pair && has_repeating_seperated_letter{
        return true;
    }
    return false;
}

fn get_string_without_chars_between_positions(string: String, pos1: usize, pos2: usize) -> (String, String){
    let mut string1 = String::new();
    let mut string2 = String::new();
    for (i,char) in string.chars().enumerate(){
        if i < pos1{
            string1.push(char);
        }
        if i > pos2{
            string2.push(char);
        }
    }
    return (string1, string2);
}

fn read_file(filepath: String) -> String{
    return fs::read_to_string(filepath).expect("Unable to read file");
}