<template>
  <div class="web">
    <router-view></router-view>
    <div id="footer">
      <p>&copy; Desenvolvido por: <br>Giovanna Pavani Martelli, Maria Luiza Sperancin Mancebo e Vinícius Martins Cotrim<br> 
      <small>(com muito amor, inclusive 💙)</small> <br> <br>
      Copyright Moneyro. Nenhum Direito Reservado.<br>  
      </p>
    </div>
  </div>
</template>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
import { routes } from "./routes";

export default {
  data() {
    return {
      routes
    };
  }
};
</script>

<style src="./css/responsivo.css"></style>
<style >
html {
  scroll-behavior: smooth;
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

#footer {
  padding: 30px 150px;
  color: white;
  background-color: rgb(67, 67, 67);
}

.web {
  height: 100vh;
}

.pag {
  /* background-color: rgb(255, 227, 74); */
  background-color: #0a0a0aeb;
  min-height: 100%;
}

.centro {
  height: 100%;
  padding: 3% 10%;
}
</style>
