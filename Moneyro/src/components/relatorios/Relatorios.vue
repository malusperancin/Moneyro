<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <div class="centro">
      <h1>
        Relatórios:
        <small>Aqui você encontra relatórios de acordo com seus gastos e receitas.</small>
      </h1>
      <div class="relatorio">
        <div id="ano">
          <p>Ano:</p>
          <select name="ano" id="selectAno" v-model="ano" @change="setAno">
            <option :value="ano" v-for="ano in anos" v-bind:key="ano">{{ano}}</option>
          </select>
        </div>
        <div class="geral">
          <div id="grafico_ano"></div>
        </div>
      </div>

      <div class="relatorio">
        <div id="mes">
          <p>Mês:</p>
          <select name="mes" id="selectMes" v-model="mes">
            <option :value="i+1" v-for="(mes, i) in meses" v-bind:key="i">{{mes}}</option>
          </select>
          <p id="pano">/{{ano}}</p>
        </div>
        <div class="geral">
          <div>
            <div id="grafico_mes"></div>
          </div>
        </div>
      </div>

      <div class="relatorio">
        <div id="ano">
          <p>Ano:</p>
          <select name="ano" id="selectAno" v-model="ano">
            <option :value="ano" v-for="ano in anos" v-bind:key="ano">{{ano}}</option>
          </select>
        </div>
        <div class="geral">
          <div id="grafico_gastos"></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/perfil/Perfil.vue";

