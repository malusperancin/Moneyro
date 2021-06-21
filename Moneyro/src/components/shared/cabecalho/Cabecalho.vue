<template>
  <header id="moneyro">
    <div class="voltar" v-if="this.$route.path != '/quiz'">
      <a title="Login" class="nav__link" v-on:click="$router.push('/')">
        <ion-icon name="arrow-back-circle" v-pre></ion-icon>
        <span class="nav__name">Voltar</span>
      </a>
    </div>
    <div class="logo"> 
      <img id="logo" src="src/images/logo.png" alt />
      <h1>{{titulo}}</h1>
    </div>
    <div class="voltar-none" v-if="this.$route.path != '/quiz'">
      <a title="Login" class="nav__link" v-on:click="login = true">
        <ion-icon name="log-in-outline" class="nav__icon" v-pre></ion-icon>
        <span class="nav__name">Login</span>
      </a>
    </div>
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
.voltar-none {
  visibility: hidden;
}

#moneyro {
  color: white;
  background-color: rgba(12, 65, 111, 0.9);
  position: fixed;
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 40px;
  z-index: 999;
  box-sizing: border-box;
}

#logo {
  width: 100px;
}

.logo {
  display: flex;
  grid-gap: 15px;
}

.nav__link {
  font-size: 1.5em;
  display: flex;
  align-items: center;
  background: rgba(255, 255, 255, 0.1);
  justify-content: space-between;
  border-radius: 5px;
  padding: 3px 14px;
  cursor: pointer;
  grid-gap: 10px;
}

.nav__link:hover {
  box-shadow: 1px 1px 5px rgba(0, 0, 0, 0.5);
  background: rgba(255, 255, 255, 0.05);
}

.nav__icon {
  margin-right: 8px;
}
</style>
