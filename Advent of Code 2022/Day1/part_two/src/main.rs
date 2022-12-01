use std::fs;

fn main() {
    let filepath: String = String::from("input/input.txt");
    let string_data: String = read_file(filepath);
    let string_vector: Vec<&str> = string_data.lines().collect::<Vec<&str>>();
    let mut number_vector: Vec<u32> = Vec::new();

    // Calculate sum of each elf and push sum into number vector to sort it later
    let mut local_sum:u32 = u32::MIN;
    for i in 0..(string_vector.len()-1) {
        if string_vector[i] != "" && i != string_vector.len() -1 {
            local_sum += string_vector[i].parse::<u32>().unwrap();
        }
        else{
            number_vector.push(local_sum);
            local_sum = 0;
        }
    }
    number_vector.sort();

    let number_vector: Vec<u32> = number_vector[number_vector.len() - 3..].to_vec();
    let sum:u32 = number_vector.iter().sum();
    println!("Sum of the top 3: {}", sum);
}

fn read_file(filepath: String) -> String {
    return fs::read_to_string(filepath).expect("Unable to read file");
}