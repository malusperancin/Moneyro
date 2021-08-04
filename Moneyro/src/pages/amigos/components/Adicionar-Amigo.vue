<template>
  <div class="modal">
    <div class="modal-conteudo width-35 animate">
      <div class="cima">
        <div id="titulo">Adicionar Friends</div>
        <div class="fechar" v-on:click="$emit('fechar')">&times;</div>
      </div>
      <div class="corpo">
        <table cellspacing="0">
          <tr class="usuario-item" v-for="(usuario, i) of filtraNome" :key="i">
            <td class="td-img">
              <div>
                <img :src="'../../src/images/perfil' + usuario.foto + '.png'" />
              </div>
            </td>
            <td class="td-info">
              <span class="nome">{{usuario.nome}}</span>
              <br />
              <span class="apelido">@{{usuario.apelido}}</span>
            </td>
            <td class="td-btn">
              <button
                class="botao"
                v-on:click="enviarSolicitacao(i)"
                v-if="usuario.aceitou == -1"
                style="font-size: 2em;"
                title="Enviar solicitação"
              >✉️</button>
              <button class="botao" v-if="usuario.aceitou == 1" title="Pedido pendente">
                🕔
              </button>
              <button class="aceitar" v-on:click="aceitar(i)" v-if="usuario.aceitou == 2" title="Aceitar">
               ✔
              </button>
              <button class="negar" v-on:click="negar(i)" v-if="usuario.aceitou == 2" title="Negar">
               ❌
              </button>
              <button
                class="botao"
                v-if="usuario.aceitou == 0"
                :title="'Você ja é amigo de: ' + usuario.apelido"
              >👩🏻‍🤝‍🧑🏾</button>
            </td>
          </tr>
        </table>
      </div>
      <span class="linha"></span>
      <div class="baixo">
        <span>Busque um amigo:</span>
        <div id="busca">
          <input type="search" v-model="filtro" placeholder="Pesquisar" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      filtro: "",
      usuarios: [],
      amigos: []
    };
  },
  computed: {
    filtraNome() {
      if (this.filtro) {
        let exp = new RegExp(this.filtro.trim(), "i");
        return this.usuarios.filter(usuario => exp.test(usuario.apelido) || exp.test(usuario.nome));
      } else {
        return this.usuarios;
      }
    }
  },
  methods: {
    enviarSolicitacao(index) {
      var amigo = this.usuarios[index];

      this.enviarNotificacoes(amigo);

      this.$http
      .post("https://localhost:5001/api/amigos", {
        idAmigoA: this.$session.get("id"),
        idAmigoB: amigo.id,
        aceitou: 1,
        tipo: 'solicitacao'
      })
      .then(dados => {
        this.usuarios[index].aceitou = 1;
      }, erro => {
        console.log("Erro ao adicionar amigo");
      });
    },
    aceitar(index)
    {
      var amigo = this.usuarios[index];

      this.$http
      .post("https://localhost:5001/api/amigos/amg", { 
        Id: 0,
        IdAmigoA: amigo.id,
        IdAmigoB: this.$session.get("id"),
        Aceitou: 1,
        Tipo: 'solicitacao'
      })
      .then(dados => {
        console.log(dados.body[0].id);
         this.$http
         .put("https://localhost:5001/api/amigos/" + dados.body[0].id, {
           id: dados.body[0].id,
           idAmigoA: amigo.id,
           idAmigoB: this.$session.get("id"),
           aceitou: 0,
           tipo: 'solicitacao'
         })
         .then(dados => {
           this.usuarios[index].aceitou = 0;
           this.apagarNotificacao(amigo.id);
           this.$emit('atualizar');
         }, erro => {
           console.log("Erro ao aceitar solicitação");
         });
       
      },erro => {
        console.log("Erro ao pegar id dos amigos");
      });
    },
    negar(index)
    {
      var amigo = this.usuarios[index];

      this.$http
      .post("https://localhost:5001/api/amigos/amg", { 
        Id: 0,
        IdAmigoA: amigo.id,
        IdAmigoB: this.$session.get("id"),
        Aceitou: 1,
        Tipo: 'solicitacao'
      })
      .then(dados => {
        this.$http
        .delete("https://localhost:5001/api/amigos/" + dados.body[0].id)
        .then(dados => {
          this.usuarios[index].aceitou = -1;
          this.apagarNotificacao(amigo.id);
        }, erro => {
          alert("algo deu negar");
        });
      },erro => {
        console.log("Erro ao pegar id dos amigos");
      });
    },
    getUsuarios(){  
      this.$http
      .get("https://localhost:5001/api/usuarios")
      .then(response => {
        this.usuarios = response.body;
        this.usuarios = this.usuarios.filter(u => u.id != this.$session.get('id'))
                                     .map(this.setUsuario);
      }, 
      response => {
        console.log("Erro ao pergar usuarios");
      });
    },
    apagarNotificacao(idOrigem){
      this.$http
        .get("https://localhost:5001/api/notificacoes/especifica/amizade/"+ idOrigem + "/"+this.$session.get("id"))
        .then(dados => {
        }, erro => {
          alert("algo deu negar");
        });
    },
    setUsuario(usuario){
      usuario.aceitou = -1;

      this.amigos.map(a => {
        if(a.idAmigoA == usuario.id && a.aceitou == 1)
          usuario.aceitou = 2;

        if(a.idAmigoB == usuario.id && a.aceitou == 1)
          usuario.aceitou = 1;

        if(a.aceitou == 0 && (a.idAmigoB == usuario.id || a.idAmigoA == usuario.id))
          usuario.aceitou = 0;
      });

      return({
        id: usuario.id,
        nome: usuario.nome,
        apelido: usuario.apelido,
        foto: usuario.foto,
        aceitou: usuario.aceitou
      });
    },
    enviarNotificacoes(amigo){
        this.$http
        .post("https://localhost:5001/api/notificacoes", {
          idOrigem: this.$session.get("id"),
          idDestino: amigo.id,
          mensagem: this.$session.get("nome") + " te enviou um solicitação de amizade. ",
          visualizada: 0,
          tipo: 'solicitacao',
          data: new Date(),
        })
        .then(dados => {
        }).catch( erro => {
          alert("Erro ao enviar as notificações: " + erro.bodyText);
        });
    }
  },
  created(){
    this.$http
        .get("https://localhost:5001/api/amigos/todos/"+this.$session.get("id"))
        .then(response => {
          this.amigos = response.body.sort(function(a, b) {
            if (a.aceitou > b.aceitou) 
              return 1;

            if (a.aceitou < b.aceitou)
              return -1;

            return 0;
          });
          this.getUsuarios();
        })
        .catch(response => alert("cu"));
  },
  mounted() {      
  },
}

