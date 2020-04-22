<template>
  <div class="pag">
    <Menu />
    <Perfil />
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
      <div id="registros" v-for="dia in registrosData">
        <div class="umDia">
          <p class="data">Dia {{dia.data}}</p>
          <table cellspacin="0">
            <tr class="despesa" v-for="reg in dia.registros" v-if="reg.quantia < 0">
              <td class="tag">
                <img src="src/images/tag.png" alt class="tagImg" />
                {{reg.tag}}
              </td>
              <td class="nome">{{reg.nome}}</td>
              <td class="quantia">
                <img src="src/images/moeda.png" alt class="moedaImg" />
                {{reg.quantia}}
              </td>
            </tr>
            <tr class="receita" v-else>
              <td class="tag">
                <img src="src/images/tag.png" alt class="tagImg" />
                {{reg.tag}}
              </td>
              <td class="nome">{{reg.nome}}</td>
              <td class="quantia">
                <img src="src/images/moeda.png" alt class="moedaImg" />
                {{reg.quantia}}
              </td>
            </tr>
            <span></span>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/float-perfil/Float-Perfil.vue";
export default {
  components: {
    Menu,
    Perfil
  },
  data() {
    return {
      registros: [],
      registrosData: []
    };
  },
  methods: {},
  computed: {},
  mounted() {
    this.registros.push(
      {
        nome: "almoço",
        data: "12/02/2004",
        tag: "Alimentação",
        quantia: -85
      },
      {
        nome: "janta",
        data: "12/02/2004",
        tag: "Alimentação",
        quantia: -35
      },
      {
        nome: "cinema",
        data: "12/02/2004",
        tag: "Lazer",
        quantia: -40
      },
      {
        nome: "bico da padaria",
        data: "16/04/2020",
        tag: "Job",
        quantia: 150
      },
      {
        nome: "camiseta",
        data: "18/02/2004",
        tag: "Vestiario",
        quantia: -20
      },
      {
        nome: "sorvete",
        data: "18/02/2004",
        tag: "Alimentação",
        quantia: -15
      },
      {
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
        nome: reg[i].nome,
        tag: reg[i].tag,
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
  }
};
</script>

<style scoped>
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

.umDia td:first-child {
  border-left-width: 1px;
}

.nome {
  width: 65%;
}

.quantia {
  width: 15%;
}

.tag {
  width: 20%;
}

.data {
  margin: 0;
  font-size: 1.4em;
}

.despesa:hover {
  background-color: rgba(241, 69, 69, 0.85);
  cursor: pointer;
}

.receita:hover {
  background-color: rgba(10, 194, 10, 0.72);
  cursor: pointer;
}

.despesa {
  background-color: rgba(255, 104, 104, 0.75);
}

.receita {
  background-color: rgba(70, 228, 70, 0.75);
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
  width: 26px;
  margin-top: -1px;
  position: absolute;
  margin-left: -45px;
}

.tagImg {
  width: 25px;
  margin-top: 20px;
  margin-left: -35px;
  position: absolute;
}
</style>