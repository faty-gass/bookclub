<template>
  <div class="updateArticle">
    <h1>Modification de l'article</h1>
    
      <b-form v-if="show">
        <b-form-group id="input-group-1" label="Titre :" label-for="input-1">
          <b-form-input
            id="input-1"
            v-model="titre"
            type="text"
            required
            :placeholder="currentInfo.title"
          ></b-form-input>
        </b-form-group>


        <b-form-group id="input-group-6" label="Résumé du livre :" label-for="input-6">
          <small>{{currentInfo.summary}}</small>
            <b-form-textarea
              id="input-6"
              type="text"
              v-model="summary"
              placeholder="Résumé modifié"
            ></b-form-textarea>
          
        </b-form-group>


        <b-button type="submit" variant="primary" @click="onSubmit">Modifier l'article</b-button>
      </b-form>
      <p v-if="error_message">{{error_message}}</p>

  </div>
</template>

<script>
// @ is an alias to /src


export default {
  name: 'NewArticle',
  components: {

  },
  data(){
    return {
      show: true,
      titre : '',
      summary:'',
      currentInfo:'',
      user_id: this.$route.params.userId,
      error_message:'',

    }
  },

  beforeMount(){
    console.log(this.$store.getters.loggedIn);
    this.getArticleInfo();

  },

  methods : {
    getArticleInfo(){
      var requestOptions = {
        method: 'GET',
        redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/articles/${this.$route.params.articleId}`, requestOptions)
        .then(response => response.json())
        .then(result => this.currentInfo=result)
        .catch(error => console.log('error', error));
    },

    onSubmit(){
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({"title":this.titre,
      "summary": this.summary ,
       });

      var requestOptions = {
        method: 'POST',
        headers: myHeaders,
        body: raw,
        redirect: 'follow'
      };

      fetch("https://bookclub-ecp-api.herokuapp.com/api/articles", requestOptions)
        .then(response => response.json())
        .then(result => {console.log(result);
          if (result['status_code'] === 200 ){
            this.$router.push('/user-space')
          } else {
            this.error_message= result['error']['title'][0]
          }
          })
        .catch(error => console.log('error', error));
    },

  },

}
</script>
