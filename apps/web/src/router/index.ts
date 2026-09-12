import { createRouter, createWebHistory, type RouterHistory } from 'vue-router'

export function createAppRouter(history: RouterHistory) {
  return createRouter({
    history,
    routes: [
      {
        path: '/',
        redirect: '/overview',
      },
      {
        path: '/overview',
        component: {
          template: '<p>Overview</p>',
        },
      },
    ],
  })
}

const router = createAppRouter(createWebHistory())

export default router
