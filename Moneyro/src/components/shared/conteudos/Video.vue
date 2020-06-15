<template>
  <div class="conteudo">
    <div class="video">
      <iframe
        width="360"
        height="230"
        :src="video"
        frameborder="0"
        allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
        allowfullscreen
      ></iframe> 
     
      <div class="assunto">{{assunto}}</div>
    </div>
    <h2 class="titulo">{{titulo}}</h2>
  </div>
</template>

<script>
export default {
  props: ["video", "titulo", "assunto"],
  data() {
    return {};
  }
};
</script>

<style scoped>
.conteudo {
  height: 300px;
  padding: 15px;
  width: 360px;
  background: rgba(0, 0, 0, 0.1);
  border-radius: 20px;
  margin: 10px;
  box-shadow: 5px 5px 18px rgba(26, 0, 0, 0.2);
}

iframe {
  border-radius: 20px;
}

.assunto {
  color: white;
  font-size: 1.2em;
  background: rgba(182, 1, 1, 0.651);
  width: fit-content;
  padding: 6px 12px;
  border-radius: 30px;
  position: absolute;
  bottom: 14px;
  left: 8px;
}

.video:hover .assunto {
  display: none;
}

.video {
  border-radius: 15px;
  position: relative;
  text-align: center;
}

.titulo {
  font-weight: bold;
  margin: 5px;
  line-height: 25px;
  word-wrap: break-word;
  color:whitesmoke;
}
</style>