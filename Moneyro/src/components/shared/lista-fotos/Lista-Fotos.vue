<template>
  <div class="fundo">
    <div class="fotos animate">
      <div class="imgFechar">
        <span class="fechar" v-on:click="$emit('fechar')">&times;</span>
      </div>
      <p>Selecione uma foto</p>
      <img
        :src="'src/images/perfil' + num + '.png'"
        v-for="num in qtdImagem"
        v-bind:key="num"
        class="imagem"
        :id="num"
        v-on:click="enviar(num)"
      />
    </div>
  </div>
</template>

<script>
export default {
  props: ["atual"],
  data() {
    return {
      qtdImagem: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    };
  },
  methods: {
    enviar(numero) {
      var div = document.getElementsByClassName("selecionada");

      div.item(0).classList.remove("selecionada");
      document.getElementById(numero).classList.add("selecionada");

      this.$emit("receber", numero);
    }
  },
  mounted() {
    document.getElementById(this.atual).classList.add("selecionada");
  }
};
</script>

<style scoped>
.fundo {
  background: rgba(0, 0, 0, 0.199);
  position: fixed;
  height: 100%;
  width: 100%;
  left: 0;
  top: 0;
  z-index: 5;
  display: grid;
}

.imagem {
  width: 120px;
  margin: 10px;
  transition: transform 0.5s;
  box-shadow: 5px 5px 5px #00000040;
  border-radius: 15px;
  border: 4px solid #ffffff00;
}

.imagem:hover {
  transform: scale(1.2);
  cursor: pointer;
}

.fotos {
  background: rgba(50, 51, 51, 0.856);
  padding: 10px;
  margin: auto;
  width: 38%;
  max-height: 550px;
  overflow: auto;
  box-shadow: 5px 5px 5px #00000040;
  border-radius: 8px;
}

.imgFechar {
  text-align: center;
  top: 2%;
  right: 2%;
  position: relative;
}

.fechar {
  padding: 0px 18px;
  font-size: 2.2em;
  border-radius: 87px;
  background: rgb(236, 65, 65);
  position: absolute;
  right: 0;
  top: 0;
  font-weight: bold;
}

.fechar:hover {
  background: red;
  cursor: pointer;
}

p {
  margin-left: 4%;
  font-size: 1.8em;
  color: white;
}

.selecionada {
  border: 4px solid white !important;
}

.animate {
  -webkit-animation: animatezoom 0.6s;
  animation: animatezoom 0.6s;
}

@-webkit-keyframes animatezoom {
  from {
    -webkit-transform: scale(0);
  }
  to {
    -webkit-transform: scale(1);
  }
}

@keyframes animatezoom {
  from {
    transform: scale(0);
  }
  to {
    transform: scale(1);
  }
}

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
  span.psw {
    display: block;
    float: none;
  }
  .cancelbtn {
    width: 100%;
  }
}
</style>