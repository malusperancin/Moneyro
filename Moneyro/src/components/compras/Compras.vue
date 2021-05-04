<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <Compra :produto="this.produto" v-if="carrinho" v-on:fechar="carrinho = false" />
    <div class="centro">
      <span class="texto">Confira nossos produtos exclusivos Moneyro:</span>
      <div class="produtos">
        <div class="quadrado">
          <p class="titulo"> Cofre inteligente </p>
          <img src="../../images/cofre.png">
          <ul>
            <li>Um cofre muito do bonito</li>
            <li>Conta seu dinheirinho</li>
            <li>Baratinho</li>
            <li>Ligacao com o app</li>
            <li>Nao sei mais</li>
          </ul>
          <button class="botao" v-on:click="comprar('cofre')">Comprar</button>
        </div>
        <div class="quadrado">
          <p class="titulo"> Area do Professor </p>
          <img src="../../images/porcoprofessor.png">
          <ul>
            <li>Area para dar aulas</li>
            <li>Muito lefal</li>
            <li>Baratinho</li>
            <li>Ligacao com o app</li>
            <li>Nao sei mais</li>
          </ul>
          <button class="botao" v-on:click="comprar('professor')">Comprar</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
import Menu from "../shared/menu/Menu.vue";
import Compra from '../shared/compra/Compra.vue';

export default {
  components: {
    Menu,
    Compra
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
    comprar(produto){
     if(produto == 'professor')
     {
       this.produto.nome = 'professor';
       this.produto.preco = 25
     }
     else
     {
      this.produto.nome = 'cofre';
      this.produto.preco = 5;
     }
     this.carrinho = true;
    } 
  },
  created() {
    document.title = "Loja";
    
  },
   beforeCreate() {
    if (!this.$session.exists()) {
      this.$router.push('/')
    }
  }
};
</script>

<style scoped>
.centro {
  display: flex;
  flex-direction: column;
}

.produtos {
  display: flex;
  padding-top: 2%;
  flex-wrap:wrap;
}

.produtos div {
  margin: 0 1% 1% 0;
  width:475px;
  padding:50px;
  padding-top:30px;
  box-sizing: border-box;
}

.quadrado{
  font-size: 3em;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  padding: 20px;
  background: #f5f5f517;
  border-radius: 20px;
  color: whitesmoke;
}

.titulo{
  font-weight: 700;
  font-size: 100%;
  width:100%;
  text-align: center;
}

.texto {
  color: white;
  font-size: 2em;
}

p{
  margin:5px 5px 20px; 
  padding:0
}

.botao {
  font-size: 0.8em;
  border: none;
  width: 70%;
  color: white;
  background-color: rgba(241, 174, 30, 0.863);
  border-radius: 13px;
  cursor: pointer;
  font-weight: 1000;
  padding: 5px;
  text-align: center;
  margin: 3% auto;
}


img {
  width: 300px;
  border-radius: 20px;
  margin: auto;
}

ul{
  margin:5% auto;
}

li {
    font-size: 50%; 
}
</style>
