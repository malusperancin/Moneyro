<!-- alunopic/src/components/shared/painel/Painel.vue -->
<template>
  <div class="painel">
    <div class="info">
      <div class="imagem">
        <img class="imgPerfil" :src="'../src/images/perfil' + foto + '.png'" />
      </div>
      <div class="nome">
        <p>{{ nome }}</p>
      </div>
      <!-- 
        <p class="comp">Compartilhados</p>
        <div class="deletar">
          <img class="imgDeletar" src="src/images/remAmigo.png" />
        </div>
      -->
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
};
</script>

<style scoped>
.painel {
  padding: 15px;
  width: 210px;
  height: 260px;
  border-radius: 5px;
  background-image: linear-gradient(#b88b10, #ecb318);
  box-shadow: 5px 5px 5px #00000040;
  margin: 5px;
  box-sizing: border-box;
}

.info {
  box-sizing: border-box;
  text-align: center;
  height: 100%;
  background: wheat;
}

.imagem {
  background: red;
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
  background: blue;
}

p {
  margin: 0;
}

.iconeDel {
  background: rgba(240, 49, 49, 0.589);
  border-radius: 15px;
  width: 20px;
  height: 20px;
}

.iconeDel:hover {
  background-color: rgb(250, 14, 14);
}

.comp {
  cursor: pointer;
  color: white;
  border-radius: 10px;
  padding: 5px;
  text-align: center;
  box-sizing: border-box;
  font-size: 1.1em;
  margin-bottom: 10px;
  background: rgba(99, 88, 160, 0.336);
}

.comp:hover {
  background: rgb(106, 88, 212);
  border-bottom: 5px solid rgb(78, 63, 158);
}

.imgDeletar {
  width: 20px;
  height: 20px;
  margin-top: 5%;
}

.deletar {
  background: rgb(226, 52, 52);
  cursor: pointer;
  width: 45px;
  height: 45px;
  border-radius: 35px;
  margin: auto;
}

.deletar:hover {
  background: red;
}
</style>