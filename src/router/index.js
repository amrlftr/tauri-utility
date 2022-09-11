import { createRouter, createWebHistory } from 'vue-router';

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/', 
      name: 'Home',
      component: () => import('../views/Home.vue'),
    },
    {
      path: '/wip', 
      name: 'Wip',
      component: () => import('../views/Wip.vue'),
    }
  ]
});

export default router