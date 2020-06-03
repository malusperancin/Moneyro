<template>
  <div id="perfil">
    <div id="imagem" @mouseenter="notificacoes.push({ descricao: 'oinc' })">
      <div id="conteudo">
        <div id="notificacaoIcone" v-on:click="abrirNotificacoes"></div>
        <img
          :src="'src/images/perfil' + $session.get('foto') + '.png'"
          alt="foto de perfil"
          id="imgPerfil"
          v-on:click="$router.push('usuario')"
        />
      </div>
    </div>
    <div id="notificacoes" @mouseleave="fecharNotificacoes">
      <div
        class="notificacao animate"
        v-for="(notif, i) in notificacoes"
        v-bind:key="i"
      >{{notif.descricao}}</div>
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
    },
    fecharNotificacoes() {
      document.getElementById("notificacoes").style.display = "none";
    }
  },
  created() {
    this.notificacoes = [
      { descricao: 'Maria adicionou você a meta "Presente para tia rose"' },
      { descricao: 'Jovana atribuiu você a despesa "Bloquinho da Pabllo"' },
      { descricao: "Illy te adicionou como amigo" }
    ];
  },
  watch: {
    notificacoes() {
      if (document.getElementById("notificacoes").style.display == "none")
        this.novas = true;

      document.getElementById("notificacaoIcone").classList.add("pulsar");
    },
    novas() {
      if (!this.novas)
        document.getElementById("notificacaoIcone").classList.remove("pulsar");
    }
  }
};
</script>

<style scoped>
#perfil {
  z-index: 99;
  position: fixed;
  top: 3%;
  right: 3%;
  text-align: end;
  width: 15%;
}

#imagem {
  position: relative;
  display: flex;
  justify-content: flex-end;
}

#conteudo {
  border: 1px solid rgba(0, 0, 0, 0.1);
  box-shadow: 5px 5px 10px rgb(0, 0, 0, 0.2);
  border-radius: 87px;
  display: flex;
}

#notificacaoIcone {
  cursor: pointer;
  bottom: 0;
  position: absolute;
  border-radius: 87px;
  height: 30px;
  width: 30px;
  background: white;
}

.pulsar {
  animation: pulse 2s infinite;
}

.animate {
  animation: zoom 0.2s;
}

@keyframes zoom {
  from {
    transform: scale(0);
  }
  to {
    transform: scale(1);
  }
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
  padding: 2px 4px;
  border-radius: 5px;
  padding: 2px 8px;
  margin: 5px;
  text-align: start;
  background: rgb(172, 178, 238);
  overflow: auto;
}

#notificacoes {
  display: none;
  border-radius: 3px;
  overflow: auto;
  background: rgba(0, 0, 0, 0.4);
  border-radius: 10px;
  margin: 5px;
  max-height: 70vh;
  box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.3);
}

#imgPerfil {
  width: 8vw;
  border-radius: 100px;
  cursor: pointer;
}

::-webkit-scrollbar {
  width: 6px;
  background: transparent;
}

::-webkit-scrollbar-thumb {
  border-radius: 100px;
  background: rgba(0, 0, 0, 0.3);
}
</style>