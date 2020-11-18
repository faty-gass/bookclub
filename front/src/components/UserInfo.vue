<template>
  <div class="userInfo mb-4">
    <b-row class="d-flex justify-content-around align-items-center">
      <b-col>
        <img class="col-md-4 mb-4" :src="'https://bookclub-ecp-api.s3.amazonaws.com/'+user_avatar"/>
        <p class="custom-input-label">Modifier votre image de profil</p>
        <div class="input-group border">
          <div class="custom-file">
            
            <input type="file" placeholder="ajouter une image" class="" accept="image/*" @change="imageChange"/>
            
          </div>
          <b-button class="input-group-append" type="submit" variant="primary" @click.prevent="sendPicture">Envoyer</b-button>
        </div>
      </b-col>

      <b-col>
        <p>Pseudo : {{user_name}} </p>
        <p>Adresse email : {{user_email}} </p>
      </b-col>
    </b-row>
    



    
  </div>
</template>

<script>
export default {
  name: 'UserInfo',
  props: {
    user_name: String,
    user_email: String,
    user_id: Number,
    user_avatar: String,
  },

  data(){
    return {
      image :'test'
    }
  },

  methods :{

    imageChange(e){
      let file = e.target.files[0]
      let reader = new FileReader()
      
      reader.onloadend = (file) =>{
        console.log('Result', reader.result);
        this.image=reader.result
      }
      reader.readAsDataURL(file)
    },

    sendPicture(){
      //console.log(this.image)
      var myHeaders = new Headers();
      myHeaders.append("Authorization", "Bearer "+this.$store.state.access_token)      
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({"avatar": this.image});

      var requestOptions = {
        method: 'PUT',
        headers: myHeaders,
        body: raw,
        redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/users/${this.user_id}`, requestOptions)
        .then(response => response.text())
        .then(result => {console.log(result); this.$emit('update-image')})
        .catch(error => console.log('error', error));
    }

  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
