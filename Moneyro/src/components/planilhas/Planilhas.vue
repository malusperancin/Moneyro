<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <Card v-if="verCard" :id="id" v-on:fecharCard="verCard = false" />
    <Topo />
    <div class="centro">
      <select id="filtro">
        <option value>Filtrar por...</option>
        <option value>Despesas</option>
        <option value>Receitas</option>
        <option value>Mês</option>
        <option value>Nenhum</option>
      </select>
      <input type="search" id="buscaNome" placeholder />
      <br />
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
    </div>
  </div>
</template>
<script>
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/float-perfil/Float-Perfil.vue";
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
  computed: {},
  mounted() {
    this.registros.push(
      {
        id: 1,
        nome: "almoço",
        data: "2004-12-02",
        tag: "Alimentação",
        quantia: -85,
        compartilhado: [
          { id: 1, nome: "Maria", foto: 6 },
          { id: 2, nome: "Giovanna", foto: 11 }
        ]
      },
      {
        id: 2,
        nome: "janta",
        data: "2004-12-02",
        tag: "Alimentação",
        quantia: -35
      },
      {
        id: 3,
        nome: "cinema",
        data: "12/02/2004",
        tag: "Lazer",
        quantia: -40
      },
      {
        id: 4,
        nome: "bico da padaria",
        data: "16/04/2020",
        tag: "Job",
        quantia: 150
      },
      {
        id: 5,
        nome: "camiseta",
        data: "18/02/2004",
        tag: "Vestiario",
        quantia: -20
      },
      {
        id: 6,
        nome: "titia vania presente",
        data: "18/02/2004",
        tag: "Presente",
        quantia: 50
      },
      {
        id: 7,
        nome: "arroz",
        data: "22/04/2020",
        tag: "Alimentação",
        quantia: -30
      }
    );

    var novos = [];
    var reg = this.registros;

    for (var i = 0; i < reg.length; i++) {
      novos.push({
        id: reg[i].id,
        nome: reg[i].nome,
        tag: reg[i].tag,
        quantia: reg[i].quantia,
        compartilhado: reg[i].compartilhado
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
}

tr {
  text-align: start;
}

.data {
  margin: 0;
  font-size: 1.4em;
}

.despesa:hover {
  background-color: rgba(241, 69, 69, 0.85);
  cursor: pointer;
  transform: scale(1.01);
}

.receita:hover {
  background-color: rgba(10, 194, 10, 0.72);
  cursor: pointer;
  transform: scale(1.01);
}

.despesa {
  background-color: rgba(255, 104, 104, 0.75);
  transition: transform 0.5s;
}

.receita {
  background-color: rgba(70, 228, 70, 0.75);
  transition: transform 0.5s;
}

.tag {
  width: 20%;
}

.nome {
  width: 30%;
}

.comp {
  width: 30%;
}

.quantia {
  width: 20%;
}

#buscaNome {
  border-radius: 5px;
  border: none;
  padding: 7px 14px;
  color: black;
  font-size: 1.2em;
  background: rgba(0, 0, 0, 0.082);
  width: 35%;
}

/*#buscaNome:focus {
   cor pra qndo clicar 
}*/

#filtro {
  border-radius: 5px;
  border: 0px;
  padding: 7px 14px;
  color: black;
  font-size: 1.2em;
  background: rgba(0, 0, 0, 0.082);
  width: 50%;
  margin-bottom: 20px;
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