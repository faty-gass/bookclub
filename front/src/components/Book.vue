<template>
  <div class="book my-3 col-md-6">
    <b-card img-left class="custom-card">
      <img :src="'https://bookclub-ecp-api.s3.amazonaws.com/'+book.image" alt="book image" class="w-50"/>
      <b-card-text>
        <h4 class="my-4">{{book.title}}</h4>
        <p class="my-2"><span class="book-subtitle">Auteur :</span> {{book.author}}</p>
        <p class="my-2"><span class="book-subtitle">Catégorie :</span> {{book.genre}} </p>
        <p class="my-2"><span class="book-subtitle">Description :</span> {{book.description}}</p>
        <a v-if="this.$store.getters.loggedIn" class="btn btn-primary my-3" :href="'mailto:'+this.userInfo+'?subject=BookClub - Mise en relation / '+book.title+'&body='+mail_message">
          Contacter le propriétaire
        </a>
        <p v-else> <router-link to="/login">Connectez-vous</router-link> pour contacter le propriétaire </p>
      </b-card-text>
    </b-card> 

    
  </div>
</template>

<script>
export default {
  name: 'Book',
  props: {
    book : Object,
  },

  data(){
    return{
      mail_message:"Bonjour %0D%0A %0D%0A Je souhaiterais me procurer un livre que vous proposez sur le site BookClub. %0D%0A %0D%0A Pouvez-vous me recontacter à cette adresse ? %0D%0A %0D%0A Merci",
      userInfo:''
    }
  },

  beforeMount(){
    this.getUserInfo(this.book.user_id)
  },

  methods :{
    getUserInfo(id){
      var requestOptions = {
      method: 'GET',
      redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/users/${id}`, requestOptions)
        .then(response => response.json())
        .then(result => {console.log(result['email']); this.userInfo=result['email']})
        .catch(error => console.log('error', error));
    }

  },
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.book-subtitle{
  font-weight: bold;
  text-decoration: underline;
  color:rgb(7, 57, 104);
}
.custom-card{
  border-radius : 25% 10%;
}
</style>


