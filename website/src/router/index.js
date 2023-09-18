import { createRouter, createWebHistory } from 'vue-router'
import topicsView from '../views/topicsView.vue'
import HistoryView from '../views/HistoryView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      redirect: '/topics'
    },
    {
      path: '/topics',
      name: 'topics',
      component: topicsView
    },
    {
      path: '/history',
      name: 'history',
      component: HistoryView
    }
  ]
})

export default router
