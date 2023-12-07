use std::fs;
use std::collections::HashMap;

fn main() {
    let data_as_string = read_file(String::from("input/input.txt"));
    let grid_size = data_as_string.lines().count();
    let map_as_grid = initialize_grid(data_as_string);

    let mut visible_trees: u32 = 0;

    for row_i in 0..grid_size{
        for col_i in 0..grid_size{
            if is_on_edge(row_i, col_i, grid_size){
                visible_trees += 1;
            }
            else{
                let curr_pos_value = map_as_grid.get(&(row_i, col_i));
                // check from current pos if to the left all smaller
                let mut biggest_to_left = true;
                for this_row_col_i in (0..col_i).rev(){
                    if map_as_grid.get(&(row_i, this_row_col_i)).unwrap() >= curr_pos_value.unwrap(){
                        biggest_to_left = false;
                    }
                }
                // check from current pos if to the right all smaller
                let mut biggest_to_right = true;
                for this_row_col_i in col_i+1..grid_size{
                    if map_as_grid.get(&(row_i, this_row_col_i)).unwrap() >= curr_pos_value.unwrap(){
                        biggest_to_right = false;
                    }
                }
                // check from current pos if to top all smaller
                let mut biggest_to_top = true;
                for this_col_row_i in (0..row_i).rev(){
                    if map_as_grid.get(&(this_col_row_i, col_i)).unwrap() >= curr_pos_value.unwrap(){
                        biggest_to_top = false;
                    }
                }
                // check from current pos if to top all smaller
                let mut biggest_to_bottom = true;
                for this_col_row_i in row_i+1..grid_size{
                    if map_as_grid.get(&(this_col_row_i, col_i)).unwrap() >= curr_pos_value.unwrap(){
                        biggest_to_bottom = false;
                    }
                }
                // end check
                if biggest_to_left == true || biggest_to_right == true || biggest_to_top == true || biggest_to_bottom == true{
                    visible_trees += 1;
                }
            }
        }
    }

    println!("Visible trees: {}", visible_trees);
}

fn is_on_edge(row_index: usize, column_index: usize, grid_size: usize) -> bool{
    if row_index == 0 || column_index == 0 ||
        row_index == grid_size -1 || column_index == grid_size -1 {
        return true;
    }
    return false;
}

fn initialize_grid(data: String) -> HashMap<(usize, usize), u8>{
    let mut grid = HashMap::new();
    let lines: Vec<&str> = data.lines().collect();

    // Map is a square so for both directions we can use just the count of lines
    let grid_size = lines.len();

    for row_index in 0..grid_size{
        let chars: Vec<char> = lines[row_index].chars().collect();
        for column_index in 0..grid_size{
            grid.insert((row_index, column_index), chars[column_index] as u8 - 48);
        }
    }

    return grid;
}

fn read_file(filepath: String) -> String{
    return fs::read_to_string(filepath).expect("Unable to read file");
}