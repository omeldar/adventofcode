use std::fs;

/*
The Elf finishes helping with the tent and sneaks back over to you. 
"Anyway, the second column says how the round needs to end: X means you need to lose, 
Y means you need to end the round in a draw, and Z means you need to win. Good luck!"

The total score is still calculated in the same way, but now you need to figure out what shape to choose 
so the round ends as indicated. The example above now goes like this:

In the first round, your opponent will choose Rock (A), and you need the round to end in a draw (Y), 
so you also choose Rock. This gives you a score of 1 + 3 = 4.


In the second round, your opponent will choose Paper (B), and you choose Rock so you lose (X) 
with a score of 1 + 0 = 1.

In the third round, you will defeat your opponent's Scissors with Rock for a score of 1 + 6 = 7.

Schere += 3 | C/Z
Rock += 1 | A
Paper += 2 | B
*/

fn main() {
    let string_data: String = read_file(String::from("input/input.txt"));
    let string_vector: Vec<&str> = string_data.lines().collect::<Vec<&str>>();


    let mut points: u32 = 0;
    for i in 0..string_vector.len(){
        let line_vector = string_vector[i].split(" ").collect::<Vec<&str>>();

        let bot_choice_index: u32 = string_choice_to_index(String::from(line_vector[0]));
        let game_outcome: String = String::from(line_vector[1]);
        let mut playerchoice_index: u32 = 5;

        // Tie
        if game_outcome == "Y" {
            points += 3;
            playerchoice_index = bot_choice_index;
        }
        if game_outcome == "X" {
            if bot_choice_index == 2{
                playerchoice_index = 0;
            }
            else{
                playerchoice_index = bot_choice_index + 1;
            }
        }
        if game_outcome == "Z" {
            points += 6;
            if bot_choice_index == 0{
                playerchoice_index = 2;
            }
            else{
                playerchoice_index = bot_choice_index -1;
            }
            
        }

        if playerchoice_index == 0{
            points += 2;
        }
        if playerchoice_index == 1 {
            points += 1;
        }
        if playerchoice_index == 2 {
            points += 3;
        }

        let tupl = (i, game_outcome, bot_choice_index, playerchoice_index, points);
        if i < 15 {
            println!("{:?}", tupl);
        }
    }

    println!("points: {}", points);

}

/*Schere += 3 | C/Z -> 2
Rock += 1 | A -> 1
Paper += 2 | B -> 0*/ 
fn string_choice_to_index(choice: String) -> u32 {
    let choice_as_static_str = &choice[..];
    match choice_as_static_str{
        "A" => return 1,
        "B" => return 0,
        "C" => return 2,
        _ => return 0
    }
}

fn read_file(filepath: String) -> String {
    return fs::read_to_string(filepath).expect("Unable to read file");
}