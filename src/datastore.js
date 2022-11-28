import SQLite from 'tauri-plugin-sqlite-api';

// let dbPath = process.env.NODE_ENV === 'development'
//   ? 'd:/dev/electron-utility/src/extra_resources/utility.db'
//   : path.join(process.resourcesPath, '/extra_resources/utility.db');

class DB {
  async openConnection() {
    return await SQLite.open('../src/utility.db');
  }

  async closeConnection(db) {
    return await db.close();
  }

  async select(query) {
    const db = await this.openConnection();
    const rows = await db.select(query);
    await this.closeConnection(db);

    return rows;
  }
}

const db = new DB();

export default db; 