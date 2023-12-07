use std::fs;

// nice string if:
// at least 1 letter twice in a row aa, bb, cc, gg, yy, zz
// at least 3 vowels
// does not contain "ab", "cd", "pq", "xy"

// test case (./input/test.txt): 2 out of 8 are nice, so the answer is: 2

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
    let must_not_contain: Vec<&str> = ["ab", "cd", "pq", "xy"].to_vec();
    let vowels: Vec<char> = ['a', 'e', 'i', 'o', 'u'].to_vec();

    
    // check for at least 3 vowels
    let mut vowel_count: u8 = 0;
    for char in string.chars(){
        if vowels.contains(&char) {
            vowel_count += 1;
        }
    }

    // check for unallowed character combinations
    let mut no_unallowed_combinations: bool = true;
    for char_index in 1..string.chars().count(){
        let mut char_combo: String = String::new();
        char_combo.push(string.chars().collect::<Vec<char>>()[char_index -1]);
        char_combo.push(string.chars().collect::<Vec<char>>()[char_index]);

        if must_not_contain.contains(&&char_combo[..]){
            no_unallowed_combinations = false;
        }
    }

    // check for letters appearing twice in a row
    let mut appears_twice_in_a_row: bool = false;
    for char_index in 1..string.chars().count(){
        let first_char: char  = string.chars().collect::<Vec<char>>()[char_index];
        let second_char: char =  string.chars().collect::<Vec<char>>()[char_index -1];

        if first_char == second_char{
            appears_twice_in_a_row = true;
        }
    }

    if vowel_count >= 3 && no_unallowed_combinations && appears_twice_in_a_row {
        return true;
    }
    return false;
}

fn read_file(filepath: String) -> String{
    return fs::read_to_string(filepath).expect("Unable to read file");
}