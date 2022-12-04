#![cfg_attr(
    all(not(debug_assertions), target_os = "windows"),
    windows_subsystem = "windows"
)]

// Learn more about Tauri commands at https://tauri.app/v1/guides/features/command
// #[tauri::command]
// fn greet(name: &str) -> String {
//     format!("Hello, {}! You've been greeted from Rust!", name)
// }

use tauri_plugin_sql::{Migration, MigrationKind, TauriSql};

fn main() {
    tauri::Builder::default()
        // .invoke_handler(tauri::generate_handler![greet])
        // .plugin(tauri_plugin_sqlite::init())
        .plugin(TauriSql::default().add_migrations(
          "sqlite:utility.db",
          vec![Migration {
            version: 1,
            description: "utility db",
            sql: include_str!("../migrations/initial.sql"),
            kind: MigrationKind::Up,
          }],
        ))
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
