<template>
  <div class="admin-space container col-md-10">
    <h1>Admin space</h1>
    <h4>Liste de tous les utilisateurs</h4>
      <div class="bloc-list" id="list_user">
        <b-table striped hover :items="allUsers" :fields="user_fields">
          <template v-slot:cell(action)="data">
            <b-button variant="danger" @click="deleteUser(data.item.id)">X</b-button>
          </template>
        </b-table>
      </div>

      <h4>Liste de tous les articles</h4>
      <div class="bloc-list" id="list_article">
        
        <b-table striped hover :items="allArticles" :fields="article_fields">
          <template v-slot:cell(action)="data">
            <b-button class="my-2" variant="info" :href="'#/articles/'+data.item.id">
                  Voir
            </b-button>
            <b-button variant="danger" @click="deleteArticle(data.item.id)">X</b-button>
          </template>
        </b-table>
      </div>
      
      <h4>Liste de tous les livres</h4>
      <div class="bloc-list" id="list_book">
        
        <b-table striped hover :items="allBooks" :fields="book_fields">
          <template v-slot:cell(action)="data">
            <b-button variant="danger" @click="deleteBook(data.item.id)">X</b-button>
          </template>
        </b-table>
      </div>

  </div>
</template>

<script>
// @ is an alias to /src


export default {
  name: 'AdminSpace',
  components: {

  },
  data(){
    return {
      allUsers:'',
      allBooks:'',
      allArticles:'',
      user_fields:[
        'id',
        {key:'name',label:'Pseudo', sortable: true},
        {key:'email',label:'Adresse Mail', sortable: true},
        'action'
      ],
      article_fields: [
        {key:'title',label:'Titre', sortable: true}, 
        {key:'author', label:'Auteur', sortable: true}, 
        'genre',
        {key:'user_id', label:'Id User', sortable: true}, 
        'action'
      ],
      book_fields: [
        {key:'title', label:'Titre', sortable: true},
        'description',
        'genre', 
        {key:'user_id', label:'Id User', sortable: true},
        'action'
      ],
    }
  },

  beforeMount(){
    this.getUsers();
    this.getArticles();
    this.getBooks();
  },


  methods : {
    getUsers(){
      var requestOptions = {
        method: 'GET',
        redirect: 'follow'
      };

      fetch("https://bookclub-ecp-api.herokuapp.com/api/users", requestOptions)
        .then(response => response.json())
        .then(result => this.allUsers=result)
        .catch(error => console.log('error', error));
    },

    deleteUser(id){
      var requestOptions = {
        method: 'DELETE',
        redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/users/${id}`, requestOptions)
        .then(response => response.text())
        .then(result => {console.log(result);this.getUsers() })
        .catch(error => console.log('error', error));
    },


    getArticles(){
      var requestOptions = {
        method: 'GET',
        redirect: 'follow'
      };

      fetch("https://bookclub-ecp-api.herokuapp.com/api/articles", requestOptions)
        .then(response => response.json())
        .then(result => this.allArticles=result)
        .catch(error => console.log('error', error));     
    },

    deleteArticle(id){
      var requestOptions = {
        method: 'DELETE',
        redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/articles/${id}`, requestOptions)
        .then(response => response.text())
        .then(result => {console.log(result) ; this.getArticles()} )
        .catch(error => console.log('error', error));
      
    },


    getBooks(){
      var requestOptions = {
        method: 'GET',
        redirect: 'follow'
      };

      fetch("https://bookclub-ecp-api.herokuapp.com/api/allBooks", requestOptions)
        .then(response => response.json())
        .then(result => this.allBooks=result)
        .catch(error => console.log('error', error));
    },

    deleteBook(id){
      var requestOptions = {
        method: 'DELETE',
        redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/books/${id}`, requestOptions)
        .then(response => response.text())
        .then(result => {console.log(result);this.getBooks()})
        .catch(error => console.log('error', error));
      
    },


  },

}
</script>
<style scoped>
.bloc-list{
  background-color: lightcyan;
}
</style>
