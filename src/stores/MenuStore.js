import { defineStore } from 'pinia';
import SQLite from 'tauri-plugin-sqlite-api';
import db from '@/datastore';

export const useMenuStore = defineStore('MenuStore', {
  state: () => ({
    menus: [],
  }),
  getters: {
    activeMenus: (state) => state.menus.filter((menu) => menu),
  },
  actions: {
    load() {
      this.setMenus();
    },
    async setMenus() {
      const menus = [];

      let rows = await db.select("SELECT * FROM menus WHERE name NOT IN ('query')");

      rows.forEach((row) => {
        menus.push(row);
      })

      this.menus = menus;
    },
  },
})
