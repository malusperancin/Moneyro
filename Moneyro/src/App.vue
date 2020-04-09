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

<style>
* {
  margin: 0;
  padding: 0;
  transition: all 0.3s;
  font-family: "Baloo Chettan 2", cursive;
}

html,
body {
  width: 100%;
  height: 100%;
}

#footer {
  height: 15%;
  padding: 30px;
  color: white;
  background-color: rgb(67, 67, 67);
  z-index: 10;
}

.corpo {
  width: 100%;
  height: 100%;
}

.pag {
  width: 100%;
  height: 100%;
}
</style>
