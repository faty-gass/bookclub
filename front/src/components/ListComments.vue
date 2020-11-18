<template>
  <div class="ListComments my-5">
    <div >
      <Comment v-for="item in articleComments" :key="item.id" :commentInfo="item" :user_id="item.user_id" v-on:delete-comment="$emit('update-comment')" ></Comment>
    </div>
    
    
  </div>
</template>

<script>
import Comment from '@/components/Comment.vue'

export default {
  name: 'ListComments',

  components :{
    Comment,
  },

  props: {
    article_id : String,
    articleComments : Object,
  },

  data(){
    return{

    }
  },

  beforeMount(){
    
  },


  methods :{
/*     getComments(){
      var requestOptions = {
      method: 'GET',
      redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/articles/${this.article_id}/comments`, requestOptions)
        .then(response => response.json())
        .then(result => this.articleComments=result)
        .catch(error => console.log('error', error));
    }, */

/*     getUsersInfo(){
      var requestOptions = {
        method: 'GET',
        redirect: 'follow'
      };

      fetch("http://localhost:8000/api/users", requestOptions)
        .then(response => response.json())
        .then(result => console.log(result))
        .catch(error => console.log('error', error));      
    } */

  },
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>


