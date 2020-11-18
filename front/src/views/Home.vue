<template>
  <div class="home pb-4 container mt-4 col-md-10">

      <h2 class="mb-4"> Bienvenue sur Bookclub </h2>
      <div class="d-flex justify-content-around mb-5">
        <div id="bloc-info" class="card">
          <h5 class="mb-4 font-weight-bold"> Articles</h5>
          <p >Partagez vos critiques de livres et échangez avec la communauté</p>
          <a href="#/articles" class="stretched-link" ></a>
        </div>
        <div id="bloc-info" class="card">
          <h5 class="mb-4 font-weight-bold">Livres</h5>
          <p>Retrouvez une sélection de livres disponibles gratuitement</p>
          <a href="#/books" class="stretched-link"></a>
        </div>

      </div>

      
      <b-button size="lg" variant="success" href="#/register">Inscrivez-vous !</b-button>


  </div>
</template>

<script>
// @ is an alias to /src
import HelloWorld from '@/components/HelloWorld.vue'

export default {
  name: 'Home',
  components: {
    HelloWorld
  },
  mounted(){
    console.log(this.$store.getters.loggedIn)
  }
}
</script>
<style scoped>
#bloc-info{
  background-color: lightcyan!important;
  border-radius: 2px;
  max-width: 300px;
  padding: 10px;
  
}
</style>
