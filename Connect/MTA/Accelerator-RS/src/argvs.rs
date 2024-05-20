use clap::{Arg, Command};
/**
 * Arguments of Application
 */
pub fn arguments_app () {
    let matches = Command::new("Accelerator")
        .version("1.0")
        .author("Drylian <danielolxlol@gmail.com>")
        .about("Accelerator is webserver witch compress files, used in mta for httpporturl")
        .arg(
            Arg::new("accelerator")
                .long("accelerator")
                .value_name("VALOR")
                .about("Define o valor do acelerador")
                .takes_value(true)
                .required(true),
        )
        .get_matches();

    // Obtenha o valor do argumento --accelerator
    if let Some(accelerator) = matches.value_of("accelerator") {
        println!("Valor do acelerador: {}", accelerator);
    }
}