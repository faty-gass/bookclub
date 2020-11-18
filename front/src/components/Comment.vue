<template>
  <div class="Comment my-2">

      <div class=" d-flex justify-content-between align-items-center container col-md-8">
        <div class="col-md-10 border corps-comment">
          <b-img id="avatar_pic" rounded="circle" thumbnail left class="col-md-2 border" :src="'https://bookclub-ecp-api.s3.amazonaws.com/'+ userInfos.avatar"></b-img>
          <div>{{commentInfo.comment}}</div>
          <small>Par {{userInfos.name}}, le {{shortDate}}</small>
        </div>
        <div>
          <b-icon v-if="this.$store.getters.isAdmin" icon="x-circle" scale="2" variant="danger" class="btn" @click="deleteComment(commentInfo.id)"></b-icon>
          
        </div>
        
      </div>
    </div>

</template>

<script>
export default {
  name: 'Comment',
  props: {
    commentInfo : Object,
    user_id : Number,
  },

  data(){
    return{
      userInfos: {},
    }
  },

  computed: {
    // a computed getter
    shortDate: function () {
      // `this` points to the vm instance
      return this.commentInfo.created_at.substring(0, 10);
    }
  },

  beforeMount(){
    this.getUsersInfo();
  },


  methods :{
    deleteComment(id){
      console.log(id)
       var requestOptions = {
        method: 'DELETE',
        redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/comments/${id}`, requestOptions)
        .then(response => response.text())
        .then(result => {console.log(result); this.$emit('delete-comment')})
        .catch(error => console.log('error', error));
    },

    getUsersInfo(){
      var requestOptions = {
        method: 'GET',
        redirect: 'follow'
      };

      fetch(`https://bookclub-ecp-api.herokuapp.com/api/users/${this.user_id}`, requestOptions)
        .then(response => response.json())
        .then(result => this.userInfos=result)
        .catch(error => console.log('error', error));      
    }

  },
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
#avatar_pic{
  width: 70px;
}
.corps-comment{
  background-color: rgb(240, 246, 255);
}
</style>


