<template>
  <div class="NewComment my-5">
    <b-form-group id="input-group-1" label="Commentaire :" label-for="input-1">
      <b-form-textarea
        id="input-1"
        type="text"
        v-model="comment"
        placeholder="Ajouter un commentaire"
      ></b-form-textarea>
    </b-form-group>
    <b-button type="submit" variant="primary" @click.prevent="sendComments">Envoyer</b-button>
    
  </div>
</template>

<script>


export default {
  name: 'NewComment',


  data(){
    return{
      comment:'',
      article_id: this.$route.params.articleId,
    }
  },

  methods :{
    sendComments(){
      var myHeaders = new Headers();
      myHeaders.append("Authorization", "Bearer "+this.$store.state.access_token)
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({"comment":this.comment,"article_id": this.$route.params.articleId});

      var requestOptions = {
        method: 'POST',
        headers: myHeaders,
        body: raw,
        redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/articles/${this.$route.params.articleId}/comments`, requestOptions)
        .then(response => response.text())
        .then(result => {console.log(result); this.$emit('update-comment')})
        .catch(error => console.log('error', error));

      this.$forceUpdate();
    },
  }
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
