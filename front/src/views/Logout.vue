<template>
  <div class="logout">
    <h1>Logout Page</h1>
    <div v-text="this.$store.state.access_token"></div>

  </div>
</template>

<script>
// @ is an alias to /src

export default {
  name: 'Logout',
  components: {
  },

  created() {
    this.logout();
  },

  methods :{
    logout(){
      var myHeaders = new Headers();
      myHeaders.append("Authorization", "Bearer "+ this.$store.state.access_token )

      var requestOptions = {
        method: 'GET',
        headers: myHeaders,
        redirect: 'follow'
      };

      fetch("https://bookclub-ecp-api.herokuapp.com/api/logout", requestOptions)
        .then(response => response.text())
        .then(result => {console.log(result);localStorage.removeItem('access_token'); localStorage.removeItem('status')})
        .catch(error => console.log('error', error));

      this.$store.commit('setToken',null)
      this.$store.commit('setStatus',null)
      this.$router.push('/');    
      
      
    }
  }
}
</script>
