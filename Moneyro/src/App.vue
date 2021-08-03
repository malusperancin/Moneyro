<template>
  <div class="web">
    <router-view v-on:tema="tema"></router-view>
    <div id="footer">
      <div class="footer-corpo">
        <div class="footer-logo"><b>Moneyro</b></div>
        <div class="footer-coluna">
          <div class="footer-container" v-on:click="$router.push('/')">
            <p> Feed </p>
            <ion-icon name="reader-outline" v-pre ></ion-icon>
          </div>
        </div>
        <div class="footer-coluna"> 
        <div :class="[{'footer-container' : $session.exists() == false}, {'footer-container-2' : $session.exists() == true}]" v-on:click="cadastro()">
          <div v-if="!$session.exists()">
            <p> Cadastro </p>
           <ion-icon name="person-add" v-pre></ion-icon>
          </div>
          <img alt="" v-else class="footer-img" src="src/images/logo.png" />
          </div>  
        </div>
        <div class="footer-coluna">  
        <div class="footer-container" v-on:click="$router.push('sobre')">
          <p> Sobre nós </p>
          <ion-icon name="information-circle-outline" v-pre></ion-icon>
          </div> 
        </div>
        <div class="redes">
          <div>
            <div class="icones"> 
              <ion-icon name="logo-twitter" v-pre></ion-icon>
              <ion-icon name="logo-facebook" v-pre></ion-icon>
              <ion-icon name="logo-instagram" v-pre></ion-icon>
            </div>
            <button> Contato </button>
          </div>
        </div>
      </div>
      <div class="footer-baixo">
         &copy; 2021 Copyright • Giovanna Pavani Martelli • Maria Luiza Sperancin Mancebo • Vinícius Martins Cotrim
      </div>
    </div>
  </div>
</template>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
import { routes } from "./routes";


export default {
  data() {
    return {
      routes,
      
    };
  },
  methods:{
    cadastro(){
    if(!this.$session.exists())
      this.$router.push('cadastro')
    else
      this.$router.push('/usuario')
    

    },
    tema() {
      alert(2);
    }
  },
    created(){
      document.documentElement.style.overflow = 'hidden';
    }
};
</script>

<style src="./css/responsivo.css"></style>
<style>
html {
  scroll-behavior: smooth;
}

:root {
  --fundo: #1d1d1d;;
  --font: #ffffff;
} 

* {
  transition: all 0.3s;
  font-family: "Baloo Chettan 2", cursive;
  outline: none;
}

body {
  min-height: 100%;
  margin: 0;
  height: 100%;
}

html {
  height: 100%;
}

.web {
  height: 100vh;
}

.pag {
  /* background-color: rgb(255, 227, 74); */
  background-color: var(--fundo);
  min-height: 100%;
}

.centro {
  height: 100%;
  padding: 3% 10%;
}

#footer {
  color: white;
  background-color: rgb(67, 67, 67);
  z-index: 9999999;
}

.footer-corpo {
  display: flex;
  padding: 30px 2%;
  z-index: 9999999;
}

.footer-container {
  background-color: rgb(73, 73, 73);
  padding: 10px 25px;
  border-radius: 5px;
  min-width: 60px;
}

.footer-container-2 {
  padding: 0 25px;
  border-radius: 5px;
  min-width: 60px;
  margin-top: -20px;
}

.footer-container:hover {
  background-color: rgb(130, 73, 73);
  cursor: pointer;
}

.footer-container:hover {
  background-color: rgb(78, 78, 78);
}

.footer-coluna{
  text-align: center;
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.footer-coluna ion-icon{
  font-size: 30px;
}

.footer-icon-text{
  margin:0;
  width:50%;
}

.footer-coluna p {
  font-weight: bold;
  margin: 0;
  padding: 0;
}

.redes {
  flex: 2;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction:column;
}

.redes .icones {
  display: flex;
  font-size: 1.75em;
  grid-gap: 15px;
  margin-bottom: 25px;
}

.redes .icones ion-icon {
  color: white;
}

.redes button{
  background: #ecb318;
  border-radius: 50px;
  color: white;
  border: none;
  padding: 5px 25px;
  width: 100%;
}

.footer-img {
  width: 120px;
}

.footer-baixo {
    background-color:rgb(60,60,60);
    text-align: center;
    font-size: 0.75em;
    padding: 10px 0;
}

.footer-logo {
  flex: 2;
  text-align: center;
  font-size: 2em;
}
</style>
