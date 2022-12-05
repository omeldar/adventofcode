use std::fs;

// By storing the coordinates where he already has been we can count these and get the amount of houses santa visited.
// We will simply just not store a coordinate in our list if it already exists

fn main() {
    let data_as_string = read_file(String::from("input/input.txt"));
    let mut houses_visited: Vec<(u16, u16)> = [(0,0)].to_vec();
    let (mut x, mut y): (i16, i16) = (0, 0);
    for char in data_as_string.chars(){
        let action: (String, i16) = match_char_to_action(char);
        if action.0 == "x"{
            x += action.1;
        }
        if action.0 == "y"{
            y += action.1;
        }
        if !houses_visited.contains(&(x as u16,y as u16)){
            houses_visited.push((x as u16,y as u16));
        }
        
    }
    println!("{}", houses_visited.len());
}

fn match_char_to_action(char: char) -> (String, i16){
    return match char{
        '>' => (String::from("x"), 1),
        '<' => (String::from("x"), -1),
        '^' => (String::from("y"), 1),
        'v' => (String::from("y"), -1),
        _ => unimplemented!()
    }
}

fn read_file(filepath: String) -> String{
    return fs::read_to_string(filepath).expect("Unable to read file");
}