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
    <div id="notificacoes" class="" @mouseleave="fecharNotificacoes">
      <div class="notificacao animate" :class="[{'meta' : notif.tipo == 'meta'},{'solicitacao' : notif.tipo == 'solicitacao'}, {'despesa' : notif.tipo == 'despesa'}]" v-on:click="redirecionar(notif.tipo)" v-for="notif in notificacoes" v-bind:key="notif.id">
        <div class="icones"> 
          <img v-if="notif.tipo == 'meta:'" src="../../../images/metas.png">
          <img v-if="notif.tipo == 'despesa:'" src="../../../images/pontos.png">
          <img class="foto-idOrigem" :src="'src/images/perfil' + notif.foto + '.png'">
        </div>
        <div class="msg">
          <p class="texto">{{notif.mensagem}} </p>
        </div>
        <div class="amizade"  v-if="notif.tipo == 'solicitacao'">
            <button class="aceitar" v-on:click="aceitar(notif.idOrigem, notif.id)" title="Aceitar">
               ✔
              </button>
              <button class="negar" v-on:click="negar(notif.idOrigem, notif.id)" title="Negar">
               ❌
              </button>
        </div>
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
      notificacoes: []
    };
  },
  methods: {
    redirecionar(tipo)
    {
      if(tipo == 'solicitacao') 
        this.$router.push("/amigos");
      
      if(tipo == 'meta')
        this.$router.push("/metas")  

      if(tipo == 'despesa')
        this.$router.push("/planilhas");
    
    },
    aceitar(idOrigem,idNotif){
        this.$http
      .post("https://localhost:5001/api/amigos/amg", { 
        Id: 0,
        IdAmigoA: idOrigem,
        IdAmigoB: this.$session.get("id"),
        Aceitou: 1
      })
      .then(dados => {
        console.log(dados.body[0].id);
         this.$http
         .put("https://localhost:5001/api/amigos/" + dados.body[0].id, {
           id: dados.body[0].id,
           idAmigoA: idOrigem,
           idAmigoB: this.$session.get("id"),
           aceitou: 0
         })
         .then(dados => {

          this.$http
          .delete("https://localhost:5001/api/notificacoes/" + idNotif)
          .then(dados => { 
            this.getNotificacoes();
            this.$forceUpdate();
         }, erro => {
           console.log("Erro ao aceitar solicitação");
         });

         }, erro => {
           console.log("Erro ao aceitar solicitação");
         });
       
      },erro => {
        console.log("Erro ao pegar id dos amigos");
      });
    },
    negar(idOrigem,idNotif){
    this.$http
      .post("https://localhost:5001/api/amigos/amg", { 
        Id: 0,
        IdAmigoA: idOrigem,
        IdAmigoB: this.$session.get("id"),
        Aceitou: 1
      })
      .then(dados => {
        console.log(dados);
        this.$http
        .delete("https://localhost:5001/api/amigos/" + dados.body[0].id)
        .then(dados => {
          
          this.$http
          .delete("https://localhost:5001/api/notificacoes/" + idNotif).then(dados => { 
            this.getNotificacoes();
            this.$forceUpdate();

         }, erro => {
           console.log("Erro ao aceitar solicitação");
         });

        }, erro => {
          alert("algo deu negar");
        });
      },erro => {
        console.log("Erro ao pegar id dos amigos");
      });
    },
    abrirNotificacoes() 
    {
      for(var i = 0; i < this.notificacoes.length; i++)
      {
        this.notificacoes[i].visualizada = 1;

        this.$http
            .put("https://localhost:5001/api/notificacoes/" + this.notificacoes[i].id, this.notificacoes[i])
            .catch(erro => console.log("Erro ao atualizar as notif: " + erro.Text));
      }

      this.novas = false;
      document.getElementById("notificacoes").classList.toggle("mostrar");
    },
    fecharNotificacoes() 
    {
      document.getElementById("notificacoes").classList.toggle("mostrar");
    },
    getNotificacoes()
    {
      if(this.$session.exists())
        this.$http
            .get("https://localhost:5001/api/notificacoes/todas/" + this.$session.get("id"))
            .then(dados => {
              this.notificacoes = [];

              for(let i = 0; i < dados.body.length; i++)
                this.notificacoes.push({
                  id: dados.body[i][0],
                  idOrigem: dados.body[i][1],
                  idDestino:dados.body[i][2],
                  mensagem:dados.body[i][3],
                  visualizada:dados.body[i][4],
                  data:dados.body[i][5],
                  foto: dados.body[i][6],
                  tipo: dados.body[i][7]
                });
                
              this.recentes = this.notificacoes.filter(n => n.visualizada == 0);
            })
            .catch(erro => console.log("Erro ao pegar as notif: " + erro.Text));
    }
  },
  created(){
    this.$http
        .get("https://localhost:5001/api/notificacoes/todas/" + this.$session.get("id"))
        .then(dados => {
          for(let notificacao in dados.body)
            if((new Date().value() - notificacao.data.value()) >= 2592000000) // 1 mes em milissegundos
              this.$http
                  .delete("https://localhost:5001/api/notificacoes/" +  notificacao.id)
                  .catch(erro => console.log("Erro ao deletar as notificações: " + erro.Text));
        })
        .catch( erro => console.log("Erro ao pegar as notif: " + erro.bodyText));

    this.getNotificacoes();
    setInterval(this.getNotificacoes(), 15000); 
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
      this.novas = false;

      if(this.recentes[0]) 
        this.novas = true;
    },
  }
};
</script>

