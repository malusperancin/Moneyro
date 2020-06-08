<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <Card v-if="verCard" :id="id" v-on:fecharCard="verCard = false" />
    <Topo />
    <div class="centro">
      <div class="filtros">
        <select id="filtro">
          <option value>Filtrar por...</option>
          <option value>Despesas</option>
          <option value>Receitas</option>
          <option value>Mês</option>
          <option value>Nenhum</option>
        </select>
        <input type="search" id="buscaNome" placeholder />
      </div>
      <div id="registros" v-for="(dia, i) in registrosData" :key="i">
        <div class="umDia">
          <p class="data">Dia {{dia.data}}</p>
          <table cellspacin="0">
            <tr
              v-for="(reg, j) in dia.registros"
              :key="j"
              :class="[{'despesa' : reg.quantia < 0}, {'receita' : reg.quantia > 0}]"
              v-on:click="abrirCard(reg.id)"
            >
              <td class="tag">
                <img src="src/images/tag.png" alt class="tagImg" />
                {{reg.tag}}
              </td>
              <td class="nome">{{reg.nome}}</td>
              <td class="comp">
                <div class="amigos" v-if="reg.compartilhado">
                  <div v-for="(amigo, i) in reg.compartilhado" :title="amigo.nome" v-bind:key="i">
                    <img :src="'src/images/perfil'+ amigo.foto + '.png'" alt />
                  </div>
                </div>
              </td>
              <td class="quantia">
                <img src="src/images/moeda.png" alt class="moedaImg" />
                {{reg.quantia}}
              </td>
            </tr>
          </table>
        </div>
      </div>
      <div>

      </div>
    </div>
  </div>
</template>
<script>
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/perfil/Perfil.vue";
import Card from "../shared/cards/Card.vue";
import Topo from "../shared/voltar-topo/Voltar-Topo.vue";

export default {
  components: {
    Menu,
    Perfil,
    Card,
    Topo
  },
  data() {
    return {
      registros: [],
      registrosData: [],
      verCard: false,
      id: null
    };
  },
  methods: {
    abrirCard(id) {
      this.id = id;
      this.verCard = true;
    }
  },
  created(){
    this.$http
        .get("https://localhost:5001/api/registros")
        .then(dados => {
          this.registros = dados.body;
        }, erro => {
          alert("algo deu errado");
        });
  },
  mounted() {

    var novos = [];
    var reg = this.registros;
        
      for (var i = 0; i < reg.length; i++) {
      novos.push({
        id: reg[i].id,
        nome: reg[i].nome,
        tag: reg[i].idTag,
        quantia: reg[i].quantia
      });

      if (i + 1 == reg.length) {
        this.registrosData.push({
          data: reg[i].data,
          registros: novos
        });
        break;
      }

      if (reg[i].data != reg[i + 1].data) {
        this.registrosData.push({
          data: reg[i].data,
          registros: novos
        });
        novos = [];
      }
    }
  },
  beforeCreate() {
    if (!this.$session.exists()) {
      this.$router.push('/')
    }
  },
  created(){
    document.title = "Planilhas";
  }
};
</script>

<style scoped>
.amigos {
  display: flex;
  width: 100%;
  justify-content: flex-end;
}

.amigos div {
  margin-left: -15px;
  margin-bottom: 0;
}

.amigos img {
  border: 3px solid rgb(236, 228, 228);
  width: 30px;
  border-radius: 87px;
  margin-bottom: -5px;
}

.umDia table {
  width: 100%;
  box-sizing: border-box;
  border-collapse: separate;
  border-spacing: 0px 10px;
}

.umDia td {
  padding: 5px 15px;
  font-size: 1.25em;
  color: rgb(216, 201, 201);
}

tr {
  text-align: start;
}

.data {
  margin: 0;
  font-size: 1.4em;
  color: rgba(255, 255, 255, 0.8);
}

.despesa:hover {
  background-color: rgb(184, 31, 31);
  cursor: pointer;
  transform: scale(1.01);
}

.receita:hover {
  background-color: rgb(19, 134, 19);
  cursor: pointer;
  transform: scale(1.01);
}

.despesa {
  background-color: rgba(170, 36, 36, 0.8);
  transition: transform 0.5s;
}

.receita {
  background-color: rgba(19, 129, 19, 0.8);
  transition: transform 0.5s;
}

.tag {
  width: 25%;
}

.nome {
  width: 30%;
}

.comp {
  width: 25%;
}

.quantia {
  width: 20%;
}

.filtros{
  display: flex;
  justify-content: space-between;
}

#buscaNome {
  border-radius: 5px;
  border: none;
  padding: 7px 14px;
  box-sizing: border-box;
  font-size: 1.2em;
  width: 40%;
  color: rgba(255, 255, 255, 0.7);
  background: rgba(255, 255, 255, 0.078);
}

/*#buscaNome:focus {
   cor pra qndo clicar 
}*/

#filtro {
  border-radius: 5px;
  border: 0px;
  padding: 7px 14px;
  color: rgba(255, 255, 255, 0.7);
  font-size: 1.2em;
  background: rgba(255, 255, 255, 0.08);
  width: 50%;
}

.moedaImg {
  width: 25px;
  float: left;
  margin: 3px;
}

.tagImg {
  width: 25px;
  float: left;
  margin: 3px;
}
</style>