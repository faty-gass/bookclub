<template>
  <div class="allArticles container col-md-10">
    <b-row>
      <b-col>
        <b-input-group size="lg" class="mt-4">
          <b-input-group-prepend is-text>
            <b-icon icon="search"></b-icon>
          </b-input-group-prepend>
          <b-form-input type="search" placeholder="Rechercher un article" v-model="search" @keyup.enter="searchArticle"></b-form-input>
        </b-input-group>        
      </b-col>
      <b-col cols="1" class=" h4 py-4">
        OU
      </b-col>
      <b-col>
        <b-form-select size="lg" class="mt-4" v-model="selected" :options="options" @change="sortArticle">
          <template v-slot:first>
            <b-form-select-option :value="null" disabled> Filtrer par genre </b-form-select-option>
          </template>
        </b-form-select>
      </b-col>
    </b-row>
    <b-row>
      <b-button class="ml-auto mr-4" size="sm" variant="secondary" @click="getAllArticles">Reset</b-button>
    </b-row>

    <OneArticle v-for="item in all_articles" :key="item.id" :article="item"></OneArticle>

  </div>
</template>

<script>
// @ is an alias to /src
import OneArticle from '@/components/OneArticle.vue'

export default {
  name: 'AllArticles',
  components: {
    OneArticle
  },
  data(){
    return {
      all_articles: {},
      search:'',
      selected: null,
      options: [
        { value: 'Aventure', text: 'Aventure'},
        { value: 'Fantastique', text: 'Fantastique'},
        { value: 'Historique', text: 'Historique' },
        { value: 'Policier', text: 'Policier' },
        { value: 'Romance', text: 'Romance' },
        { value: 'Science-Fiction', text: 'Science-Fiction' },
        { value: 'Thriller', text: 'Thriller' },
        { value: 'Autre', text: 'Autre' }, 
      ]
    }
  },

  beforeMount(){
    console.log(this.$store.getters.loggedIn);
    this.getAllArticles();
  },

  methods : {
    getAllArticles(){
      var requestOptions = {
        method: 'GET',
        redirect: 'follow'
      };

      fetch("https://bookclub-ecp-api.herokuapp.com/api/articles", requestOptions)
        .then(response => response.json())
        .then(result => this.all_articles=result)
        .catch(error => console.log('error', error));
    },

    searchArticle(){
      console.log(this.search)
      var formdata = new FormData();
      formdata.append("search", this.search);

      var requestOptions = {
        method: 'POST',
        body: formdata,
        redirect: 'follow'
      };

      fetch("https://bookclub-ecp-api.herokuapp.com/api/articles-search", requestOptions)
        .then(response => response.json())
        .then(result => this.all_articles=result)
        .catch(error => console.log('error', error));
    },

    sortArticle(){
      console.log(this.selected)
      var myHeaders = new Headers();
        myHeaders.append("Access-Control-Allow-Origin", "*");
        myHeaders.append("Content-Type", "application/json");
      var raw = JSON.stringify({"filtre":this.selected});

      var requestOptions = {
        method: 'POST',
        headers: myHeaders,
        body: raw,
        redirect: 'follow'
      };

      fetch("https://bookclub-ecp-api.herokuapp.com/api/articles-sort", requestOptions)
        .then(response => response.json())
        .then(result => {console.log(result) ; this.all_articles=result})
        .catch(error => console.log('error', error));      
    }

  },



}
</script>
