<template>
  <div class="mensagem">
    <div class="conteudo animate">
      <div class="titulo">
        <strong>Nova Sala</strong>
      </div>
      <div class="texto">
      <p>
         Coloque o nome de sua nova sala
         </p>
        <input type="text" v-model="sala.nome"> </input>
      </div>
      <div class="botoes">
         <span
          class="botao"
          v-on:click="$emit('fechar')"
        >Cancelar</span>
        <span
          class="botao"
          v-on:click="$emit('salvar')"
        >Criar</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
    props: ["sala"],
    data() {
        return {};
    }
};
</script>

<style scoped>
p{
    padding: 0;
    display: block;
    margin-block-start: 0px;
    margin-block-end: 0px;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    margin: 0;
}

input{
    border: none;
    border-radius:5px;
    height: 30px;
    width: 100%;
    font-size: 20px;
}
.mensagem {
  position: fixed;
  background: rgba(0, 0, 0, 0.2);
  height: 100%;
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 99999999;
}

.conteudo {
  color: rgb(255, 255, 255);
  background: rgb(46, 48, 46);
  border-radius: 5px;
  height: fit-content;
  min-width: 250px;
}

.titulo {
  padding: 20px 20px 0 20px;
}

.texto {
  padding: 20px;
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