<template>
  <div class="corpo">
    <router-view></router-view>
    <div id="footer">
      <p>&copy; Copyright Moneyro. Nenhum Direito Reservado.</p>
    </div>
  </div>
</template>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
var active = false;

import { routes } from "./routes";

export default {
  data() {
    return {
      routes,
      active: false
    };
  }
};
</script>

<style >
* {
  transition: all 0.3s;
  font-family: "Baloo Chettan 2", cursive;
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
  height: 15vh;
  padding: 30px 100px;
  color: white;
  background-color: rgb(67, 67, 67);
}

.corpo {
  height: 100%;
}

.pag {
  background-color: rgb(255, 227, 74);
  min-height: 100%;
}

.centro {
  height: 100%;
  padding: 3% 15%;
}
</style>
