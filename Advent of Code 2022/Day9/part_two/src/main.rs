use std::fs;
use std::collections::HashSet;

struct Snake{
    head: (i32,i32),
    tail: (i32,i32)
}

fn main() {
    let data_as_string = read_file(String::from("input/test.txt"));
    let data_as_vec: Vec<(String, i32)> = data_as_string
        .lines()
        .map(|l| (l.split_whitespace().collect::<Vec<&str>>()[0], l.split_whitespace().collect::<Vec<&str>>()[1]))
        .map(|t| (String::from(t.0), t.1.parse::<i32>().unwrap()))
        .collect::<Vec<(String, i32)>>();
    // because the tail doesnt move unto the last position of H after moving into each direction,
    // I'll just save all the positions of H without the last step in each direction and in the end count those
    let mut positions_of_t: HashSet<(i32, i32)> = HashSet::from_iter(vec![(0,0)]);
    let mut knots: [(i32,i32); 10] = [(0,0); 10];
    // move head
    for (dir,amt) in data_as_vec{
        for _ in 0..amt{
            match &dir[..]{
                "R" => knots[0].0 += 1,
                "U" => knots[0].1 += 1,
                "L" => knots[0].0 -= 1,
                "D" => knots[0].1 -= 1,
                _ => unreachable!()
            }
        }
    }
    println!("Knot 9 was in {} position(s).", positions_of_t.len());
    println!("{:?}", positions_of_t);
}

fn get_t_by_h((t_x, t_y): (i32, i32), (h_x, h_y): (i32, i32)) -> (i32,i32){
    
    return (0,0);
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