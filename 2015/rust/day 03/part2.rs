use std::fs;

// By storing the coordinates where he already has been we can count these and get the amount of houses santa visited.
// We will simply just not store a coordinate in our list if it already exists

fn main() {
    let data_as_string = read_file(String::from("input/input.txt"));
    let mut houses_visited: Vec<(u16, u16)> = [(0,0)].to_vec();
    let (mut santa_x, mut santa_y): (i16, i16) = (0, 0);
    let (mut robo_x, mut robo_y): (i16, i16) = (0, 0);
    for (i, char) in data_as_string.chars().enumerate(){
        let action: (String, i16) = match_char_to_action(char);
        if action.0 == "x"{
            if i % 2 == 0 {
                santa_x += action.1;
            }
            else{
                robo_x += action.1;
            }
        }
        if action.0 == "y"{
            if i % 2 == 0 {
                santa_y += action.1;
            }
            else{
                robo_y += action.1;
            }
        }
        if i % 2 == 0{
            if !houses_visited.contains(&(santa_x as u16,santa_y as u16)){
                houses_visited.push((santa_x as u16,santa_y as u16));
            }
        }
        else{
            if !houses_visited.contains(&(robo_x as u16,robo_y as u16)){
                houses_visited.push((robo_x as u16,robo_y as u16));
            }
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