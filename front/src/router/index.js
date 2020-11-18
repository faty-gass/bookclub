import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Register from '../views/Register.vue'
import Login from '../views/Login.vue'
import Logout from '../views/Logout.vue'
import UserSpace from '../views/UserSpace.vue'
import AdminSpace from '../views/AdminSpace.vue'
import NewArticle from '../views/NewArticle.vue'
import ModifyArticle from '../views/ModifyArticle.vue'
import AddImage from '../views/AddImage.vue'
import AllArticles from '../views/AllArticles.vue'
import Article from '../views/Article.vue'
import Books from '../views/Books.vue'
import NewBook from '../views/NewBook.vue'

Vue.use(VueRouter)

  const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/register',
    name: 'Register',
    component: Register,
    meta: {requireNew : true }
  },
  {
    path: '/login',
    name: 'Login',
    component: Login,
    meta:{ requireNew : true }
  },
  {
    path: '/logout',
    name: 'Logout',
    component: Logout,
    meta:{requireAuth : true },
  },
  {
    path: '/user-space',
    name: 'UserSpace',
    component: UserSpace,
    meta:{ requireAuth : true }
  },
  {
    path: '/admin-space',
    name: 'AdminSpace',
    component: AdminSpace,
    meta:{ requireAdmin : true }
  },
  {
    path: '/user-space/:userId/new-article',
    name: 'NewArticle',
    component: NewArticle,
    meta:{ requireAuth : true }
  },
  {
    path: '/user-space/:userId/article/:articleId',
    name: 'ModifyArticle',
    component: ModifyArticle,
    meta:{ requireAuth : true }
  },
  {
    path: '/user-space/:userId/update-article/:articleId',
    name: 'AddImage',
    component: AddImage,
    meta:{ requireAuth : true }
  },
  {
    path: '/articles',
    name: 'AllArticles',
    component: AllArticles,
  },
  {
    path: '/articles/:articleId',
    name: 'Article',
    component: Article,
  },

  {
    path: '/books',
    name: 'Books',
    component: Books,
  },
  {
    path: '/user-space/:userId/new-book',
    name: 'NewBook',
    component: NewBook,
    meta:{ requireAuth : true }
  },
  {
    path: '/about',
    name: 'About',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue'),
    meta:{requireAuth : true }
  }
]

const router = new VueRouter({
  routes
})

export default router
