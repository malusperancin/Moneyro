<template>
  <div class="pag">
    <Menu />
    <div class="centro">
      <div class="retangulo"> 
        <span title="Este conteúdo é pago!" class="coroa">👑</span>
        <img src="../../images/jogojogar.png">
      </div>
      <div class="conteudo">
        <div class="quadrado">
          <img src="../../images/quiz1.png">
        </div>
        <div class="quadrado">
          <img src="../../images/quiz2.png">
        </div>
        <div class="quadrado">
          <img src="../../images/jogo.png">
        </div>
        <div class="quadrado">
          <span title="Este conteúdo é pago!" class="coroa">👑</span>
          <img src="../../images/jogo.png">
        </div>
        <div class="quadrado">
          <img src="../../images/turma.png">
        </div>
        <div class="quadrado">
          <img src="../../images/cofre.png">
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Menu from "../shared/menu/Menu.vue";

export default {
  components: {
    Menu
  },
  data() {
    return {
      carrinho: false,
      produto: {
        nome: "",
        preco: 0
      }
    };
  },
  methods: {
    
  },
  created() {
    document.title = "Atividades";
    
  },
   beforeCreate() {
    if (!this.$session.exists()) {
      this.$router.push('/')
    }
  }
};
</script>

<style scoped>
.pag{
  padding: 15px 10vw;
}

.coroa::selection {
  user-select: none;
}

.coroa {
  transform: rotate(45deg);
  font-size: 45px;
  position: absolute;
  top: -35px;
  right: -35px;
}

.centro {
  display: flex;
  flex-direction: column;
  justify-content: stretch;
}

.conteudo {
  display: flex;
  flex-wrap: wrap;
  box-sizing: border-box;
  justify-content: space-between;
}

.retangulo {
  cursor: pointer;
  display: flex;
  flex-direction: row;
  margin-bottom:3%;
  position: relative;
}
    
.retangulo img{
  width: 100%;
   border-radius: 20px;
}

.quadrado img {
  width: 270px;
  border-radius: 20px;
  margin:2%;
  border-right: 12px solid #00000050;
  border-bottom: 12px solid #00000050;
}

.quadrado{
  cursor: pointer;
  position: relative;
  width:fit-content;
  margin-bottom:1%;
}

</style>