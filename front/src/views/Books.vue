<template>
  <div class="books container col-md-10">
    <b-row>
      <b-col>
        <b-input-group size="lg" class="mt-4">
          <b-input-group-prepend is-text>
            <b-icon icon="search"></b-icon>
          </b-input-group-prepend>
          <b-form-input type="search" placeholder="Rechercher un livre" v-model="search" @keyup.enter="searchBook"></b-form-input>
        </b-input-group>
      </b-col>
      <b-col cols="1" class=" h4 py-4">
        OU
      </b-col>
      <b-col>
        <b-form-select size="lg" class="mt-4" v-model="selected" :options="options" @change="sortBooks">
          <template v-slot:first>
            <b-form-select-option :value="null" disabled> Filtrer par catégorie </b-form-select-option>
          </template>
        </b-form-select>
      </b-col>
    </b-row>
    <b-row>
      <b-button class="ml-auto mr-4" size="sm" variant="secondary" @click="getAllBooks">Reset</b-button>
    </b-row>

    <div class="d-flex justify-content-between flex-wrap">
     <Book v-for="item in all_book" :key="item.id" :book="item"></Book>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import Book from '@/components/Book.vue'

export default {
  name: 'Books',
  components: {
    Book
  },

  data(){
    return {
      all_book: {},
      selected: null,
      options: [
        { value: 'Art, Musique, Cinéma', text: 'Art, Musique, Cinéma' },
        { value: 'Education', text: 'Education' },   
        { value: 'Jeunesse', text: 'Jeunesse' },
        { value: 'Littérature', text: 'Littérature' },
        { value: 'Ressources Professionnelles', text: 'Ressources Professionnelles' },
        { value: 'Sante Bien-Etre', text: 'Sante Bien-Etre' },
        { value: 'Autre', text: 'Autre' },
      ]
    }
  },

  beforeMount(){
    this.getAllBooks()
  },

  methods : {
    getAllBooks(){
      var requestOptions = {
        method: 'GET',
        redirect: 'follow'
      };

      fetch("https://bookclub-ecp-api.herokuapp.com/api/books", requestOptions)
        .then(response => response.json())
        .then(result => this.all_book=result)
        .catch(error => console.log('error', error));
    },

    searchBook(){
      console.log(this.search)
      var formdata = new FormData();
      formdata.append("search", this.search);

      var requestOptions = {
        method: 'POST',
        body: formdata,
        redirect: 'follow'
      };

      fetch("https://bookclub-ecp-api.herokuapp.com/api/books-search", requestOptions)
        .then(response => response.json())
        .then(result => this.all_book=result)
        .catch(error => console.log('error', error));
    },

    sortBooks(){
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

      fetch("https://bookclub-ecp-api.herokuapp.com/api/books-sort", requestOptions)
        .then(response => response.json())
        .then(result => {console.log(result) ; this.all_book=result})
        .catch(error => console.log('error', error));      
    }    

  },

}
</script>
