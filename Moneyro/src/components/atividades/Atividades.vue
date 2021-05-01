<template>
  <div class="pag">
    <Menu />
    <div class="centro">
      <div class="retangulo"> 
        <img src="../../images/turma.png">
      </div>
      <div class="conteudo">
        <div class="quadrado">
          <img src="../../images/turma.png">
        </div>
        <div class="quadrado">
          <img src="../../images/turma.png">
        </div>
        <div class="quadrado">
          <img src="../../images/turma.png">
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
.conteudo {
  display: flex;
  flex-wrap: wrap;
}

.retangulo {
  margin:auto;
  display: flex;
  flex-direction: row;
  width:100%;
  background: #f5f5f517;
  padding: 15px 20px;
  border-radius: 20px;
  color: whitesmoke;
}

.centro {
  display: flex;
  flex-direction: column;
  margin: auto;
  justify-content: center;
  align-items: stretch;
}
    
img {
  width: 270px;
  border-radius: 20px;
  margin: auto;
}

.pag{
  padding: 15px 10vw;
}

.quadrado{
  font-size: 3em;
  box-sizing: border-box;
  padding: 15px 20px; 
  background: #f5f5f517;
  border-radius: 20px;
  flex: 1;
}

</style>