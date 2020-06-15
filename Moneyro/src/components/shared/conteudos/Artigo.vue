<template>
  <div class="conteudo">
    <a :href=link target="_blank">
      <h3 class="titulo">{{titulo}}</h3>
      <div class="imagem">
        <img class="foto" :src="foto" />
        <div class="assunto">{{assunto}}</div>
      </div>
    </a>
  </div>
</template>

<script>
export default {
  props: ["link", "titulo", "assunto", "foto"],
  data() {
    return {};
  }
};
</script>

<style scoped>
.conteudo {
  max-height: 360px;
  overflow: auto;
  padding: 15px;
  width: 335px;
  background: rgba(0, 0, 0, 0.1);
  border-radius: 5px;
  margin: 10px;
  box-shadow: 5px 10px 18px rgba(26, 0, 0, 0.2);
}

.conteudo:hover {
  transform: scale(1.02);
  background: rgba(126, 98, 98, 0.4);
}

a {
  text-decoration: none;
  color: rgb(0, 0, 0);
}

.foto {
  width: 335px;
  height: 200px;
  border-radius: 20px;
}

.imagem {
  position: relative;
  text-align: center;
}

.assunto {
  color: white;
  font-size: 1.2em;
  background: rgba(182, 1, 1, 0.651);
  width: fit-content;
  padding: 6px 16px;
  border-radius: 30px;
  position: absolute;
  bottom: 14px;
  left: 8px;
}

.assunto:hover {
  opacity: 0;
}

.titulo {
  margin: 5px;
  color:whitesmoke;
}
</style>