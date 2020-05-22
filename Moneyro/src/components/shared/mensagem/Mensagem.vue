<template>
  <div class="mensagem">
    <div class="conteudo animate">
      <div class="titulo">
        <strong>{{msg.titulo}}</strong>
      </div>
      <div class="texto">{{msg.mensagem}}</div>
      <div class="botoes">
        <span
          class="botao"
          v-if="msg.ok.mostrar"
          v-on:click="$emit(msg.ok.evento)"
        >{{msg.ok.mensagem}}</span>
        <span class="botao" v-if="msg.cancelar" v-on:click="$emit('cancelar')">Cancelar</span>
        <span class="botao" v-if="msg.sair" v-on:click="$emit('sair')">Sair</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["msg"],
  data() {
    return {
      Mensagem: {
        mensagem: "",
        titulo: "",
        sair: false,
        cancelar: false,
        ok: false
      }
    };
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
  justify-content: center;
  align-items: center;
}

.conteudo {
  color: rgb(255, 255, 255);
  background: rgb(46, 48, 46);
  border-radius: 5px;
  height: fit-content;
}

.titulo {
  padding: 20px;
}

.texto {
  padding: 20px;
  white-space: pre-line;
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

.botoes {
  background: rgb(37, 33, 33);
  padding: 10px;
  display: flex;
  justify-content: space-between;
  border-bottom-left-radius: inherit;
  border-bottom-right-radius: inherit;
}

.botao {
  background: rgb(53, 71, 128);
  text-align: center;
  border-radius: 5px;
  padding: 5px 18px;
  cursor: pointer;
  box-sizing: border-box;
}

.botao:hover {
  opacity: 0.8;
}
</style>