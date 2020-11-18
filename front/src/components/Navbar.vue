<template>
  <div id="nav">
  <div>
    <b-navbar toggleable="lg" type="dark" variant="info" fixed="top">
      <b-navbar-brand to="/">Bookclub</b-navbar-brand>

      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav>
          <b-nav-item to="/articles" class="mx-2">Articles</b-nav-item>
          <b-nav-item to="/books" class="mx-2">Livres</b-nav-item>
        </b-navbar-nav>

        <!-- Right aligned nav items -->
        <b-navbar-nav class="ml-auto">
          <b-nav-item v-if="logged && !admin" to="/user-space" class="mx-2">User Space</b-nav-item>
          <b-nav-item v-if="logged && admin" to="/admin-space" class="mx-2">Admin Space</b-nav-item>
          <b-nav-item v-if="logged" to="/logout" class="btn-secondary mx-2 rounded" >Logout</b-nav-item>
          <b-nav-item v-if="!logged" to="/login" class="mx-2">Login</b-nav-item>
          <b-nav-item v-if="!logged" to="/register" class="mx-2">Register</b-nav-item>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </div>
    
  </div>
</template>

<script>
export default {
  name: 'Navbar',
  props: {
    logged: Boolean,
    admin: Boolean,
  },

  data(){
    return{

    }
  },


  methods :{


  },
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
#nav a {
  font-weight: bold;
  color: #ffffff;
}

#nav a.router-link-exact-active {
  color: #01413b;
}
</style>


