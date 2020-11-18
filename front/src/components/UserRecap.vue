<template>
  <div class="UserRecap">
    <div id="list_article">
      <b-table striped hover :items="userArticles" :fields="fields">
        <template v-slot:cell(action)="data">
          <b-button  v-b-modal="'modal'+data.item.id" >Plus d'info</b-button>
          <b-modal :id="'modal'+data.item.id" :title="data.item.title" ok-only ok-disabled > 
            <div class="d-flex justify-start">
              <div class=" w-50"><img class="col-md-10 rounded mx-auto d-block" :src="'https://bookclub-ecp-api.s3.amazonaws.com/'+ data.item.image"/></div>
              <div class="w-50 p-3">
                <p class="my-4">Auteur : {{data.item.author}}</p>
                <p class="my-4">Genre : {{data.item.genre}} </p>
                <p class="my-4">Edition : {{data.item.edition}}</p>
                <p class="my-4">Année de publication : {{data.item.pub_year}}</p>
              </div>
            </div>
            <p class="my-4">Résumé : {{data.item.summary}}</p>
              <template v-slot:modal-footer>
                <b-button class="my-2" variant="info" :href="'#/user-space/'+user_recap_id+'/update-article/'+data.item.id">
                  Modifier image
                </b-button>
                <b-button class="my-2" variant="info" :href="'#/articles/'+data.item.id">
                  Voir sur le site
                </b-button>
                
              </template>
          </b-modal>
        </template>
      </b-table>


    </div>
    

    
  </div>
</template>

<script>
export default {
  name: 'UserRecap',
  props: {
    user_recap_id: Number,
    userArticles : Object,
  },

  data(){
    return{
      fields: [
        {key:'title',label:'Titre', sortable: true}, 
        {key:'author', label:'Auteur', sortable: true}, 
        'genre', 
        'action'
      ],
    }
  },

  methods :{

  },
}

/* 
:href="'#/user-space/'+user_id+'/article/'+data.item.id"
<div>
  <b-button v-b-modal.modal-1>Launch demo modal</b-button>

  <b-modal id="modal-1" title="BootstrapVue">
    <p class="my-4">Hello from modal!</p>
  </b-modal>
</div> */
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>


