<template>
  <div class="newBook container col-md-8 text-left">
    <h3 class="my-4 text-center">Ajoutez un nouveau livre</h3>
    
      <b-form class="pb-4" v-if="show">
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

        <b-form-group id="input-group-6" label="Description :" label-for="input-6">
          <b-form-textarea
            id="input-6"
            type="text"
            v-model="description"
            placeholder="informations sur le livre"
          ></b-form-textarea>
        </b-form-group>

        <b-form-group id="input-group-7" label="Ajouter une photo du livre :" label-for="input-7">
          <input id="input-7" type="file" class="form-control" accept="image/*" @change="imageChange"/>       
        </b-form-group>

        <b-button type="submit" variant="info" @click="onSubmit">Ajouter le livre</b-button>
      </b-form>
      <p v-if="error_message">{{error_message}}</p>

  </div>
</template>

<script>
// @ is an alias to /src


export default {
  name: 'NewBook',
  components: {

  },
  data(){
    return {
      show: true,
      titre : '',
      genres: [
        { value: 'Art, Musique, Cinéma', text: 'Art, Musique, Cinéma' },
        { value: 'Education', text: 'Education' },   
        { value: 'Jeunesse', text: 'Jeunesse' },
        { value: 'Littérature', text: 'Littérature' },
        { value: 'Ressources Professionnelles', text: 'Ressources Professionnelles' },
        { value: 'Sante Bien-Etre', text: 'Sante Bien-Etre' },
        { value: 'Autre', text: 'Autre' },
        ],
      auteur:'',
      genre:'',
      book_image:'',
      description:'',
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
        //console.log('Result', reader.result);
        this.book_image=reader.result;
        console.log(this.book_image)
      }
      reader.readAsDataURL(file)
    },

    onSubmit(){
      var myHeaders = new Headers();
      myHeaders.append("Authorization", "Bearer "+this.$store.state.access_token)
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({"title":this.titre,
      "description": this.description,
      "author":this.auteur,
      "genre":this.genre,
      "image": this.book_image });

      var requestOptions = {
        method: 'POST',
        headers: myHeaders,
        body: raw,
        redirect: 'follow'
      };

      fetch("https://bookclub-ecp-api.herokuapp.com/api/books", requestOptions)
        .then(response => response.json())
        .then(result => {console.log(result);
          if (result['status_code'] === 200 ){
            this.$router.push('/user-space')
          } 
          })
        .catch(error => console.log('error', error));
    },

  },

}
</script>
