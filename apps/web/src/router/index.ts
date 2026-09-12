import { createRouter, createWebHistory, type RouterHistory } from 'vue-router'
import OverviewView from '../views/OverviewView.vue'

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
        component: OverviewView,
      },
    ],
  })
}

const router = createAppRouter(createWebHistory())

export default router
