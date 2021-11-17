<!-- alunopic/src/components/shared/painel/Painel.vue -->
<template>
  <div class="painel animate">
    <div class="info">
      <div class="imagem">
        <img class="imgPerfil" :src="'../src/images/perfil' + foto + '.png'" />
      </div>
      <p class="nome">{{ nome }}</p>
      <p class="comp" v-on:click="$emit('verComp', id)">Compartilhados</p>
      <div class="deletar">
        <img class="imgDeletar" v-on:click="$emit('deletar')" src="src/images/remAmigo.png" />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["id", "nome", "foto"],
  data() {
    return {
      visivel: true
    };
  },
  methods: {}
  //background-image: linear-gradient(#e6b531, #ecb318); amarelo
  // background: rgba(99, 88, 160, 0.336); roxixo
};
</script>

<style scoped>
.animate {
  animation: zoom 0.2s;
}

@keyframes zoom {
  from {
    transform: scale(0);
  }
  to {
    transform: scale(1);
  }
}

.painel {
  padding: 15px;
  width: 13em;
  height: 18em;
  border-radius: 10px;
  background:linear-gradient(#e6b531, #ecb318);
  
  box-shadow: 5px 5px 5px #00000020;
  margin: 0 8px 8px 0;
  box-sizing: border-box;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.info {
  box-sizing: border-box;
  text-align: center;
  height: 100%;
}

.imgPerfil {
  width: 110px;
  border: none;
  border-radius: 40px;
  box-shadow: 5px 5px 10px #00000040;
}

.nome {
  font-weight: bold;
  font-size: 1.5em;
  word-wrap: break-word;
  margin: 0;
}

.comp {
  cursor: pointer;
  color: white;
  border-radius: 10px;
  padding: 5px;
  text-align: center;
  font-size: 1.1em;
  background: rgba(99, 88, 160, 0.45);
  border-bottom: 5px solid rgba(77, 63, 158, 0);
  margin: 10px 0px;
}

.comp:hover {
  background: rgb(106, 88, 212);
  border-bottom: 5px solid rgb(78, 63, 158);
}

.deletar {
  background: rgb(226, 52, 52);
  cursor: pointer;
  width: 45px;
  height: 45px;
  border-radius: 35px;
  position: absolute;
  margin-left: 4em;
}

.deletar:hover {
  background: red;
}

.imgDeletar {
  width: 20px;
  height: 20px;
  margin-top: 25%;
}
</style>