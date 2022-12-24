import { createApp } from "vue";
import router from './router';
import "./style.css";
import App from "./App.vue";
import { createPinia } from 'pinia';
import 'v-calendar/dist/style.css';
import VCalendar from 'v-calendar';
import VueTippy from 'vue-tippy';
import 'tippy.js/dist/tippy.css';

const app = createApp(App)
  .use(router)
  .use(createPinia())
  .use(VCalendar, {
    componentPrefix: 'vc',
  })
  .use(
    VueTippy,
    {
      directive: 'tippy',
      defaultProps: {
        placement: 'top',
        allowHTML: true,
      },
    }
  );

app.mount("#app");
