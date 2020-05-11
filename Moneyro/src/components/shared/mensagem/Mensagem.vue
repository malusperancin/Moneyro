<template>
  <div class="mensagem">
    <div class="conteudo animate">
      <p>{{mensagem}}</p>
      <div class="botoes">
        <span class="botoes" id="cancelar" v-on:click="cancelar">Cancelar</span>
        <span class="botoes" id="ok" v-on:click="fechar">OK</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["mensagem"],
  data() {
    return {};
  }
};
</script>

<style scoped>
.mensagem {
  position: fixed;
  background: rgba(0, 0, 0, 0.2);
  height: 100%;
  width: 100%;
  display: flex;
  display: none;
  justify-content: center;
  align-items: center;
}

.conteudo {
  padding: 20px;
  color: rgb(255, 255, 255);
  background: rgba(0, 0, 0, 0.692);
  border-radius: 5px;
  height: fit-content;
}

.animate {
  -webkit-animation: animatezoom 0.6s;
  animation: animatezoom 0.6s;
}

#cancelar,
#ok {
  text-align: center;
  font-weight: bold;
}

#cancelar {
  background: rgba(255, 0, 0, 0.5);
}

#ok {
  background: rgb(53, 71, 128);
}

#ok:hover {
  background: rgb(0, 255, 0);
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

.botao {
  background: rgb(53, 71, 128);
  padding: 8px 16px;
  text-align: center;
  border-radius: 5px;
  cursor: pointer;
}

.botao:hover {
  opacity: 0.8;
}
</style>