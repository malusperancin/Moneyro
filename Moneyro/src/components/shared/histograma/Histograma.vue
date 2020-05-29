<template>
  <div id="histograma">
    <div id="conteudo">
      <div id="fechar" v-on:click="$emit('fechar')">&times;</div>
      <div id="titulo">Avaliações</div>
      <div id="dados">
        <div id="geral">
          <div id="media">{{mediaAvaliacoes}}</div>
          <div id="estrelinhas">
            <div class="rating-group">
              <label
                aria-label="0.5 stars"
                class="rating__label rating__label--half"
                for="rating2-05"
              >
                <i class="rating__icon rating__icon--star fa fa-star-half"></i>
              </label>
              <input class="rating__input" name="rating2" id="rating2-05" value="0.5" type="radio" />
              <label aria-label="1 star" class="rating__label" for="rating2-10">
                <i class="rating__icon rating__icon--star fa fa-star"></i>
              </label>
              <input class="rating__input" name="rating2" id="rating2-10" value="1" type="radio" />
              <label
                aria-label="1.5 stars"
                class="rating__label rating__label--half"
                for="rating2-15"
              >
                <i class="rating__icon rating__icon--star fa fa-star-half"></i>
              </label>
              <input class="rating__input" name="rating2" id="rating2-15" value="1.5" type="radio" />
              <label aria-label="2 stars" class="rating__label" for="rating2-20">
                <i class="rating__icon rating__icon--star fa fa-star"></i>
              </label>
              <input class="rating__input" name="rating2" id="rating2-20" value="2" type="radio" />
              <label
                aria-label="2.5 stars"
                class="rating__label rating__label--half"
                for="rating2-25"
              >
                <i class="rating__icon rating__icon--star fa fa-star-half"></i>
              </label>
              <input class="rating__input" name="rating2" id="rating2-25" value="2.5" type="radio" />
              <label aria-label="3 stars" class="rating__label" for="rating2-30">
                <i class="rating__icon rating__icon--star fa fa-star"></i>
              </label>
              <input class="rating__input" name="rating2" id="rating2-30" value="3" type="radio" />
              <label
                aria-label="3.5 stars"
                class="rating__label rating__label--half"
                for="rating2-35"
              >
                <i class="rating__icon rating__icon--star fa fa-star-half"></i>
              </label>
              <input class="rating__input" name="rating2" id="rating2-35" value="3.5" type="radio" />
              <label aria-label="4 stars" class="rating__label" for="rating2-40">
                <i class="rating__icon rating__icon--star fa fa-star"></i>
              </label>
              <input class="rating__input" name="rating2" id="rating2-40" value="4" type="radio" />
              <label
                aria-label="4.5 stars"
                class="rating__label rating__label--half"
                for="rating2-45"
              >
                <i class="rating__icon rating__icon--star fa fa-star-half"></i>
              </label>
              <input class="rating__input" name="rating2" id="rating2-45" value="4.5" type="radio" />
              <label aria-label="5 stars" class="rating__label" for="rating2-50">
                <i class="rating__icon rating__icon--star fa fa-star"></i>
              </label>
              <input class="rating__input" name="rating2" id="rating2-50" value="5" type="radio" />
            </div>
          </div>
          <div id="total">Total: {{totalAvaliacoes}} avaliações</div>
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
      avaliacoes: [
        {
          usuario: "user",
          estrelas: 5,
          comentario: "achei bom"
        },
        {
          usuario: "user2",
          estrelas: 1,
          comentario: "ruim"
        },
        {
          usuario: "user3",
          estrelas: 3,
          comentario: "até que é bom"
        }
      ],
      estrelas: [{ qtd: 1 }, { qtd: 2 }, { qtd: 5 }, { qtd: 23 }, { qtd: 22 }],
      totalAvaliacoes: 63, // pegar do banco
      mediaAvaliacoes: null,
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
        ["5 ⭐", this.estrelas[4].qtd],
        ["4 ⭐", this.estrelas[3].qtd],
        ["3 ⭐", this.estrelas[2].qtd],
        ["2 ⭐", this.estrelas[1].qtd],
        ["1 ⭐", this.estrelas[0].qtd]
      ]);

      new google.visualization.BarChart(
        document.getElementById("google-bar")
      ).draw(this.data, this.options);
    },
    calcularMedia() {
      var soma = 0;
      for (var i = 0; i < this.estrelas.length; i++) {
        soma += this.estrelas[i].qtd * (i + 1);
      }
      return Math.round((soma / this.totalAvaliacoes) * 10) / 10;
    },
    exibirEstrelas() {
      var valor = this.arredondar(this.mediaAvaliacoes);
      var stars = document.getElementsByClassName("rating__input");
      for (var i = 0; i < stars.length; i++) {
        if (stars.item(i).value == valor) {
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
  mounted() {
    google.charts.load("current", { packages: ["corechart", "bar"] });
    google.charts.setOnLoadCallback(this.drawBar);

    this.mediaAvaliacoes = this.calcularMedia();
    this.exibirEstrelas();
  }
};
</script>

<style scoped>
#histograma {
  background-color: rgba(0, 0, 0, 0.2);
  position: fixed;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  width: 100%;
  z-index: 9999;
}

#conteudo {
  color: white;
  background: rgb(63, 28, 146);
  padding: 15px;
  animation: zoomIn 0.5s;
  border-radius: 5px;
}

@keyframes zoomIn {
  from {
    transform: scale(0.5);
  }
  to {
    transform: scale(1);
  }
}

#dados {
  display: flex;
  align-items: center;
  text-align: center;
}

#titulo {
  font-size: 2em;
  padding: 8px 16px;
  font-weight: bold;
  text-align: center;
  margin: auto;
}

#geral {
  padding: 10px;
  border-radius: 5px;
}

#media {
  font-size: 5em;
  margin-top: -35px;
}

#barras {
  background-color: rgba(0, 0, 0, 0.1);
  border-radius: 5px;
  margin: 5px;
}

#barras div {
  margin: 0px 0px 20px 20px;
}

#fechar {
  background: red;
  width: fit-content;
  float: right;
  padding: 5px 12px;
  border-radius: 87px;
  cursor: pointer;
}

/* use display:inline-flex to prevent whitespace issues. alternatively, you can put all the children of .rating-group on a single line */
.rating-group {
  display: inline-flex;
}

/* make hover effect work properly in IE */
.rating__icon {
  pointer-events: none;
}

/* hide radio inputs */
.rating__input {
  position: absolute !important;
  left: -9999px !important;
}

/* set icon padding and size */
.rating__label {
  /* if you change the left/right padding, update the margin-right property of .rating__label--half as well. */
  padding: 0 0.1em;
  font-size: 2rem;
}

/* add padding and positioning to half star labels */
.rating__label--half {
  padding-right: 0;
  margin-right: -0.6em;
  z-index: 2;
}

/* set default star color */
.rating__icon--star {
  color: orange;
}

/* set color of none icon when unchecked */
.rating__icon--none {
  color: #eee;
}

/* if none icon is checked, make it red */
.rating__input--none:checked + .rating__label .rating__icon--none {
  color: red;
}

/* if any input is checked, make its following siblings grey */
.rating__input:checked ~ .rating__label .rating__icon--star {
  color: #ddd;
}
</style>