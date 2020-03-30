<template>
  <div class="corpo">
    <router-view></router-view>
    <footer>RODAPE</footer>
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

html {
  height: 100%;
}

footer {
  width: 100%;
  height: 20%;
  bottom: 0;
  left: 0;
  color: white;
  background-color: rgb(67, 67, 67);
  position: absolute;
}

.corpo {
  height: 100%;
  background-color: initial;
  height: 100%;
  width: 100%;
}
</style>
