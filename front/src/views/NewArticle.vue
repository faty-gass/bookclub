<template>
  <div class="newArticle container col-md-8 text-left">
    <h2 class="text-center my-4">Créez un nouvel Article</h2>
    
      <b-form v-if="show" class="pb-4">
        <b-form-group id="input-group-1" label="Titre :" label-for="input-1">
          <b-form-input
            id="input-1"
            v-model="titre"
            type="text"
            required
            placeholder="Indiquez le nom du livre"
          ></b-form-input>
        </b-form-group>

        <b-form-group id="input-group-2" label="Auteur :" label-for="input-2">
          <b-form-input
            id="input-2"
            v-model="auteur"
            required
            placeholder="Indiquez l'auteur du livre"
          ></b-form-input>
        </b-form-group>

        <b-form-group id="input-group-3" label="Genre :" label-for="input-3">
          <b-form-select
            id="input-3"
            v-model="genre"
            :options="genres"
            required
          ></b-form-select>
        </b-form-group>

        <b-form-group id="input-group-4" label="Edition :" label-for="input-4">
          <b-form-input
            id="input-4"
            type="text"
            v-model="edition"
            placeholder="Indiquez l'édition"
          ></b-form-input>
        </b-form-group>

        <b-form-group id="input-group-5" label="Année de publication :" label-for="input-5">
          <b-form-input
            id="input-5"
            type="number"
            v-model="pub_year"
            placeholder="Indiquez l'année de publication"
          ></b-form-input>
        </b-form-group>

        <b-form-group id="input-group-6" label="Résumé du livre :" label-for="input-6">
          <b-form-textarea
            id="input-6"
            type="text"
            v-model="summary"
            placeholder="Résumé du livre"
          ></b-form-textarea>
        </b-form-group>

        <b-form-group id="input-group-7" label="Ajouter une image de couverture :" label-for="input-7">
          <input id="input-7" type="file" class="form-control" accept="image/*" @change="imageChange"/>       
        </b-form-group>

        <b-button type="submit" variant="info" @click="onSubmit">Publier l'article</b-button>
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
      genres: [
        { value: 'Aventure', text: 'Aventure'},
        { value: 'Fantastique', text: 'Fantastique'},
        { value: 'Historique', text: 'Historique' },
        { value: 'Policier', text: 'Policier' },
        { value: 'Romance', text: 'Romance' },
        { value: 'Science-Fiction', text: 'Science-Fiction' },
        { value: 'Thriller', text: 'Thriller' },
        { value: 'Autre', text: 'Autre' }, 
        ],
      auteur:'',
      genre:'',
      edition:'',
      pub_year:'',
      article_image:'',
      summary:'',
      user_id: this.$route.params.userId,
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

      var raw = JSON.stringify({"title":this.titre,
      "summary": this.summary ,
      "author":this.auteur,
      "genre":this.genre ,
      "edition":this.edition,
      "pub_year":this.pub_year,
      "user_id":this.user_id,
      "image": this.article_image });

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
