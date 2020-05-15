<template>
  <div id="fundo">
    <div id="conteudo">
      <div id="topo">
        <div id="titulo">Adicionar Friends</div>
        <div id="fechar" v-on:click="$emit('fechar')">
          <span>&times;</span>
        </div>
      </div>
      <div id="busca">
        <input type="search" v-model="filtro" placeholder="Pesquise um usuário" />
      </div>
      <div id="lista">
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
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      filtro: "",
      usuarios: [
        {
          apelido: "12345678901234567890",
          foto: "8",
          nome: "NUMEROS TESTE",
          aceitou: -1
        },
        {
          apelido: "garupa papa✌ʕ•́ᴥ•̀ʔっ",
          foto: "6",
          nome: "malu diferente",
          aceitou: 1
        },
        {
          apelido: "cenizius😘😎",
          foto: "1",
          nome: "Cenicius lindo",
          aceitou: 0
        },
        { apelido: "drigo", foto: "3", nome: "Rodrigao do Grau", aceitou: -1 },
        { apelido: "elly", foto: "8", nome: "Elli gatona", aceitou: -1 },
        { apelido: "foen", foto: "5", nome: "Enzo Fanho", aceitou: -1 },
        { apelido: "malu", foto: "7", nome: "Não sei para esse", aceitou: -1 },
        { apelido: "grigo", foto: "9", nome: "Grilo isso ae", aceitou: 0 },
        { apelido: "glly", foto: "2", nome: "Sla cara cansei", aceitou: -1 },
        { apelido: "hoen", foto: "5", nome: "Catarrando", aceitou: -1 },
        { apelido: "iovana ಥ‿ಥ✌", foto: "10", nome: "Oiii", aceitou: -1 }, // apelido : varchar(14)
        {
          apelido: "jaru✌ʕ•́ᴥ•̀ʔっ",
          foto: "6",
          nome: "Jau aquela cidade",
          aceitou: -1
        },
        { apelido: "aovana ಥ‿ಥ✌", foto: "11", nome: "Jovana", aceitou: -1 }, // apelido : varchar(14)
        { apelido: "jenizius😘😎", foto: "3", nome: "Jeni", aceitou: -1 },
        {
          apelido: "jrigo",
          foto: "9",
          nome: "Nao tem nem como falar jreigo",
          aceitou: -1
        },
        { apelido: "klly", foto: "4", nome: "Kelly nguiça", aceitou: -1 },
        { apelido: "loen", foto: "4", nome: "Loen", aceitou: 0 },
        { apelido: "lenizius😘😎", foto: "8", nome: "COMUNISTA", aceitou: -1 },
        {
          apelido: "dmrigo",
          foto: "12",
          nome: "Nao tem nem como falar tbm",
          aceitou: -1
        },
        { apelido: "qually", foto: "2", nome: "Qualidade", aceitou: -1 },
        { apelido: "zoen", foto: "3", nome: "O unico q ta certo", aceitou: -1 }
      ]
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
      //ENVIA PRO BANCO COM amigo.id
    }
  }
};
</script>

<style scoped>
.usuario-item {
  /* background-image: linear-gradient(
    to right,
    rgb(64, 74, 163),
    rgb(115, 124, 206)
  ); */
  animation: zoomOut 0.5s;
  background-color: rgb(111, 87, 170);
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

#fundo {
  background-color: rgba(0, 0, 0, 0.2);
  position: fixed;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  width: 100%;
  z-index: 9999;
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
  border-radius: 10px;
}

table {
  border-collapse: separate;
  border-spacing: 0px 10px;
}

.td-img {
  padding: 5px;
  width: 25%;
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

#lista {
  margin-top: 15px;
}

::-webkit-scrollbar {
  width: 11px;
  background: rgb(43, 19, 99);
}

::-webkit-scrollbar-thumb {
  border-radius: 10px;
  background: rgb(255, 255, 255);
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.5);
}

.usuario-item {
  overflow: auto;
  border-radius: 10px;
}

tr td:first-child {
  border-top-left-radius: 10px;
  border-bottom-left-radius: 10px;
}

tr td:last-child {
  border-top-right-radius: 10px;
  border-bottom-right-radius: 10px;
}

#conteudo {
  height: 80vh;
  width: 30vw;
  color: white;
  background: rgb(73, 43, 143);
  padding: 15px;
  animation: zoomIn 0.5s;
  border-radius: 5px;
  overflow: auto;
}

#topo {
  display: flex;
}

#titulo {
  font-size: 1.5em;
  font-weight: bold;
  text-align: center;
  margin: auto;
}

#fechar {
  background: red;
  float: right;
  padding: 2px 14px;
  border-radius: 87px;
  cursor: pointer;
  font-size: 1.5em;
  color: black;
}

#busca {
  display: flex;
  justify-content: center;
  margin: 10px;
}

#busca input {
  border-radius: 5px;
  border: none;
  padding: 5px 10px;
  font-size: 1.2em;
}

@keyframes zoomIn {
  from {
    transform: scale(0.5);
  }
  to {
    transform: scale(1);
  }
}

@keyframes zoomOut {
  from {
    transform: scale(1.1);
  }
  to {
    transform: scale(1);
  }
}
</style>