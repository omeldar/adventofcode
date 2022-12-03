use std::fs;

fn main() {
    const GROUP_SIZE: usize = 3;

    let string_data: String = read_file(String::from("input/input.txt"));
    let string_vector: Vec<&str> = string_data.lines().collect::<Vec<&str>>();
    let grouped_rucksacks_vector: Vec<Vec<&str>> = sort_input_into_groups(string_vector, GROUP_SIZE);
    // The chars that appear in all 3 rucksacks per group
    let mut badges: Vec<char> = Vec::new();

    for group_index in 0..grouped_rucksacks_vector.len(){
        let mut chars_in_group: Vec<char> = 
            group_chars_in_vector(get_chars_of_rucksacks_in_group(grouped_rucksacks_vector[group_index].clone()));

        let group: Vec<&str> = grouped_rucksacks_vector[group_index].clone();

        for char_index in 0..chars_in_group.len(){
            let mut exists_in_all = true;
            for rucksack_index in 0..group.len(){
                if !group[rucksack_index].contains(chars_in_group[char_index]){
                    exists_in_all = false;  // char does not exist in current rucksack
                }
            }

            if exists_in_all{
                // push char into badges
                badges.push(chars_in_group[char_index]);
            }
        }
    }

    let mut priority_sum: u32 = 0;
    for badge_index in 0..badges.len(){
        let char_as_digit = badges[badge_index] as u32;
        if char_as_digit > 96 {
            priority_sum += char_as_digit -96;
        }
        else{
            priority_sum += (char_as_digit - 64) + 26;
        }
    }

    println!("result: {}", priority_sum);

}

// group chars in vector
fn group_chars_in_vector(chars: Vec<char>) -> Vec<char>{
    let mut char_vec: Vec<char> = Vec::new();

    for char_index in 0..chars.len(){
        if !char_vec.contains(&chars[char_index]){
             char_vec.push(chars[char_index]);
        }
    }

    return char_vec;
}

// get all chars of the groups rucksacks
fn get_chars_of_rucksacks_in_group(group_rucksacks: Vec<&str>) -> Vec<char>{
    let mut chars_in_group: Vec<char> = Vec::new();
    for rucksack_index in 0..group_rucksacks.len(){
        // get all chars of a rucksack and put them in a list
        let chars_in_rucksack: Vec<char> = group_rucksacks[rucksack_index].chars().collect::<Vec<char>>();
        for char_index in 0..chars_in_rucksack.len(){
            chars_in_group.push(chars_in_rucksack[char_index]);
        }
    }
    return chars_in_group;
}

// sort input into groups of GROUP_SIZE rucksacks each
fn sort_input_into_groups(string_vector: Vec<&str>, group_size: usize) -> Vec<Vec<&str>> {
    let mut grouped_rucksacks_vector: Vec<Vec<&str>> = Vec::new();
    let mut curr_vector: Vec<&str> = Vec::new();
    for line_index in 0..string_vector.len(){
        curr_vector.push(string_vector[line_index]);
        // After group items have been assigned push group into group vector
        if line_index % group_size == group_size -1{
            grouped_rucksacks_vector.push(curr_vector);
            curr_vector = Vec::new();
        }
    }
    return grouped_rucksacks_vector;
}

// read file and return string
fn read_file(filepath: String) -> String {
    return fs::read_to_string(filepath).expect("Unable to read file");
}