<template>
  <div class="article container col-md-10">
    <div class="text-left"><b-button variant="secondary" to="/articles" >Retour à la liste d'article</b-button></div>
    <div class="p-4 mt-4 bloc-article">  
      <div class=" w-50 mh-100 float-left"><img class="custom_image col-md-10 mx-auto d-block " :src="'https://bookclub-ecp-api.s3.amazonaws.com/'+articleInfo.image"/></div>
      
        <h3 class="my-4">{{articleInfo.title}}</h3>
        <p class="my-3">Ajouté par {{this.userInfo}}</p>
        <p class="my-2"><span class="book-subtitle">Auteur :</span> {{articleInfo.author}}</p>
        <p class="my-2"><span class="book-subtitle">Genre :</span> {{articleInfo.genre}} </p>
        <p class="my-2"><span class="book-subtitle">Edition :</span> {{articleInfo.edition}}</p>
        <p class="my-2"><span class="book-subtitle">Année de publication :</span> {{articleInfo.pub_year}}</p>
        <p class="my-4"><span class="book-subtitle">Résumé :</span> {{articleInfo.summary}}</p>
      
    </div>
    

    <div class="pb-4 mt-5">
      <h5 class="">Liste des commentaires</h5>
      <ListComments :article_id="this.$route.params.articleId" :articleComments="this.article_comments" v-on:update-comment="getComments"></ListComments>
      <NewComment v-if="this.$store.getters.loggedIn" v-on:update-comment="getComments" ></NewComment>
      <p v-else> <router-link to="/login">Connectez-vous</router-link> pour participer à la discussion </p>
    </div>
  
  </div>
</template>

<script>
// @ is an alias to /src
import ListComments from '@/components/ListComments.vue'
import NewComment from '@/components/NewComment.vue'

export default {
  name: 'Article',
  components: {
    ListComments,
    NewComment
  },
  data(){
    return {
      articleInfo: {},
      article_comments: {},
      comment:'',
      userInfo:''
    }
  },

  beforeMount(){
    console.log(this.$store.getters.loggedIn);
    this.getArticleInfo();
    this.getComments();
  },

  methods : {
    getUserInfo(id){
      var requestOptions = {
      method: 'GET',
      redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/users/${id}`, requestOptions)
        .then(response => response.json())
        .then(result => {console.log(result['name']); this.userInfo=result['name']})
        .catch(error => console.log('error', error));
    },

    getArticleInfo(){
      var requestOptions = {
        method: 'GET',
        redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/articles/${this.$route.params.articleId}`, requestOptions)
        .then(response => response.json())
        .then(result => {this.articleInfo=result ; this.getUserInfo(result['user_id'])})
        .catch(error => console.log('error', error));
    },

    getComments(){
      var requestOptions = {
      method: 'GET',
      redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/articles/${this.$route.params.articleId}/comments`, requestOptions)
        .then(response => response.json())
        .then(result => this.article_comments=result)
        .catch(error => console.log('error', error));
    },



  },

}
</script>
<style scoped>
.book-subtitle{
  font-weight: bold;
  text-decoration: underline;
  color:rgb(7, 57, 104);
  min-height : 480px
}
.bloc-article{
  border-radius: 120px;
  background-color: white;
}
.custom_image{
  border-radius : 60px;
  max-height : 450px;
}
</style>