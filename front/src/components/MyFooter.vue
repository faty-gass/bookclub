<template>
  <div id="myFooter ">
  <!-- Site footer -->
    <footer class="site-footer bg-info">
      <div class="container col-md-10">
        <div class="row">
          <div class="container col-md-12">
            <h6 class="text-left">About</h6>
            <p class="text-justify">BookClub est un site de partage autour de la littérature. Nous vous proposons d'y découvrir des critiques de tout type de livre. Vous pouvez aussi vous procurer gratuitement des livres grâce à l'espace de partage. Rejoingnez la communauté !!!</p>
          </div>

        </div>
        <hr>
      </div>
      <div class="container">
        <div class="row">
          <div class="container col-md-6">
            <p class="copyright-text">Copyright &copy; 2020 All Rights Reserved by 
         Fatymata Gassama.
            </p>
          </div>

        </div>
      </div>
</footer>
  </div>
</template>

<script>
export default {
  name: 'MyFooter',
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.site-footer
{
  background-color:#5bc0de;
  padding:25px 0 20px;
  font-size:15px;
  line-height:24px;
  color:#022929;
}
.site-footer hr
{
  border-top-color:#bbb;
  opacity:0.5
}
.site-footer hr.small
{
  margin:10px 0
}
.site-footer h6
{
  color:#fff;
  font-size:18px;
  font-weight: bold;
  text-transform:uppercase;
  margin-top:0px;
  letter-spacing:2px
}
.site-footer a
{
  color:#022929;
}
.site-footer a:hover
{
  color:#3366cc;
  text-decoration:none;
}
.footer-links
{
  padding-left:0;
  list-style:none
}
.footer-links li
{
  display:block
}
.footer-links a
{
  color:#022929
}
.footer-links a:active,.footer-links a:focus,.footer-links a:hover
{
  color:#3366cc;
  text-decoration:none;
}
.footer-links.inline li
{
  display:inline-block
}

.copyright-text
{
  margin:0
}
@media (max-width:991px)
{
  .site-footer [class^=col-]
  {
    margin-bottom:10px
  }
}
@media (max-width:767px)
{
  .site-footer
  {
    padding-bottom:0
  }
  .site-footer .copyright-text,.site-footer .social-icons
  {
    text-align:center
  }
}

@media (max-width:767px)
{
  .social-icons li.title
  {
    display:block;
    margin-right:0;
    font-weight:600
  }
}
</style>


