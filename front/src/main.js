import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'



Vue.config.productionTip = false

//library CSS
//import BootstrapVue from 'bootstrap-vue' 
import { BootstrapVue, BootstrapVueIcons } from 'bootstrap-vue'
import '../node_modules/bootstrap/dist/css/bootstrap.css'
import '../node_modules/bootstrap-vue/dist/bootstrap-vue.css'
Vue.use(BootstrapVue)
Vue.use(BootstrapVueIcons)


// ---------------Components----------------------//
//import
import Comment from './components/Comment.vue'
import Navbar from './components/Navbar.vue'
import MyFooter from './components/MyFooter.vue'

// component
Vue.component('Comment', Comment)
Vue.component('Navbar', Navbar)
Vue.component('MyFooter', MyFooter)


//vérifie le statut de connexion avant de rediriger vers une route
router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requireAdmin)) {
    // this route requires auth, check if logged in
    // if not, redirect to login page.
    if (!store.getters.isAdmin) {
      next({
        path: '/',
        query: { redirect: to.fullPath }
      })
    } else {
      next()
    }
  } else if (to.matched.some(record => record.meta.requireAuth)) {
      // this route requires auth, check if logged in
      // if not, redirect to login page.
      if (!store.getters.loggedIn) {
        next({
          path: '/login',
          query: { redirect: to.fullPath }
        })
      } else {
        next()
      }
  } else if (to.matched.some(record => record.meta.requireNew)) {
    // this route requires auth, check if logged in
    // if not, redirect to login page.
    if (store.getters.loggedIn) {
      next({
        path: '/',
        query: { redirect: to.fullPath }
      })
    } else {
      next()
    }
  } else {
    next() // make sure to always call next()!
  }
})

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
