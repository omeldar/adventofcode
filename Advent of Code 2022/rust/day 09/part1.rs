use std::fs;
use std::collections::HashSet;

fn main() {
    let data_as_string = read_file(String::from("input/input.txt"));
    let data_as_vec: Vec<(String, i32)> = data_as_string
        .lines()
        .map(|l| (l.split_whitespace().collect::<Vec<&str>>()[0], l.split_whitespace().collect::<Vec<&str>>()[1]))
        .map(|t| (String::from(t.0), t.1.parse::<i32>().unwrap()))
        .collect::<Vec<(String, i32)>>();
    // because the tail doesnt move unto the last position of H after moving into each direction,
    // I'll just save all the positions of H without the last step in each direction and in the end count those
    let mut positions_of_t: HashSet<(i32, i32)> = HashSet::from_iter(vec![(0,0)]);
    let mut curr_tail = (0,0);
    let (mut h_x,mut h_y): (i32, i32) = (0,0);
    // move head
    for (dir,amt) in data_as_vec{
        for _ in 0..amt{
            let (lasth_x, lasth_y): (i32,i32) = (h_x,h_y);
            match &dir[..]{
                "R" => h_x += 1,
                "U" => h_y += 1,
                "L" => h_x -= 1,
                "D" => h_y -= 1,
                _ => unreachable!()
            }
            curr_tail = get_t_by_h(curr_tail, (lasth_x, lasth_y), (h_x, h_y));
            positions_of_t.insert(curr_tail);
        }
    }
    println!("T was in {} position(s).", positions_of_t.len());
}

fn get_t_by_h((t_x, t_y): (i32, i32), (lasth_x,lasth_y): (i32, i32), (h_x, h_y): (i32, i32)) -> (i32,i32){
    // if not connected, set T to last H
    if !pos_is_connected((t_x, t_y), (h_x, h_y)){
        return (lasth_x, lasth_y);
    }
    return (t_x,t_y);
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