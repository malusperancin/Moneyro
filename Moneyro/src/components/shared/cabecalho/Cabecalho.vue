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
  height: 8vh;
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 20px;
  z-index: 999;
}

#logo {
  width: 100px;
}
</style>
