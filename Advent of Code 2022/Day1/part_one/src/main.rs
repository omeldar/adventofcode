use std::fs;
use std::env;

fn main()  {
    let filepath: String = String::from("input/input.txt");
    let mut filedata: String = String::new();
    match read_file(filepath){
        Ok(data) => filedata = data,
        Err(err) => println!("{}", err)
    }
    let data_string_vector:Vec<&str> = filedata.lines().collect::<Vec<&str>>();
    let mut highest_calorie_sum: u32 = u32::MIN;
    let mut current_calorie_counter_sum: u32 = 0;
    for n in 0..(data_string_vector.len()-1){
        if data_string_vector[n] == "" {
            println!("vectoritem empty: {}", data_string_vector[n]);
            if current_calorie_counter_sum > highest_calorie_sum {
                highest_calorie_sum = current_calorie_counter_sum;
            }
            current_calorie_counter_sum = 0;
        }
        else {
            println!("vectoritem: {}", data_string_vector[n]);
            let curr_number:u32 = data_string_vector[n].parse::<u32>().unwrap();
            current_calorie_counter_sum += curr_number;
        }
    }
    println!("{}", highest_calorie_sum);
}

fn read_file(filepath: String) -> std::io::Result<String> {
    let currpath = env::current_dir()?;
    println!("Reading file: {}\\{}", currpath.display(), filepath);
    let data = fs::read_to_string(filepath).expect("Unable to read file");
    return Ok(data);
}