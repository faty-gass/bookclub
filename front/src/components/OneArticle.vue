<template>
  <div class="OneArticle my-5 container col-md-10">
<!--     <div class="d-flex justify-start border">    
      <div class=" w-50"><img class="col-md-10 rounded mx-auto d-block" :src="'https://bookclub-ecp-api.herokuapp.com/'+ article.image"/></div>
      <div class="w-50 p-3">
        <h3 class="my-2">{{article.title}}</h3>
        <p class="my-2">Ajouté par {{this.userInfo}}</p>
        <p class="my-2">Auteur : {{article.author}}</p>
        <p class="my-2">Genre : {{article.genre}} </p>
        <p class="my-3">Résumé : {{shortSummary}}</p>
      </div>
      <a :href="'#/articles/'+article.id" class="stretched-link"></a>
    </div>  -->
    
     <b-card :img-src="'https://bookclub-ecp-api.s3.amazonaws.com/'+article.image"        
      img-alt="book_image" 
      img-left
      img-width="40%"
      class="mb-3 custom_card">
      <b-card-text>
        <h2 class="my-4">{{article.title}}</h2>
        
        <p class="my-3 mx-2 text-left"><span class="book-subtitle">Auteur :</span> {{article.author}}</p>
        <p class="my-3 mx-2 text-left"><span class="book-subtitle">Genre :</span> {{article.genre}} </p>
        <p class="my-4 mx-2 text-left"> <span class="book-subtitle">Résumé :</span> {{shortSummary}}</p>
        <p class="mb-2 mt-4 mx-2 text-right font-italic">Article ajouté par {{this.userInfo}}</p>
      </b-card-text>
      <a :href="'#/articles/'+article.id" class="stretched-link"></a>
    </b-card> 

    
  </div>
</template>

<script>
export default {
  name: 'OneArticle',
  props: {
    article : Object,
  },

  data(){
    return{
      userInfo:'',
    }
  },

  computed: {
    // a computed getter
    shortSummary: function () {
      // `this` points to the vm instance
      return this.article.summary.substring(0, 200)+" ...";
    }
  },

  beforeMount(){
    this.getUserInfo(this.article.user_id)
  },

  methods :{
    getUserInfo(id){
      var requestOptions = {
      method: 'GET',
      redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/users/${id}`, requestOptions)
        .then(response => response.json())
        .then(result => {console.log(result['name']); this.userInfo=result['name']})
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
.custom_card{
  border-radius: 60px  !important;
}
</style>


