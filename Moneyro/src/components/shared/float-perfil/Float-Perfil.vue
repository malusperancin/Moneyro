<template>
  <div id="perfil">
    <img src="src/images/perfil11.png" alt id="imgPerfil" />
    <span id="notificacaoIcone" v-on:click="abrirNotificacoes"></span>
    <div id="notificacoes">
      <div class="notificacao" v-for="notif in notificacoes">{{notif.descricao}}</div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      novas: true,
      notificacoes: []
    };
  },
  methods: {
    abrirNotificacoes: function() {
      document.getElementById("notificacoes").classList.toggle(".show");
    }
  },
  mounted() {
    if (this.novas) {
      // var icone = this.$refs["nitificacaoIcone"];
      // icone.style = "animation: none";
    }

    this.notificacoes = [
      { descricao: "vai se fude" },
      { descricao: "vai se fude" },
      { descricao: "vai se fude" },
      { descricao: "vai se fude" },
      { descricao: "vai se fude" },
      { descricao: "vai se fude" },
      { descricao: "vai se fude" },
      { descricao: "vai se fude" },
      { descricao: "vai se fude" },
      { descricao: "vai se fude" },
      { descricao: "vai se fude" },
      { descricao: "vai se fude" }
    ];
  }
};
</script>

<style scoped>
#perfil {
  position: absolute;
  top: 3%;
  right: 3%;
  background: rgb(214, 44, 44);
  width: 100px;
  height: 100px;
  border-radius: 50px;
  border: 1px solid rgba(0, 0, 0, 0.1);
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
  transform: scale(1);
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

.show {
  display: block;
}

#notificacoes {
  top: 20%;
  right: 1.5%;
  width: 9em;
  height: 12em;
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