<script setup>
// This starter template is using Vue 3 <script setup> SFCs
// Check out https://vuejs.org/api/sfc-script-setup.html#script-setup
import Greet from "./components/Greet.vue";
import { useMenuStore } from '@/stores/MenuStore';

import { onMounted } from 'vue';

onMounted(async () => {
  const menuStore = useMenuStore();
  menuStore.load();
});
</script>

<template>
  <router-view></router-view>
</template>

<style scoped>
.logo.vite:hover {
  filter: drop-shadow(0 0 2em #747bff);
}

.logo.vue:hover {
  filter: drop-shadow(0 0 2em #249b73);
}
</style>
