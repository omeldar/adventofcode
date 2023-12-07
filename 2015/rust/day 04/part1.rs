use md5;

fn main() {
    let secret_key = "ckczppom";
    for i in 1..u128::MAX{
        let hashinput: String = String::from(secret_key) + &i.to_string();
        let hash: String = format!("{:x}", md5::compute(hashinput));
        if hash.starts_with("00000"){
            println!("hash: {}\nindex: {}", hash, i);
            break;
        }
    }
}