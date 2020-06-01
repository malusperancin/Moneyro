<template>
  <div class="modal">
    <div class="modal-conteudo animate">
      <div class="cima">
        <div id="titulo">Avaliações</div>
        <div class="fechar" v-on:click="$emit('fechar')">&times;</div>
      </div>
      <div class="corpo">
        <div id="geral">
          <div id="media">{{mediaAvaliacoes}}</div>
          <div id="estrelinhas">
            <fieldset class="rating rating-exib" >
              <input type="radio" id="5" name="rating" value="5" /><label class = "full" for="star5" title="Bem Bem bon - 5 estrelas"></label>
              <input type="radio" id="4.5" name="rating" value="4 and a half" /><label class="half" for="star4half" title="Ben bon - 4.5 estrelas"></label>
              <input type="radio" id="4" name="rating" value="4" /><label class = "full" for="star4" title="Ben bon - 4 estrelas"></label>
              <input type="radio" id="3.5" name="rating" value="3 and a half" /><label class="half" for="star3half" title="Meh - 3.5 estrelas"></label>
              <input type="radio" id="3" name="rating" value="3" /><label class = "full" for="star3" title="Meh - 3 stars"></label>
              <input type="radio" id="2.5" name="rating" value="2 and a half" /><label class="half" for="star2half" title="Mei ruinzin - 2.5 estrelas"></label>
              <input type="radio" id="2" name="rating" value="2" /><label class = "full" for="star2" title="Mei ruinzin - 2 estrelas"></label>
              <input type="radio" id="1.5" name="rating" value="1 and a half" /><label class="half" for="star1half" title="Muito ruim mds - 1.5 estrela"></label>
              <input type="radio" id="1" name="rating" value="1" /><label class = "full" for="star1" title="Muito ruim mds - 1 estrela"></label>
              <input type="radio" id="0.5" name="rating" value="half" /><label class="half" for="starhalf" title="Simplesmente um horrô - 0.5 estrela"></label>
            </fieldset>
          </div>
          <div id="total">Total: {{avaliacoes.length}} avaliações</div>
        </div>
        <div id="barras">
          <div id="google-bar"></div>
        </div>
        </div>
    </div>
  </div>
</template>

<script scoped>
export default {
  data() {
    return {
      avaliacoes: [],
      mediaAvaliacoes: null,
      estrelas: [
        0, 0, 0, 0, 0
      ],
      options: {
        fontSize: 15,
        legend: { position: "none" },
        bold: true,
        italic: false,
        width: "100%",
        backgroundColor: "",
        // chartArea: { width: "50%" },
        vAxis: {
          textColor: "white"
        },
        hAxis: {
          titleTextStyle: { color: "white", italic: false },
          title: "Número de avaliações",
          minValue: 0,
          textColor: "white"
        }
      },
      data: null
    };
  },
  methods: {
    drawBar() {
      this.data = google.visualization.arrayToDataTable([
        ["", ""],
        ["5 ⭐", this.estrelas[4]],
        ["4 ⭐", this.estrelas[3]],
        ["3 ⭐", this.estrelas[2]],
        ["2 ⭐", this.estrelas[1]],
        ["1 ⭐", this.estrelas[0]]
      ]);

      new google.visualization.BarChart(
        document.getElementById("google-bar")
      ).draw(this.data, this.options);
    },
    calcularMedia() {
      var soma = 0;
      for (var i = 0; i < this.avaliacoes.length; i++) {
        soma += this.avaliacoes[i].qtdEstrelas;
        this.estrelas[this.avaliacoes[i].qtdEstrelas-1]++;
      }
      
      return Math.round((soma / this.avaliacoes.length) * 10) / 10;
    },
    exibirEstrelas() {
      var valor = this.arredondar(this.mediaAvaliacoes);
      var stars = document.getElementsByName("rating");
      for (var i = 0; i < stars.length; i++) {
        if (stars.item(i).id == valor) 
        {
          stars.item(i).checked = true;
        }
     }   
    },
    arredondar(nota) {
      var casaDecimal = (nota * 10) % 10; //dica do Danilo ^^
      if (casaDecimal >= 3 && casaDecimal <= 7) {
        nota = nota - casaDecimal / 10 + 0.5;
      } else {
        nota = Math.round(nota);
      }
      return nota;
    }
  },
  created() {
    this.$http
      .get("https://localhost:5001/api/avaliacoes")
      .then(response => {
        this.avaliacoes = response.body;
        this.mediaAvaliacoes = this.calcularMedia();
        this.exibirEstrelas();
        
    google.charts.load("current", { packages: ["corechart", "bar"] });
    google.charts.setOnLoadCallback(this.drawBar);

      }, response =>{
        alert("deu ruim");
      });
  },
};
</script>

<style scoped src="../../../css/estrelas.css"></style>
<style scoped src="../../../css/modal.css"></style>
<style scoped>
.modal-conteudo{
  background-color:rgb(46, 48, 46);
}

.cima{
 background-color:rgb(25, 26, 25);
}

.corpo{
  display: flex;
}

#titulo {
  font-size: 2em;
  font-weight: bold;
  text-align: center;
  margin: auto;
  color:rgba(255, 255, 255, 0.849);
}

#geral {
  padding: 10px;
  border-radius: 5px;
  color:rgba(255, 255, 255, 0.849);
  text-align:center;
  margin:auto;
}

#media {
  font-size: 5em;
  margin-top: -35px;
  color:rgba(255, 255, 255, 0.849);
}

#barras {
  background-color: rgba(0, 0, 0, 0.1);
  border-radius: 5px;
  margin: 5px;
}

#barras div {
  margin: 0px 0px 20px 20px;
}
</style>