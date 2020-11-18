import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    client_secret:"x3LTqkTgrPYbGqxuH4EOtf4899bQYZRczok66uUQ",
    access_token: localStorage.getItem('access_token') || null,
    status: localStorage.getItem('status') || null,
  },
  mutations: {
    setToken(state,data){
      state.access_token=data;
    },
    setStatus(state,data){
      state.status=data;
    },
  },
  getters:{
    loggedIn(state){
      return state.access_token !== null
    },
    isAdmin(state){
      return state.status !== null
    },
  },
  actions: {
  },
  modules: {
  }
})
