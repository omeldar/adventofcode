use std::fs;

fn main() {
    let mut crane_plan: (Vec<String>, Vec<(u32, u32, u32)>) = initialize_input(String::from("input/input.txt"));

    for instruction in crane_plan.1{
        let chars_to_move: Vec<char> = crane_plan.0[instruction.1 as usize].chars().rev().take(instruction.0 as usize).collect();
        for _ in 0..instruction.0{
            crane_plan.0[instruction.1 as usize].pop(); 
        }
        for char in chars_to_move.iter().rev(){
            crane_plan.0[instruction.2 as usize].push(*char);
        }
    }

    let mut result = String::new();
    for string in crane_plan.0{
        for char in string.chars().rev().take(1){
            result.push(char);
        }
    }

    println!("result: {}", result);
}

fn initialize_input(filepath: String) -> (Vec<String>, Vec<(u32, u32, u32)>){
    let data_as_string = read_file(filepath);
    let (cargo_pos, instructions) = data_as_string.split_once("\r\n\r\n").unwrap();
    let mut it = cargo_pos.lines().rev();
    let mut stacks: Vec<_> = it
        .next()
        .unwrap()
        .split_whitespace()
        .map(|_| String::new())
        .collect();

    for line in it{
        for (i, c) in line
            .chars()
            .skip(1)    // iterator skips 1 char positition "["
            .step_by(4)     // iterator will step by 4 to be exactly at next crate
            .enumerate()    // returns current iterator item and next value (i, val)
            .filter(|(_, x)| *x != ' ')
            {
                stacks[i].push(c);
            }
    }

    let instructions: Vec<(u32, u32, u32)> = instructions
        .lines()
        .map(|line: &str|{
            let mut iterator = line
                .split_whitespace() // split on whitespace
                .skip(1)    // skip first item "move"
                .step_by(2) // make iterator step by 2 to ignore text between instruction values
                .map(|x| x.parse::<u32>().unwrap());   // parse values into numbers

                // use iterator to put all the line values into a option<tuple>, -1 because int he vec array later, the index will be the value -1
                (|| Some((iterator.next()?, iterator.next()? -1, iterator.next()? -1)))().unwrap()
        })
        .collect();

    return (stacks, instructions);
}

fn read_file(filepath: String) -> String{
    return fs::read_to_string(filepath).expect("Unable to read file");
}