use chat_gpt_lib_rs::{ChatGPTClient, ChatInput, Message, Model, Role};
use colored::*;
use dotenv::from_path;
use spinners::{Spinner, Spinners};

use std::env;

const OPENAI_BASE_URL: &str = "https://api.openai.com";

fn get_home_dir() -> String {
    match env::var("HOME") {
        Ok(val) => val,
        Err(e) => panic!("Error: {}", e),
    }
}

#[tokio::main]
async fn main() {
    match from_path(format!("{}/.config/hey/.env", get_home_dir())) {
        Ok(()) => {}
        Err(e) => panic!("Error: {}", e),
    };

    let openai_api_key = match env::var("OPENAI_API_KEY") {
        Ok(val) => val,
        Err(e) => panic!("Error: {}", e),
    };

    let model_name = match env::var("MODEL_NAME") {
        Ok(val) => val,
        Err(e) => panic!("Error: {}", e),
    };

    let question: String = env::args().collect::<Vec<String>>()[1..].join(" ");

    let client = ChatGPTClient::new(&openai_api_key, OPENAI_BASE_URL);
    let chat_input = ChatInput {
        model: Model::Gpt_4Turbo,
        messages: vec![
            Message {
                role: Role::System,
                content: "You are a helpful assistant.".to_string(),
            },
            Message {
                role: Role::User,
                content: question,
            },
        ],
        ..Default::default()
    };

    let mut sp = Spinner::new(
        Spinners::Dots9,
        "Waiting for response from AI"
            .bright_black()
            .to_string(),
    );
    let response = client.chat(chat_input).await.unwrap();
    sp.stop_and_persist("", "".to_string());

    for choice in &response.choices {
        println!("{}", choice.message.content);
    }
}
