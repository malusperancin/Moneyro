<template>
  <div id="perfil">
    <img src="src/images/perfil11.png" alt id="imgPerfil" />
    <div @mouseenter="novas = !novas">h</div>
    <span id="notificacaoIcone" v-on:click="abrirNotificacoes"></span>
    <div id="notificacoes">
      <div class="notificacao" v-for="(notif, i) in notificacoes" v-bind:key="i">{{notif.descricao}}</div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      novas: false,
      notificacoes: []
    };
  },
  methods: {
    abrirNotificacoes() {
      this.novas = false;
      document.getElementById("notificacoes").style.display = "block";
    }
  },
  created() {
    this.notificacoes = [
      { descricao: 'Maria adicionou você a meta "Presente para tia rose"' },
      { descricao: 'Jovana atribuiu você a despesa "Bloquinho da Pabllo"' },
      { descricao: "Illy te adicionou como amigo" },
      { descricao: "vai se fude" },
      { descricao: "vai se fude" },
      { descricao: "vai se fude" },
      { descricao: "vai se fude" },
      { descricao: "vai se fude" },
      { descricao: "vai se fude" }
    ];
  },
  watch: {
    novas() {
      if (!this.novas)
        document.getElementById("notificacaoIcone").classList.remove("pulsar");
      else document.getElementById("notificacaoIcone").classList.add("pulsar");
    }
  }
};
</script>

<style scoped>
#perfil {
  position: fixed;
  top: 3%;
  right: 3%;
  background: rgb(214, 44, 44);
  width: 100px;
  height: 100px;
  border-radius: 50px;
  border: 1px solid rgba(0, 0, 0, 0.1);
  box-shadow: 5px 5px 10px rgb(0, 0, 0, 0.2);
}

#notificacaoIcone {
  position: absolute;
  width: 30px;
  height: 30px;
  border-radius: 50px;
  bottom: 1%;
  background: white;
  cursor: pointer;
  box-shadow: 0 0 0 0 rgba(0, 0, 0, 1);
}

.pulsar {
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0% {
    transform: scale(0.95);
    box-shadow: 0 0 0 0 rgba(0, 0, 0, 0.7);
  }

  70% {
    transform: scale(1);
    box-shadow: 0 0 0 10px rgba(0, 0, 0, 0);
  }

  100% {
    transform: scale(0.95);
    box-shadow: 0 0 0 0 rgba(0, 0, 0, 0);
  }
}

.notificacao {
  /* display: table-column; */
  margin: 5px;
  padding: 2px 4px;
  background: wheat;
}

#notificacoes {
  top: 20%;
  right: 1.5%;
  width: 10em;
  height: 20em;
  border-radius: 3px;
  position: fixed;
  display: none;
  background: rgba(131, 91, 91, 0.514);
  overflow: auto;
  max-height: 50%;
}

#imgPerfil {
  width: inherit;
  border-radius: 50px;
  position: absolute;
}
</style>