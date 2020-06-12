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
              <button class="botao" v-else-if="usuario.aceitou == 0" title="Pedido pendente">
                <!--pendente -->
                🕔
              </button>
              <button
                class="botao"
                v-else-if="usuario.aceitou == 1"
                :title="'Você ja é amigo de: ' + usuario.apelido"
              >👩🏻‍🤝‍🧑🏾</button>
              <!--aceitou -->
            </td>
          </tr>
        </table>
      </div>
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
        return this.usuarios.filter(usuario => exp.test(usuario.apelido));
      } else {
        return this.usuarios;
      }
    }
  },
  methods: {
    enviarSolicitacao(index) {
      var amigo = this.usuarios[index];

      this.$http
        .post("https://localhost:5001/api/amigos", {
          idAmigoA: this.$session.get("id"),
          idAmigoB: amigo.id,
          situacao: 0
        })
        .then(dados => {
          this.usuarios[index].situacao = 0;
        }, erro => {
          alert("algo deu errado");
        });
    },
    getUsuario(id, aceitou)
    { 
      this.$http
      .get("https://localhost:5001/api/usuarios/" + id)
      .then(dados => {
        return {
          id: dados.body.id,
          nome: dados.body.nome,
          apelido: dados.body.apelido,
          foto: dados.body.foto,
          aceitou: aceitou
        };
      }, erro => {
        alert("algo deu errado meta");
      });
    }
  },
   created(){
    var users = null;
      this.$http
      .get("https://localhost:5001/api/amigos")
      .then(response => {
        var ids = response.body;

        alert("pegou");

        for(var i = 0; i < this.amigos.length; i++)
        {
          if(ids[i].idAmigoA == this.$session.get('id'))
            this.amigos.push(this.methods.getUsuario(ids[i].idAmigoB, ids[i].situacao));
          else
            this.amigos.push(this.methods.getUsuario(ids[i].idAmigoA, ids[i].situacao));
        }
          alert("terminou");
      }, 
      response => {
        alert("cutcghbfh");
      });
  }
}

</script>

<style scoped src="../../../css/modal.css"></style>
<style scoped>
.corpo {
  background: rebeccapurple;
  height: 60vh;
}

.cima {
  background: #7233b1;
  box-shadow: #00000040 0px 2px 5px;
  color: white;
}

.baixo {
  box-shadow: 0px -2px 5px #00000040;
  background: #7233b1;
}

.baixo span {
  color: white;
  font-size: 1.3em;
  margin-right: 15px;
}

.usuario-item {
  animation: zoomOut 0.5s;
  /* background-color: rgb(111, 87, 170); */
  background: blueviolet;
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

.td-btn button {
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
  background: rgb(50, 24, 110);
  padding: 0;
}

::-webkit-scrollbar {
  width: 11px;
  background: rgb(43, 19, 99);
}

::-webkit-scrollbar-thumb {
  background: rgb(255, 255, 255);
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.5);
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

#busca input {
  border-radius: 5px;
  border: none;
  padding: 5px 10px;
  font-size: 1.2em;
}
</style>