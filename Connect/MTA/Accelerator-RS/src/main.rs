mod envs;
mod argvs;

use std::env;

fn main() {
    #[warn(unused_doc_comments)]
    let args: Vec<String> = env::args().collect();
    let mut arguments: Vec<String> = Vec::new();
    for (_, arg) in args.iter().enumerate() {
        arguments.push(arg.to_string());
    }
    env::set_var("APPLICATION_ARGS_VARS", arguments.join(" "));

    dotenv::dotenv().ok();
    // Read envs and set 
    envs::preset_envs();
    println!("Hello, world!, {}", arguments.join(" "));
}
