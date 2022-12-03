use std::fs;

fn main() {
    // A X paper 1
    // B Y rock 2
    // C Z scissors 3
    let string_data: String = read_file(String::from("input/input.txt"));
    let string_vector: Vec<&str> = string_data.lines().collect::<Vec<&str>>();

    println!("{}", string_vector.len());

    let mut points: u16 = 0;

    for i in 0..(string_vector.len()) {
        let mut winner: u16 = 0;
        let line_vector = string_vector[i].split(" ").collect::<Vec<&str>>();
        // Match A B C, X Y Z to number variables
        let mut bot_choice: u16 = string_choice_to_number(String::from(line_vector[0]));
        let mut player_choice: u16 = string_choice_to_number(String::from(line_vector[1]));
        
        
        if bot_choice == 3 && player_choice == 1 {
            bot_choice = 0;
        }

        if player_choice == 3 && bot_choice == 1 {
            player_choice = 0;
        }

        if player_choice < bot_choice {
            winner = 1;
        }
        if bot_choice < player_choice {
            winner = 2;
        }

        if winner == 1 {
            points += 6;
        }
        if winner == 0 {
            points += 3;
        }

        if player_choice == 0 {
            player_choice = 3;
        }

        points += get_points_for_choice(player_choice);

        if i > string_vector.len() -5 || i < 5 {
            let tuple = (i, bot_choice, player_choice, points, winner);
            println!("{:#?}", tuple);
        }

    }

    println!("points: {}", points);

}

fn get_points_for_choice(choice: u16) -> u16{
    match choice {
        1 => return 2,
        2 => return 1,
        3 => return 3,
        _ => return 0
    }
}


fn string_choice_to_number(choice: String) -> u16 {
    let choice_as_static_str = &choice[..];
    match choice_as_static_str{
        "A" => return 2,
        "B" => return 1,
        "C" => return 3,
        "X" => return 2,
        "Y" => return 1,
        "Z" => return 3,
        _ => return 0
    }
}

fn read_file(filepath: String) -> String {
    return fs::read_to_string(filepath).expect("Unable to read file");
}