export default {
  components: {
    Menu,
    Perfil
  },
  data() {
    return {
    /*IDEIS PRA MOSTRAR 
      RELAÇÃO ENTRE DESP RECEITA E GASTO
        \* POR ANO
         \* POR MES
      QUAIS SÃO AS TAGS MAIS USADAS
      LUGARES MAIS FREQUENTADOS
      DIAS MAIS ATIVOS
   */
      tags:[],
      receitas: [],
      despesas: [],
      registros: [],
      anos: ["2015", "2016", "2017", "2018", "2019", "2020"],
      ano: "2020",
      numMes: 1,
      mes: "janeiro",
      meses: [
        "janeiro",
        "fevereiro",
        "março",
        "abril",
        "maio",
        "junho",
        "julho",
        "agosto",
        "setembro",
        "outubro",
        "novembro",
        "dezembro"
      ],
      options: {
        color: "rgba(255, 255, 255, 1)",
        fontName: "Baloo Chettan 2",
        fontSize: 15,
        bold: true,
        italic: false,
        width: "100%",
        height: 400,
        backgroundColor: "",
        tooltip: { isHtml: true }
      },
      optionsPizza: {
        backgroundColor: "",
        width: "100%",
        fontSize: 16,
        height: 300
      },
      dataAno: null,
      dataMes: null,
      dataPizza: null
    };
  },
  methods: {
    drawAno() {
      this.dataAno = new google.visualization.DataTable();
      this.dataAno.addColumn("number", "Mês");
      this.dataAno.addColumn("number", "Receita");
      this.dataAno.addColumn("number", "Despesa");
      this.dataAno.addColumn("number", "Saldo");

      this.dataAno.addRows([
        [1, 37.8, 80.8, 41.8],
        [2, 30.9, 69.5, 32.4],
        [3, 25.4, 57, 25.7],
        [4, 11.7, 18.8, 10.5],
        [5, 11.9, 17.6, 10.4],
        [6, 8.8, 13.6, 7.7],
        [7, 7.6, 12.3, 9.6],
        [8, 12.3, 29.2, 10.6],
        [9, 16.9, 42.9, 14.8],
        [10, 12.8, 30.9, 11.6],
        [11, 5.3, 7.9, 4.7],
        [12, 6.6, 8.4, 5.2]
      ]);

      new google.charts.Line(document.getElementById("grafico_ano")).draw(
        this.dataAno,
        google.charts.Line.convertOptions(this.options)
      );
    },
    drawMes() {
      this.dataMes = new google.visualization.DataTable();
      this.dataMes.addColumn("number", "Mês");
      this.dataMes.addColumn("number", "Receita");
      this.dataMes.addColumn("number", "Despesa");
      this.dataMes.addColumn("number", "Saldo");

      this.dataMes.addRows([
        [1, 1, -30, 41.8],
        [2, 30.9, 69.5, 32.4],
        [3, 0, 57, 25.7],
        [4, 11.7, 18.8, 10.5],
        [5, 11.9, 17.6, 10.4],
        [6, 8.8, 13.6, 7.7],
        [7, 7.6, 0, 9.6],
        [8, 12.3, 29.2, 10.6],
        [9, 16.9, 42.9, 14.8],
        [10, 12.8, 30.9, 11.6],
        [11, 5.3, 7.9, 4.7],
        [12, 6.6, 8.4, 5.2],
        [13, 4.8, 6.3, 3.6],
        [14, 4.2, 6.2, 3.4],
        [15, 30.9, 69.5, 32.4],
        [16, 25.4, 57, 25.7],
        [17, 11.7, 0, 10.5],
        [18, 11.9, 17.6, 10.4],
        [19, 0, 13.6, 7.7],
        [20, 7.6, 12.3, 9.6],
        [21, 12.3, 29.2, 10.6],
        [22, 16.9, 42.9, 14.8],
        [23, 12.8, 0, 11.6],
        [24, 5.3, 7.9, 4.7],
        [25, 6.6, 8.4, 5.2],
        [26, 4.8, 6.3, 3.6],
        [27, 0, 6.2, 3.4],
        [28, 30, 6.2, 24],
        [29, 4.2, 0, 3.4],
        [30, 4.2, 52, 3.4]
      ]);

      new google.charts.Line(document.getElementById("grafico_mes")).draw(
        this.dataMes,
        google.charts.Line.convertOptions(this.options)
      );
    },
    drawPizza() {
      this.dataPizza = google.visualization.arrayToDataTable([
        ["Gastos", "Quantidade"],
        ["Alimentação", 11],
        ["Vestuario", 2],
        ["Lazer", 2],
        ["Higiene", 2],
        ["Transporte", 6]
      ]);

      new google.visualization.PieChart(
        document.getElementById("grafico_gastos")
      ).draw(this.dataPizza, this.optionsPizza);
    },
    getRegistros(){
      this.$http
      .get("https://localhost:5001/api/registros/todos/"+this.$session.get("id"))
      .then(dados => {
        dados.body.map(reg => {
          if(reg.quantia > 0)
            this.receitas.push({
              data: new Date(reg.data),
              nome: reg.nome,
              idTag: this.tags[reg.id-1],
              lugar: reg.lugar,
              quantia: reg.quantia,
            });
          else
            this.despesas.push({
              data: new Date(reg.data),
              nome: reg.nome,
              idTag: this.tags[reg.id-1],
              lugar: reg.lugar,
              quantia: reg.quantia,
            });

           this.registros.push({
              data: new Date(reg.data),
              nome: reg.nome,
              idTag: this.tags[reg.id-1],
              lugar: reg.lugar,
              quantia: reg.quantia,
            });
        });
      }, erro => {
        console.log("Erro ao recuperar tags: " + erro.body);
      });
    },
    setAno()
    { 
      console.log(this.registros.filter(reg => {
        reg.data.getFullYear() != this.ano
      }));
    }
  },
  mounted() {
    google.charts.load("current", { packages: ["line", "corechart"] });
    google.charts.setOnLoadCallback(this.drawAno);
    google.charts.setOnLoadCallback(this.drawMes);
    google.charts.setOnLoadCallback(this.drawPizza);
  },
  watch: {},
  beforeCreate() {
    if (!this.$session.exists()) {
      this.$router.push('/')
    }
  },
 created(){
   document.title = "Relatórios";

   this.$http
    .get("https://localhost:5001/api/tags")
    .then(dados => {
      dados.body.map(tag => {
        this.tags.push({
          id: tag.id,
          nome: tag.nome
        })
      });

      this.getRegistros();
    }, erro => {
      console.log("Erro ao recuperar tags: " + erro.body);
    });
 }
};
</script>

<style scoped>
.relatorio {
  padding: 10px;
  margin-bottom: 15px;
}

.geral {
  /* background: rgb(11, 83, 148); */
  background: white;
  border-radius: 10px;
  margin: 5px;
  padding: 50px;
}

.relatorio {
  padding: 10px;
  margin-bottom: 15px;
}

.geral {
  /* background: rgb(11, 83, 148); */
  background: white;
  border-radius: 10px;
  margin: 5px;
  padding: 50px;
}

#mes,
#ano {
  display: inline-flex;
  margin: 5px;
  width: 10%;
}

select {
  background: rgba(0, 0, 0, 0.1);
  border-radius: 5px;
  padding: 4px 8px;
  color: black;
  font-size: 1.5em;
  border: none;
}

p {
  margin: auto 10px;
  font-size: 2em;
}

#mes {
  width: 5em;
}

#pano {
  font-size: 1.6em;
}
</style>
