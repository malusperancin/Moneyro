<template>
  <div class="pag">
    <Menu />
    <Mensagem
      :msg="msg"
      v-if="msg.visivel" 
      v-on:cancelar="msg.visivel = false"
      />
    <div class="centro">
      <div class="retangulo" v-on:click="irJogo"> 
        <span title="Este conteúdo é pago!" class="capelo">🎓</span>
        <img src="../../images/jogojogar.png">
      </div>
      <div class="conteudo">
        <div class="quadrado" v-on:click="$router.push({ path: 'quiz', query: { codigo: 1} })">
          <img src="../../images/quiz1.png">
        </div>
        <div class="quadrado" v-on:click="$router.push({ path: 'quiz', query: { codigo: 2} })">
          <img src="../../images/quiz2.png">
        </div>
        <div class="quadrado" v-on:click="$router.push({ path: 'quiz', query: { codigo: 3} })">
          <img src="../../images/quiz3.png">
        </div>
        <div class="quadrado">
          <img src="../../images/breve.png">
        </div>
        <div class="quadrado">
          <img src="../../images/breve.png">
        </div>
        <div class="quadrado">
          <img src="../../images/breve.png">
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Menu from "../shared/menu/Menu.vue";
import Mensagem from "../shared/mensagem/Mensagem.vue";

export default {
  components: {
    Menu,
    Mensagem
  },
  data() {
    return {
      carrinho: false,
      produto: {
        nome: "",
        preco: 0
      },
      msg: {}
    };
  },
  methods: {
    irJogo(){
      if(this.$session.get('idSala') != 1 || this.$session.get('professor') == 1) 
        this.$router.push('/jogo');
     
      this.msg = {
        visivel: true,
        titulo: "Humm que pena!",
        mensagem: "Este conteúdo é apenas para estudantes e professores!",
        botoes: [{
            mensagem: "Ok",
            evento: "cancelar",
        }]
      };
    }
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
  
}

.capelo::selection {
  user-select: none;
}

.capelo {
  transform: rotate(45deg);
  font-size: 60px;
  position: absolute;
  top: -35px;
  right: -35px;
}

.centro {
  padding: 30px 15vw;
  display: flex;
  flex-direction: column;
  align-content: stretch;
}

.conteudo {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  grid-gap: 1% 5%;
  box-sizing: border-box;
}

.quadrado img {
  width: 100%;
  border-radius: 20px;
  border-right: 12px solid #00000050;
  border-bottom: 12px solid #00000050;
}

.quadrado{
  cursor: pointer;
  position: relative;
  width:fit-content;
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
</style>