<style scoped>
.icones {
  padding: 3px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

#perfil {
  z-index: 99;
  position: fixed;
  top: 3%;
  right: 3%;
  text-align: end;
  width: 20pc;
  }

#imagem {
  position: relative;
  display: flex;
  justify-content: flex-end;
}
.aceitar {
  background: rgba(0, 0, 0, 0.5);
  box-shadow: #00000040 0px 2px 5px;
}

.negar {
  box-shadow: 0px -2px 5px #00000040;
  background: rgba(0, 0, 0, 0.5);
}

button {
  font-size: 1.2em;
  border: none;
  width: 100%;
  color: white;
  background-color: gray;
  cursor: pointer;
  font-weight: 1000;
  height: 50px;
  border-radius: 10px;
  text-align: center;
  margin: 2px 0px;
}
#conteudo {
  border: 1px solid rgba(0, 0, 0, 0.1);
  box-shadow: 5px 5px 10px rgb(0, 0, 0, 0.2);
  border-radius: 87px;
  display: flex;
  
}
.msg{
  text-align: center;
  margin: center;
}
.amizade{
  bottom: 0;
  margin: 0px 5px 0 0px;
}

.texto{
}
#notificacaoIcone {
  cursor: pointer;
  bottom: 0;
  position: absolute;
  border-radius: 87px;
  height: 30px;
  width: 30px;
  background: white;
  box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.3);
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

.mostrar{
  display: block !important;
}
.solicitacao{
    border-right: 10px solid rgb(68, 110, 42);

}
.notificacao {
  padding: 2px 4px;
  border-radius: 5px;
  padding: 2px 8px;
  margin: 5px;
  text-align: start;
  background: rgb(55, 55, 55);
  overflow: auto;
  color:whitesmoke;
  display: flex;
  flex-direction: row-reverse;
}

.notificacao img {
  float: left;
  margin: 3px;
  width:30px;
  height:30px;
}

.foto-idOrigem{
  border-radius: 50px;
}

.meta{
  border-right: 10px solid rgb(68, 42, 110);
}

.despesa{
 border-right: 10px solid rgb(112, 35, 31);
}

#notificacoes {
  display: none;
  border-radius: 1px;
  overflow: auto;
  background: rgba(0, 0, 0, 0.4);
  border-radius: 10px;
  margin: 5px;
  
  max-height: 70vh;
  box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.3);
}

#imgPerfil {
  width: 7pc;
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