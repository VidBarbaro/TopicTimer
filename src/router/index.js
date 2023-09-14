import { createRouter, createWebHistory } from 'vue-router'
import SubjectsView from '../views/SubjectsView.vue'
import HistoryView from '../views/HistoryView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/subjects',
      name: 'subjects',
      component: SubjectsView
    },
    {
      path: '/history',
      name: 'history',
      component: HistoryView
    }
  ]
})

export default router
