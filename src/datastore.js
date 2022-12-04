// import SQLite from 'tauri-plugin-sqlite-api';
import Database from 'tauri-plugin-sql-api'


// let dbPath = process.env.NODE_ENV === 'development'
//   ? 'd:/dev/electron-utility/src/extra_resources/utility.db'
//   : path.join(process.resourcesPath, '/extra_resources/utility.db');

class DB {
  async openConnection() {
    return await Database.load('sqlite:utility.db');
  }

  async closeConnection(db) {
    return await db.close();
  }

  async select(query, params = []) {
    const db = await this.openConnection();
    const rows = await db.select(query, params);
    await this.closeConnection(db);

    return rows;
  }

  async execute(query, params = []) {
    const db = await this.openConnection();
    await db.execute(query, params);
    await this.closeConnection(db);
  }
}

const db = new DB();

export default db;
