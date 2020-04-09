<template>
  <div class="pag">
    <menu-bar></menu-bar>
    <div id="texto">
      <p>Bem-vindo(a) de volta</p>
      <h1>Seu saldo é R$</h1>
      <h4>
        seu saldo ta ruim seu gastao irreponsavel de merda
        <br />ai q bonitineo c ta no positivo
      </h4>
    </div>
  </div>
</template>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
import $ from "jquery";
import Menu from "../shared/menu/Menu.vue";

export default {
  components: {
    "menu-bar": Menu
  },
  methods: {}
};
</script>

<style scoped>
.pag {
  height: 100%;
  background-color: rgb(255, 227, 74);
}
#texto {
  margin: auto;
  float: right;
  margin-right: 34%;
  width: 30%;
  text-align: center;
}
#texto p {
  margin-top: 10%;
  margin-bottom: 50px;
}
</style>