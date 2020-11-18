<template>
  <div class="UserRecapBook">
    <div id="list_book">
      <b-table striped hover :items="userBooks" :fields="fields">
        <template v-slot:cell(available)="data">
          <b-button v-if="data.value == 1" variant="danger" @click="setUnavailable(data.item.id)">Désactiver</b-button>
          <b-button v-else variant="success" @click="setAvailable(data.item.id)" >Activer</b-button>

        </template>
      </b-table>

    </div>
    
  </div>
</template>

<script>
export default {
  name: 'UserRecap',
  props: {
    userBooks : Object,
  },

  data(){
    return {
      fields: [
      {key:'title', label:'Titre', sortable: true},
      {key:'author', label:'Auteur', sortable: true}, 
      'description', 
      'genre', 
      { key: 'available', label: 'Status' }
      ],

    }
  },

  methods :{
    setUnavailable(id){
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({"available":0});

      var requestOptions = {
        method: 'PUT',
        headers: myHeaders,
        body: raw,
        redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/books/${id}`, requestOptions)
        .then(response => response.text())
        .then(result => {console.log(result); this.$emit('update-status')})
        .catch(error => console.log('error', error));
    },
    setAvailable(id){
      var myHeaders = new Headers();
      myHeaders.append("Content-Type", "application/json");

      var raw = JSON.stringify({"available":1});

      var requestOptions = {
        method: 'PUT',
        headers: myHeaders,
        body: raw,
        redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/books/${id}`, requestOptions)
        .then(response => response.text())
        .then(result => {console.log(result); this.$emit('update-status')})
        .catch(error => console.log('error', error));
    }
  },
}

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>


