<template>
 <div class="conteudo">
    <button v-on:click="$router.push('/contato')" class="botao" title="Contato">✉</button>
    <button v-on:click="$router.push('/sobre')" class="botao" title="Sobre nós">ℹ</button>
 </div>
</template>

<script>
export default {
  data() {
    return {};
  },
  methods: {

  },
  mounted() {
  }
};
</script>

<style scoped>
.conteudo{
    display:flex;
    grid-gap: 8px;
    flex-direction: horizontal;
    position: fixed;
    bottom: 25px;
    right: 100px;
    z-index: 9999999999999;
}

.botao {
  font-size: 1.6em;
  height: 50px;
  width: 50px;
  border-radius: 87px;
  background-color: var(--amarelo);
  border: none;
  outline: none;
  cursor: pointer;
  align-items: center;
  justify-content: center;
  display: flex;
  -webkit-animation: animatezoom 0.3s;
  animation: animatezoom 0.3s;
}

.botao:hover {
  background-color: rgba(235, 195, 24, 0.7);
  box-shadow: 2px 5px 15px black;
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
</style>