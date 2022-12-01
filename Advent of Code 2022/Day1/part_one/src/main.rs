use std::fs;
use std::env;

fn main()  {
    let filepath = String::from("input/input.txt");
    let mut filedata = String::new();
    match read_file(filepath){
        Ok(data) => filedata = data,
        Err(err) => println!("{}", err)
    }
    println!("{}", filedata);
}

fn read_file(filepath: String) -> std::io::Result<String> {
    let currpath = env::current_dir()?;
    println!("Reading file: {}\\{}", currpath.display(), filepath);
    let data = fs::read_to_string(filepath).expect("Unable to read file");
    return Ok(data);
}