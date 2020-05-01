<template>
  <div class="conteudo">
    <div class="icone">
      <img class="imgIcone" src="src/images/citacao.png" :alt="texto" />
    </div>
    <div class="citacao">{{texto}}"</div>
    <div class="autor">{{autor}}</div>
  </div>
</template>

<script>
export default {
  props: ["texto", "autor"]
};
</script>

<style scoped>
.conteudo {
  padding: 15px;
  width: 335px;
  background: rgba(0, 0, 0, 0.1);
  border-radius: 20px;
  margin: 10px;
  box-shadow: 5px 10px 18px rgba(26, 0, 0, 0.2);
  max-height: 250px;
  overflow: auto;
}
.conteudo::-webkit-scrollbar {
  width: 10px;
  background: rgba(0, 0, 0, 0.237);
  border-radius: 10px;
}

.conteudo::-webkit-scrollbar-thumb {
  border-radius: 5px;
  background: rgba(0, 0, 0, 0.637);
}

.citacao {
  font-size: 1.8em;
  line-height: 30px;
  margin: 5px 15px 15px 15px;
  text-align: center;
  font-weight: bolder;
  /* font-family: "Dancing Script", cursive; */
}

.autor {
  font-size: 1.2em;
  text-align: center;
}

.icone {
  position: relative;
  text-align: center;
  margin-top: 4px;
}

.imgIcone {
  margin: auto;
  width: 50px;
}
</style>