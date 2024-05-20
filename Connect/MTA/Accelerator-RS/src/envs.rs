use std::env;

/**
 * Read env and preset configurations
 */
pub fn preset_envs() {
    let log_level = env::var("LOG_LEVEL").unwrap_or("".to_string());
    if !log_level.is_empty() && (vec!["Error", "Warn", "Info", "Debug"].contains(&log_level.as_str())) {
        env::set_var("LOG_LEVEL", log_level);
    } else {
        env::set_var("LOG_LEVEL", "Info");
    }

    let log_level: String = env::var("LOG_LEVEL").unwrap_or("".to_string());
    if !log_level.is_empty() && (vec!["Error", "Warn", "Info", "Debug"].contains(&log_level.as_str())) {
        env::set_var("LOG_LEVEL", log_level);
    } else {
        env::set_var("LOG_LEVEL", "Info");
    }
}
