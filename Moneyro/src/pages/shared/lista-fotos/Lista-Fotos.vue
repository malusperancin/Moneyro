<template>
  <div class="modal">
    <div class="modal-conteudo width-40 animate">
      <div class="cima">
        <big>Selecione uma foto</big>
        <span class="fechar" v-on:click="$emit('fechar')">&times;</span>
      </div>
      <div class="corpo">
        <img
          :src="'src/images/perfil'+ foto+ '.png'"
          v-for="(foto, i) in fotos"
          v-bind:key="i"
          :class="[{selecionada: foto == atual}, 'imagem']"
          :id="foto"
          v-on:click="enviar(foto)"
        />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["atual"],
  data() {
    return {
      fotos: [
        "1",
        "2",
        "3"
      ]
    };
  },
  methods: {
    enviar(foto) {
      this.$emit("receber", foto);
    },
    getFotos(){
      this.$http
        .get("https://localhost:5001/api/usuarios/fotos/"+this.$session.get("id"))
        .then(
          dados => {
            dados.body.map(d => this.fotos.push(d));
          }
        ); 
    }
  },
  created(){
    this.getFotos();
  },
  mounted() {
    // document.getElementById(this.atual).classList.add("selecionada");
  }
};
</script>

<style scoped src="../../../css/modal.css"></style>
<style scoped>
.corpo {
  background: rgba(0, 0, 0, 0.815);
  border-radius: 0 0 5px 5px;
  max-height: 70vh;
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  flex-wrap: wrap;
  overflow: hidden;
}

.cima {
  background: rgba(44, 44, 44, 0.705);
  box-shadow: #00000040 0px 2px 5px;
}

big {
  font-size: 2em;
  color: white;
  padding: 0 0 0 25px;
}

.imagem {
  width: 100px;
  max-height: 100px;
  max-width: 100px;
  margin: 10px;
  transition: transform 0.5s;
  box-shadow: 5px 5px 5px #00000040;
  border-radius: 15px;
  border: 4px solid #ffffff00;
}

.imagem:hover {
  transform: scale(1.05);
  cursor: pointer;
}

.selecionada {
  border: 4px solid white !important;
}
</style>