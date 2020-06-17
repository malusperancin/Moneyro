<template>
  <div id="perfil">
    <div id="imagem">
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
        v-for="notif in notificacoes"
        v-bind:key="notif.id"
      >
      {{notif.mensagem}}&nbsp; 
      <router-link v-if="getResposta(notif.mensagem) == 'solicitação'" to="/amigos">Responder</router-link>
      <router-link v-if="getResposta(notif.mensagem) == 'despesa:'" to="/planilhas">Ver</router-link>
      <router-link v-if="getResposta(notif.mensagem) == 'meta:'" to="/metas">Ver</router-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      novas: false,
      recentes: [],
      notificacoes: [],
      agora: new Date(),
    };
  },
  methods: {
    abrirNotificacoes() { 
      for(var i = 0; i < this.notificacoes.length; i++)
      {
        this.$http
            .put("https://localhost:5001/api/notificacoes/" + this.notificacoes[i].id, 
              {
                id:this.notificacoes[i].id,
                idOrigem: this.notificacoes[i].idOrigem,
                idDestino: this.notificacoes[i].idDestino,
                mensagem: this.notificacoes[i].mensagem,
                visualizada: 1,
                data: this.notificacoes[i].data
              }
            )
            .then().catch( erro => {
              alert("Erro ao atualizar as notif: " + erro.bodyText);
            });
      }
      this.novas = false;
      document.getElementById("notificacoes").style.display = "block";
    },
    fecharNotificacoes() {
      document.getElementById("notificacoes").style.display = "none";
    },
    getNotificacoes()
    {
      if(this.$session.exists())
        this.$http
        .get("https://localhost:5001/api/notificacoes/todas/" + this.$session.get("id"))
        .then(dados => {
            this.notificacoes = dados.body;
            this.recentes = this.notificacoes.filter(n => n.visualizada == 0);
        }).catch( erro => {
          console.log("Erro ao pegar as notif: " + erro.bodyText);
        });
    },
    getResposta(string)
    {
      return string.split(" ")[7];
    }
  },
  created(){
      this.$http
      .get("https://localhost:5001/api/notificacoes/todas/" + this.$session.get("id"))
      .then(dados => {
        for(var i; i < dados.body.length; i++)
          if((this.agora.value() - dados.body[i].data.value()) >= 2592000000) // 1 mes em milissegundos
            this.$http
                .delete("https://localhost:5001/api/notificacoes/" +  dados.body[i].id)
                .catch( erro => {
                  console.log("Erro ao deletar as notificações: " + erro.bodyText);
                });
      }).catch( erro => {
        console.log("Erro ao pegar as notif: " + erro.bodyText);
      });

  
    setInterval(this.getNotificacoes,30000); 
  },
  watch: {
    novas() {
      if (!this.novas)
        document.getElementById("notificacaoIcone").classList.remove("pulsar");
      else
         document.getElementById("notificacaoIcone").classList.add("pulsar");
    },
    recentes()
    {
      if(this.recentes[0])
        this.novas = true;
      else
        this.novas = false;
    },
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
  background: rgb(128, 128, 128);
  overflow: auto;
  color:whitesmoke;
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