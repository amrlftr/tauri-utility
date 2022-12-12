import { createApp } from "vue";
import router from './router';
import "./style.css";
import App from "./App.vue";
import { createPinia } from 'pinia';
import 'v-calendar/dist/style.css';
import VCalendar from 'v-calendar';


createApp(App)
  .use(router)
  .use(createPinia())
  .use(VCalendar, {
    componentPrefix: 'vc',
  })
  .mount("#app");
