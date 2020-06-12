<template>
  <div :id="'meta'+id" class="meta">
    <div class="cima">
      <div class="bolinha"></div>
      <div class="amigos" v-if="compartilhado">
        <div v-for="(amigo, i) in compartilhado" :title="amigo.nome" v-bind:key="i">
          <img :src="'src/images/perfil'+ amigo.foto + '.png'" alt />
        </div>
      </div>
    </div>
    <div class="conteudo">
      <div class="porcentagem">
        <div :id="'id' + id" class="grafico"></div>
      </div>
      <div class="informacoes">
        <div class="quantidade">
          <span class="reais" v-if="porcentagem < 1">R${{atual}}</span>
          <br>
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

<script scoped>
export default {
  props: ["id", "nome", "objetivo", "atual", "dataLimite", "compartilhado"],
  data() {
    return {
      porcentagem: this.atual / this.objetivo,
      cor: "#ECB318",
      bar: null
    };
  },
  methods: {
    colorir() {
      var data = document.querySelector("#data" + this.id);
      var meta = document.querySelector("#meta" + this.id);
      data.style.backgroundColor = this.cor;
      meta.style.borderBottom = "10px solid " + this.cor;
    },
    calcular() {
      this.porcentagem = this.atual / this.objetivo;

      if (this.porcentagem < 1) {
        this.bar.setText(Math.round(this.porcentagem * 100) + "%");
         if((this.porcentagem*10) >= 1)
          this.bar.text.style.fontSize = "30px";
        else
          this.bar.text.style.fontSize = "35px";
      } else {
        this.bar.setText("✔");
        this.cor = "#4DEA68";
        this.bar.text.style.fontSize = "30px";
        //this.bar.text.style.height = "100px";
        
        // this.bar.setColor = this.cor;
      }
      this.bar.animate(this.porcentagem);
    }
  },
  mounted() {
    if (this.compartilhado) this.cor = "#6360DB";
    if (this.objetivo == this.atual) this.cor = "#4DEA68";

    var ProgressBar = require("progressbar.js");
    var line = new ProgressBar.Line("#id" + this.id);

    this.bar = new ProgressBar.Circle("#id" + this.id, {
      strokeWidth: 15,
      easing: "linear",
      duration: 0,
      color: this.cor,
      trailColor: "#eee",
      trailWidth: 15,
      svgStyle: null
    });

    this.colorir();
    this.calcular();
  },
  watch: {
    atual() {
      this.calcular();
    }
  },
  created() {
    // alert(this.dataLimite);
  },
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
  display: flex;
  flex-direction: column;
  /* rgba(223, 114, 123, 0.836);
  border-bottom: 10px solid transparent; */
}

.meta:hover {
  transform: scale(1.05);
}

.grafico {
  margin-right: 5px;
  position: relative;
  height: 100%;
}

.cima {
  display: flex;
  padding: 0;
  align-items: center;
  position: relative;
}

.bolinha {
  width: 20px;
  height: 20px;
  border-radius: 87px;
  background: rgba(20, 20, 20, 0.747);
  border: 1px solid black;
  margin: 8px;
}

.amigos {
  display: flex;
  width: 100%;
  justify-content: flex-end;
  position: absolute;
}

.amigos div {
  margin-left: -15px;
  margin-bottom: 0;
}

.amigos img {
  border: 2px solid rgb(236, 228, 228);
  width: 30px;
  border-radius: 87px;
  margin-bottom: -10px;
  margin-top:-4px
}

.conteudo {
  display: flex;
  margin: 10px;
  position: relative;
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
  padding:0
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