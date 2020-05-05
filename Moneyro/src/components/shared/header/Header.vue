<template>
  <header id="moneyro">
    <img id="logo" src="src/images/logo.png" alt />
    <h1>{{titulo}}</h1>
  </header>
</template>

<script>
export default {
  props: {
    titulo: String
  }
};
</script>

<style scoped>
#moneyro {
  color: white;
  background-color: rgba(12, 65, 111, 0.9);
  position: fixed;
  height: 100px;
  width: 100%;
  text-align: center;
}

#logo {
  width: 100px;
}

h1 {
  display: inline-table;
  vertical-align: 80%;
}
</style>
