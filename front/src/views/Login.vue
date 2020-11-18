<template>
  <div class="login container col-md-6 my-4 pb-4">
    <b-form @submit="onSubmit" v-if="show">
      <b-form-group
        id="input-group-1"
        label="Votre adresse e-mail"
        label-for="input-1"
      >
        <b-form-input
          id="input-1"
          v-model="form.email"
          type="email"
          required
          placeholder="Entrez votre e-mail"
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-3" label="Votre mot de passe" label-for="input-3">
        <b-form-input
          id="input-3"
          type="password"
          v-model="form.password"
          minlength="6"
          required
          placeholder="Entrez un mot de passe"
        ></b-form-input>
      </b-form-group>

      <b-button type="submit" variant="primary">Envoyer</b-button>
    </b-form>
  <div v-if="error_message">L'email ou le mot de passe est incorrect !</div>
  </div>
</template>

<script>
// @ is an alias to /src


export default {
  name: 'Login',
  components: {

  },

  data(){
    return {
      form: {
        email: '',
        password:'',
      },
      show: true,
      error_message:'',
    }
  },

  methods : {
    onSubmit(evt) {
      evt.preventDefault()
      var myHeaders = new Headers();
      myHeaders.append("Cookie", "XSRF-TOKEN=eyJpdiI6Ikp2YjE1UWdiTVF5Q3pDQzU2Mit5L3c9PSIsInZhbHVlIjoiQkNncVBRbkIzRGRwYjZjMnJsOFA5NENiTGszZ1c0Wk8zcitIK2xxak02VmZPcHh4UmRZNGxTTUtub3RwdityT2dSUzhtaXY1dmJDd0JtaW1IRWJqTHBoNTZhTzVqeTR5aHJsRm1zMEF0K1dYbmU4RVpjUzJTMVlNVWZWdnZpd0IiLCJtYWMiOiI4ZmJlNGI4ZmZjNzc5MTViOWJhMGY0NjQ5YzZkNTlkNWMxYjczNWM4MzlhNTMyYzc4YTBhMjJkZDY1MjBhODBiIn0%3D; laravel_session=eyJpdiI6IlA2VHkyUllVUmxrUkdjdVNXc3l5TGc9PSIsInZhbHVlIjoid2Q4bGtpR2hnQ1NqUVlhY1UrTENpTlF1eWZCeU5Fa1ZPZW41Rkc2R2lKM1hiWVNrQ0lNMVJjK2NFUTRMZGIzMjNiNHpvbVZqeFNKMHBDUTFleHYvQ1FXVkVSL0pBdGFUSHVzcFZ2MHBhczh4UHd2a1hlb0FIVVlzUzdweGs5Nk0iLCJtYWMiOiI4ZWExOTEyMTA4YTVhOTcyOTdmODFiODkzNmRjOGM4YzUyYmU1NjVjZTUxMDc2YzhjMzU3ZGU1NWQwZTM2ZTEyIn0%3D");

      var formdata = new FormData();
      formdata.append("grant_type", "password");
      formdata.append("client_id", "11");
      formdata.append("client_secret", this.$store.state.client_secret);
      formdata.append("username", this.form.email);
      formdata.append("password", this.form.password);

      var requestOptions = {
        method: 'POST',
        headers: myHeaders,
        body: formdata,
        redirect: 'follow'
      };

      fetch("https://bookclub-ecp-api.herokuapp.com/oauth/token", requestOptions)
        .then(response => response.json())
        .then(result => {console.log(result); 
          if (result['error']){this.error_message="ok"}
          else if (result['access_token']){
            localStorage.setItem('access_token',result['access_token']);
            this.$store.state.access_token=localStorage.getItem('access_token');
            this.$router.push('/user-space') }
        })
        .catch(error => console.log('error', error));
        
    },
   
  }

}
</script>
