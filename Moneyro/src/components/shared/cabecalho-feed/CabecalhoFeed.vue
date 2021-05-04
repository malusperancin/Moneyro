<template>
  <header class="moneyro">
  <div class="marca">
    <img class="logo" src="src/images/logo.png" alt />
    <h1>Moneyro</h1>
   </div>
    <input class="filtro" placeholder="Pesquisar" type="text" />
  </header>
</template>

<style scoped>
.marca{
  display:flex;
  justify-content: space-between;
  padding: 7%;
}

input{
  border-radius: 5px;
  border: none;
  padding: 7px 14px;
  box-sizing: border-box;
  font-size: 1.2em;
  width: 50%;
  color: rgb(255, 255, 255);
  background: rgba(255, 255, 255, 0.078);
  margin:auto;
}
.moneyro {
  display: flex;
  color: white;
  background-color: rgba(12, 65, 111, 0.9);
  position: fixed;
  height: 8vh;
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  z-index: 99;
}

.logo {
  width: 100px;
}
</style>