<template>
  <div class="modal">
    <div class="modal-conteudo width-40 animate">
      <div class="cima">
        <big>Selecione uma foto</big>
        <span class="fechar" v-on:click="$emit('fechar')">&times;</span>
      </div>
      <div class="corpo">
        <div class="over">
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

<style scoped src="../../../css/modal.css"></style>
<style scoped>
.corpo {
  background: rebeccapurple;
  border-radius: 0 0 5px 5px;
  height: 60vh;
}

.cima {
  background: rgb(114, 51, 177);
  box-shadow: #00000040 0px 2px 5px;
}

big {
  font-size: 2em;
  color: white;
}

.imagem {
  width: 100px;
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

.selecionada {
  border: 4px solid white !important;
}
</style>