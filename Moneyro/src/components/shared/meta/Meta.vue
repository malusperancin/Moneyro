<template>
  <div :id="'meta'+id" class="meta">
    <div class="bolinha"></div>
    <div class="amigos" v-if="compartilhado">
      <div v-for="amigo in compartilhado" :title="amigo.nome" v-bind:key="amigo.nome">
        <img :src="'/images/'+ amigo.foto" alt />
      </div>
    </div>
    <div class="conteudo">
      <div class="porcentagem">
        <div :id="'id' + id" class="grafico"></div>
      </div>
      <div class="informacoes">
        <div class="quantidade">
          <span class="reais" v-if="porcentagem < 1">R${{atual}}</span>
          <span class="de">R${{objetivo}}</span>
        </div>
        <div class="data" :id="'data'+id">
          <img src="src/images/calendario.png" alt />
          <p>{{dataLimite}}</p>
        </div>
      </div>
    </div>
    <span>{{nome}}</span>
  </div>
</template>

<script>
export default {
  props: ["id", "nome", "objetivo", "atual", "dataLimite", "compartilhado"],
  data() {
    return {
      porcentagem: this.atual / this.objetivo,
      cor: String
    };
  },
  methods: {
    colorir() {
      var data = document.querySelector("#data" + this.id);
      var meta = document.querySelector("#meta" + this.id);
      data.style.backgroundColor = this.cor;
      meta.style.borderBottom = "10px solid " + this.cor;
    }
  },
  mounted() {
    this.cor = "#ECB318";
    if (this.compartilhado) this.cor = "#6360DB";
    if (this.objetivo == this.atual) this.cor = "#4DEA68";

    var ProgressBar = require("progressbar.js");
    var line = new ProgressBar.Line("#id" + this.id);

    var bar = new ProgressBar.Circle("#id" + this.id, {
      strokeWidth: 16,
      easing: "linear",
      duration: 1600,
      color: this.cor,
      trailColor: "#eee",
      trailWidth: 15,
      svgStyle: null
    });
    bar.animate(this.porcentagem); // Number from 0.0 to 1.0

    bar.setText(Math.round(this.porcentagem * 100) + "%");
    bar.text.style.fontSize = "30px";
    // // bar.text.style.color = "blue";
    // var data = document.querySelector(".data");
    // var meta = document.querySelector(".meta");
    // data.style.backgroundColor = this.cor;
    // meta.style.borderBottom = "10px solid " + this.cor;

    this.colorir();
  }
};
</script>

<style scoped>
.meta {
  width: 300px;
  height: 210px;
  padding: 15px;
  margin: 5px;
  background: white;
  border-radius: 10px;
  cursor: pointer;
  /* rgba(223, 114, 123, 0.836);
  border-bottom: 10px solid transparent; */
}

.meta:hover {
  transform: scale(1.05);
}

.grafico {
  margin-right: 5px;
}

.bolinha {
  width: 20px;
  height: 20px;
  border-radius: 87px;
  background: rgba(255, 217, 0, 0.567);
  border: 1px solid black;
  margin: 8px;
}
.amigos img {
  border-radius: 87px;
  border: 1px solid rgb(177, 174, 174);
  width: 20px;
}

.conteudo {
  display: flex;
  margin: 10px;
}

.porcentagem {
  margin-right: 10px;
  width: 120%;
  position: relative;
  text-align: center;
  vertical-align: middle;
}

.txtPorc {
  position: relative;
  font-size: 2em;
  text-align: center;
}

.num {
  position: absolute;
  background: rebeccapurple;
}

.informacoes {
  width: 100%;
}

.data {
  margin-top: 5px;
  display: inline-flex;
  padding: 5px 10px;
  /* background: rgb(223, 135, 143); */
  font-size: 1.1em;
  border-radius: 10px;
}

.data p {
  margin: auto 8px;
}

.data img {
  width: 30px;
  height: 30px;
}

.quantidade {
  text-align: center;
  font-weight: bolder;
}

.reais {
  font-size: 1.4em;
  font-weight: 550;
}

.de {
  margin: 0px;
  font-weight: 300;
  font-size: 1.8em;
}

span {
  margin-left: 3%;
  font-size: 1.65em;
  font-weight: 700;
}

.cor {
  border-bottom: 10px solid transparent;
}
/* #container {
  margin: 20px;
  width: 200px;
  height: 200px;
} */
</style>