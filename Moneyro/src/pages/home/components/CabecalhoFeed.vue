<template>
  <header id="header">
  <mensagem
      :msg="msg"
      v-if="msg.visivel"
      v-on:sair="(msg.visivel = false), $session.destroy(), $router.go()"
      v-on:fechar="msg.visivel = false"
    ></mensagem>
    <login v-show="login" v-on:fechar="login = false"/>
    <div class="marca">
      <img class="logo" src="src/images/logo.png" alt />
      <h1>Moneyro</h1>
    </div>

    <div class="nav__list">
      <a v-show="!$session.exists()" title="Login" class="nav__link" v-on:click="login = true">
        <ion-icon name="log-in-outline" class="nav__icon" v-pre></ion-icon>
        <span class="nav__name">Login</span>
      </a>
      <a v-show="!$session.exists()" title="Cadastro" class="nav__link" v-on:click="$router.push('cadastro')">
        <ion-icon name="person-add" class="nav__icon" v-pre></ion-icon>
        <span class="nav__name">Cadastro</span>
      </a>

      <a v-show="$session.exists()" title="Sair" class="nav__link" v-on:click="$emit('sair')">
        <ion-icon name="log-out-outline" class="nav__icon" v-pre></ion-icon>
        <span class="nav__name">Sair</span>
      </a>
    </div>
  </header>
</template>

<script>
import Menu from '../../shared/login/Login.vue';
import Mensagem from "../../shared/mensagem/Mensagem.vue";

export default {
  props: ["filtro"],
  components: {
    login: Menu,
    mensagem: Mensagem,
  },
  data() {
    return {
      login: false,
      msg: {
        visivel: false,
        titulo: "",
        mensagem: "",
        botoes: [],
      },
    };
  },
};
</script>


<style scoped>
@media only screen and (max-width: 1000px) {
  .marca {
    display: none !important;
  }

  #header {
    padding: 35px 80px 35px 45px !important;
  }
}


#header {
  display: flex;
  color: white;
  background-color: rgba(12, 65, 111);
  position: fixed;
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 120px;
  z-index: 99;
  box-sizing: border-box;
}

.marca{
  display: grid;
  grid-template-columns: 1fr 1fr;
}

.logo {
  width: 100px;
}

.nav__list {
  display: flex;
  grid-gap: 10px;
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
}

.nav__link:hover {
  box-shadow: 1px 1px 5px rgba(0, 0, 0, 0.5);
  background: rgba(255, 255, 255, 0.05);
}

.nav__icon {
  margin-right: 8px;
}
</style>