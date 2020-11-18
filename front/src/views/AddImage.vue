<template>
  <div class="addImage container col-md-8 text-left">
    <h2 class="text-center my-4">Ajoutez une illustration à votre article</h2>
    
      <b-form v-if="show" class="pb-4">
        <b-form-group id="input-group-7" label="Ajouter une image de couverture :" label-for="input-7">
          <input id="input-7" type="file" class="form-control" accept="image/*" @change="imageChange"/>       
        </b-form-group>

        <b-button type="submit" variant="info" @click="onSubmit">Ajouter l'image</b-button>
      </b-form>
      <p v-if="error_message">{{error_message}}</p>

  </div>
</template>

<script>
// @ is an alias to /src


export default {
  name: 'AddImage',
  components: {

  },
  data(){
    return {
      show: true,

      article_image:'',
      summary:'',
      article_id: this.$route.params.articleId,
      error_message:'',

    }
  },

  beforeMount(){
    console.log(this.$store.getters.loggedIn);

  },

  methods : {
    imageChange(e){
      let file = e.target.files[0]
      let reader = new FileReader()
      
      reader.onloadend = (file) =>{
        console.log('Result', reader.result);
        this.article_image=reader.result
      }
      reader.readAsDataURL(file)
    },

    onSubmit(){
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({
      'image': this.article_image });

      var requestOptions = {
        method: 'PUT',
        headers: myHeaders,
        body: raw,
        redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/articles/${this.article_id}`, requestOptions)
        .then(response => response.json())
        .then(result => {console.log(result);
          if (result['status_code'] === 200 ){
            this.$router.push('/user-space')} 
        })
        .catch(error => console.log('error', error));
    },

  },

}
</script>
