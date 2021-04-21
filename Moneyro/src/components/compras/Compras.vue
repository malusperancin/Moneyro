<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <Compra :produto="produto" v-if="carrinho= true" v-on:fechar="carrinho = false" />
    <div class="centro">

      <div class="cofre">
          
        <div class="quadrado">
          <div class="titulo">
            <p> Cofre inteligente </p>
          </div>
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
      </div>

      <div class="quadrado">
        <div class="titulo">
          <p> Area do Professor </p>
        </div>
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
     this.carrinho = true;
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
    } 
  },
  created() {
    document.title = "Compra";
    
  },
   beforeCreate() {
    if (!this.$session.exists()) {
      this.$router.push('/')
    }
  }
};
</script>

<style scoped>

    .quadrado{
      font-size: 3em;
      display: flex;
      flex-direction: column;
      box-sizing: border-box;
      padding: 15px 20px;
      background: #f5f5f517;
      border-radius: 20px;
      color: whitesmoke;
      margin: 20px;
    }
    
    .titulo{
      font-weight: 700;
      font-size: 80%;
      width:100%;
      margin:0;
      text-align: center;
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
      margin: auto;
    }

    .centro {
      display: flex;
      flex-direction:inherit;
      margin: auto;
      justify-content: center;
    }
    
    img {
      width: 300px;
      border-radius: 20px;
      margin: auto;
    }

    li {
       font-size: 50%; 
    }
    </style>
