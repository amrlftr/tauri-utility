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
    },
    {
      path: '/mutator',
      name: 'Mutator',
      component: () => import('../views/Mutator.vue')
    },
    {
      path: '/text',
      name: 'Text',
      component: () => import('../views/Text.vue')
    },
    {
      path: '/notes',
      name: 'Notes',
      component: () => import('../views/Notes.vue')
    },
    {
      path: '/tasks',
      name: 'tasks',
      component: () => import('../views/Tasks.vue')
    },
    {
      path: '/diagram',
      name: 'diagram',
      component: () => import('../views/Diagram.vue')
    },
    // {
    //   path: '/tasks-archived',
    //   name: 'tasks-archived',
    //   component: () => import('../views/TasksArchived.vue')
    // },
  ]
});

export default router
