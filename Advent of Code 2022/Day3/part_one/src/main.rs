use std::fs;

fn main() {
    let string_data: String = read_file(String::from("input/input.txt"));
    let string_vector: Vec<&str> = string_data.lines().collect::<Vec<&str>>();
    let mut characters_that_appear_in_both_compartements: Vec<char> = Vec::new();

    for i in 0..string_vector.len(){
        let mut current_same_char_vector: Vec<char> = Vec::new();
        let (first, second): (&str, &str) = string_vector[i].split_at(string_vector[i].len()/2);
        let first_chararray = first.chars().collect::<Vec<char>>();
        let second_chararray = second.chars().collect::<Vec<char>>();
        for first_char_index in 0..first_chararray.len(){
            for second_char_index in 0..second_chararray.len(){
                if first_chararray[first_char_index] == second_chararray[second_char_index]{
                    let mut char_exists_in_curr_context: bool = false;
                    for currchar_index in 0..current_same_char_vector.len(){
                        if current_same_char_vector[currchar_index] == first_chararray[first_char_index]{
                            char_exists_in_curr_context = true;
                        }
                    }
                    if char_exists_in_curr_context == false{
                        current_same_char_vector.push(first_chararray[first_char_index]);
                    }
                    
                }
            }
        }

        for currchar_index in 0..current_same_char_vector.len(){
            characters_that_appear_in_both_compartements.push(current_same_char_vector[currchar_index]);
        }

    }

    let mut priority_sum: u32 = 0;
    for i in 0..characters_that_appear_in_both_compartements.len(){
        let char_as_digit = characters_that_appear_in_both_compartements[i] as u32;
        if char_as_digit > 96 {
            priority_sum += char_as_digit - 96;
            println!("char: {}\nascii: {}\npriority: {}\ncurrent_sum: {}\n", 
                characters_that_appear_in_both_compartements[i], char_as_digit, char_as_digit - 96, priority_sum);
        }
        else{
            priority_sum += (char_as_digit - 64) + 26;
            println!("char: {}\nascii: {}\npriority: {}\ncurrent_sum: {}\n", 
                characters_that_appear_in_both_compartements[i], char_as_digit, (char_as_digit - 64) + 26, priority_sum);
        }
    }

    println!("result: {}", priority_sum);
}

fn read_file(filepath: String) -> String {
    return fs::read_to_string(filepath).expect("Unable to read file");
}