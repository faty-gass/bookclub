<template>

  <div class="user-space container col-md-10">
    <h2>Bienvenue sur votre espace {{this.user_info.name}}</h2>
    <UserInfo v-on:update-image="getAuthUser" :user_name="this.user_info.name" :user_email="this.user_info.email" :user_id="this.user_info.id" :user_avatar="this.user_info.avatar"></UserInfo>
    <div class="mt-4">
      <UserRecap :user_recap_id="this.user_info.id" :userArticles="user_articles"></UserRecap>
      <b-button class="mb-4" variant="info" :href="'#'+this.$route.path+'/'+this.user_info.id+'/new-article'" >Ajouter une article</b-button>
    </div>
    <div class="mt-4">
      <p>Donnez une deuxième vie à un livre que vous avez déjà lu !! transmettez-le !!</p>
      <UserRecapBook :userBooks="user_books" v-on:update-status="getAuthUser"></UserRecapBook>
      <b-button class="mb-4" variant="info" :href="'#'+this.$route.path+'/'+this.user_info.id+'/new-book'" >Proposer un livre</b-button>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import UserInfo from '@/components/UserInfo.vue'
import UserRecap from '@/components/UserRecap.vue'
import UserRecapBook from '@/components/UserRecapBook.vue'

export default {
  name: 'UserSpace',
  components: {
    UserInfo,
    UserRecap,
    UserRecapBook
  },
  data(){
    return {
      user_info:{},
      user_articles:{},
      user_books: {},
    }
  },

  beforeMount(){
    console.log(this.$store.getters.loggedIn);
    this.getAuthUser();
  },


  methods : {
    getArticles(id){
      var requestOptions = {
        method: 'GET',
        redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/users/${id}/articles`, requestOptions)
        .then(response => response.json())
        .then(result => {this.user_articles=result ;console.log(result)})
        .catch(error => console.log('error', error));      
    },

    getBooks(id){
      var requestOptions = {
        method: 'GET',
        redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/users/${id}/books`, requestOptions)
        .then(response => response.json())
        .then(result => this.user_books=result)
        .catch(error => console.log('error', error));
    },

    getAuthUser(){
      var myHeaders = new Headers();
      myHeaders.append("Authorization", "Bearer "+this.$store.state.access_token)

      var requestOptions = {
        method: 'GET',
        headers: myHeaders,
        redirect: 'follow'
      };

      fetch("https://bookclub-ecp-api.herokuapp.com/api/user", requestOptions)
        .then(response => response.json())
        .then(result => { if (result['name']=='Admin'){
          localStorage.setItem('status','admin');
          this.$store.state.status=localStorage.getItem('status');
          this.$router.push('/admin-space')
          } else {
            this.user_info=result ; this.getArticles(result['id']) ; this.getBooks(result['id'])
          }
        })
        .catch(error => console.log('error', error));
    },



  },

}
</script>
<style scoped>
.user-space{
  background-color: rgb(255, 255, 255) !important;
}
</style>
