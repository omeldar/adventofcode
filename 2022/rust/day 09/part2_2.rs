
use std::fs;
use std::collections::HashSet;

fn main(){
    let data_as_string = read_file(String::from("input/test.txt"));
    let data_as_vec: Vec<(String, i32)> = data_as_string
        .lines()
        .map(|l| (l.split_whitespace().collect::<Vec<&str>>()[0], l.split_whitespace().collect::<Vec<&str>>()[1]))
        .map(|t| (String::from(t.0), t.1.parse::<i32>().unwrap()))
        .collect::<Vec<(String, i32)>>();
    


}

fn pos_is_connected((t_x, t_y): (i32,i32), (h_x, h_y): (i32,i32)) -> bool{
    if (t_x-h_x).abs() <= 1 && (t_y-h_y).abs() <= 1{
        return true;
    }
    return false;
}

fn read_file(filepath: String) -> String{
    return fs::read_to_string(filepath).expect("Unable to read file");
}