</script>

<style scoped src="../../../css/modal.css"></style>
<style scoped>
.corpo {
  background: rgb(40, 39, 41);
  height: 60vh;
}
.cima{
  background-color:rgba(29, 29, 29, 0.9);
  color:white;
}
.baixo{
  background-color:rgb(40, 39, 41)
}
.aceitar {
  background: rgba(0, 0, 0, 0.959);
  box-shadow: #00000040 0px 2px 5px;
}

.negar {
  box-shadow: 0px -2px 5px #00000040;
  background: rgba(0, 0, 0, 0.959);
}

.baixo span {
  color: white;
  font-size: 1.3em;
  margin-right: 15px;
}

.usuario-item {
  animation: zoomOut 0.5s;
  /* background-color: rgb(111, 87, 170); */
  background: rgba(116, 117, 116, 0.836);
}

.apelido {
  color: rgb(70, 66, 66);
  font-size: 0.7em;
  margin: 0;
}

.td-info span {
  margin-bottom: -5px;
  padding-bottom: -5px;
}

.botao {
  font-size: 1.5em;
  border: none;
  width: 100%;
  color: white;
  background-color: transparent;
  cursor: pointer;
  font-weight: 1000;
  height: 90px;
  padding: 20px;
}

.aceitar, .negar{
  font-size: 1.5em;
  border: none;
  width: 100%;
  color: white;
  background-color: transparent;
  cursor: pointer;
  height: 45px;
  padding: 0 20px;
}


.td-img img {
  width: 70px;
  margin: 5px 0 0 5px;
  border-radius: 4px;
}

table {
  border-collapse: separate;
  border-spacing: 0px 10px;
}

.td-img {
  padding: 5px;
  width: 25px;
  text-align: center;
  align-items: center;
}

.td-info {
  color: black;
  font-size: 1.4em;
  padding-left: 10px;
  padding-bottom: 8px;
  padding-top: 8px;
  width: 90%;
}

td {
  padding: 15px;
  align-items: center;
}

.td-btn {
  background: rgb(70, 69, 67);
  padding: 0;
}

::-webkit-scrollbar {
  width: 11px;
  background: rgb(0, 0, 0);
}

::-webkit-scrollbar-thumb {
  background: rgb(255, 255, 255);
  box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.5);
}

.usuario-item {
  overflow: auto;
  border-radius: 4px;
}

tr td:first-child {
  border-top-left-radius: 4px;
  border-bottom-left-radius: 4px;
}

tr td:last-child {
  border-top-right-radius: 4px;
  border-bottom-right-radius: 4px;
}

#titulo {
  font-size: 1.5em;
  font-weight: bold;
  text-align: center;
  margin: auto;
}

.linha {
  background: rgb(238, 177, 11);
  height: 3px;
  width: 90%;
  margin: 0;
}

#busca{
    background-color: rgb(40, 39, 41);
    color: whitesmoke;
}

#busca input {
  border-radius: 5px;
  border: none;
  padding: 5px 10px;
  font-size: 1.2em;
  color: whitesmoke; 
}
</style>