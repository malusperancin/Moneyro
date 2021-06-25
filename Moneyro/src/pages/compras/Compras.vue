<template>
  <div class="pag">
    <Menu />
    <Carrinho :carrinho="carrinho" v-if="mostrarCarrinho" v-on:fechar="mostrarCarrinho = false" />
    <div class="centro">
      <span class="texto">Confira nossos produtos exclusivos Moneyro:</span>
      <div class="produtos">
        <span class="texto" style="font-size: 2em">Feitos para você </span>
        <div class="destaque">
          <div class="produto_destaque">
            <p class="nome_produto"> {{produtos[0].nome}} </p>
            <div class="ft">
              <div class="destaque_imagem">
                <img alt="" :src="'../src/images/' + produtos[0].foto + '.png'">
              </div>
              <div class="descricao">
                <p>{{produtos[0].descricao}}</p>
                <p class="preco">R$ {{produtos[0].preco}}</p>
                
                <button style="background: grey;" v-if="produtos[0].nome == 'Área do Professor' && $session.get('professor')" class="botao" title="Você já comprou este produto!">Já Possui</button>
                <button v-else class="botao" v-on:click="comprar(produtos[0])">Comprar</button>
              </div>
            </div>
          </div>
          <div class="produto_destaque">
            <p class="nome_produto"> {{produtos[1].nome}} </p>
            <div class="ft">
              <div class="destaque_imagem">
                <img alt="" :src="'../src/images/' + produtos[1].foto + '.png'">
              </div>
              <div class="descricao">
                <p>{{produtos[1].descricao}}</p>
                <p class="preco">R$ {{produtos[1].preco}}</p>
                <button style="background: grey;" v-if="produtos[1].nome == 'Área do Professor' && $session.get('professor')" class="botao" title="Você já comprou este produto!">Já Possui</button>
                <button v-else class="botao" v-on:click="comprar(produtos[1])">Comprar</button>
              </div>
            </div>
          </div>
        </div>
        <span class="texto" style="font-size: 2em; margin-top: 45px;">Feitos para dar de presente</span>
        <div class="lista">
          <div :style="{background: cores[getRandomInt(0,8)]}" v-for="(prod, i) in produtos.filter(p => p.id > 2)" :key="i" class="produto_lista">
            <div class="lista_corpo">
              <p class="nome_produto"> {{prod.nome}}</p>
              <img alt="" :src="'../src/images/' + prod.foto + '.png'">
              <p>{{prod.descricao}}</p>
              <div class="lista_preco">
                <p class="">R$ {{prod.preco}}</p>
                <button class="botao botao_lista" v-on:click="comprar(prod)">Comprar</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
import Menu from "../shared/menu/Menu.vue";
import Carrinho from './components/Carrinho.vue';

export default {
  components: {
    Menu,
    Carrinho
  },
  data() {
    return {
      mostrarCarrinho: false,
      carrinho: [],
      produto: {
        nome: "",
        preco: 0
      },
      produtos: [],
      cores: [
        "rgb(237, 115, 104)",
        "rgb(255, 189, 89)",
        "rgb(255, 241, 120)",
        "rgb(203, 255, 171)",
        "rgb(171, 255, 251)",
        "rgb(171, 207, 255)",
        "rgb(179, 171, 255)",
        "rgb(234, 171, 255)",
        "rgb(255, 171, 217)",
      ]
    };
  },
  methods: {
    getRandomInt(min, max) {
      min = Math.ceil(min);
      max = Math.floor(max);
      return Math.floor(Math.random() * (max - min)) + min;
    },
    comprar(produto){
      if(this.carrinho.includes(produto))
      {
        var i = this.carrinho.indexOf(produto);
        produto.quantidade += 1;
        this.carrinho.splice(i, 1);
        this.carrinho.push(produto);
      }
      else
      {
        produto.quantidade = 1;
        this.carrinho.push(produto);
      }

      this.mostrarCarrinho = true;
    },
    getProdutos() {
      this.$http
        .get("https://localhost:5001/api/compras") 
        .then(
          dados => {
            this.produtos = dados.body;
            
          }
        ); 
    }
  },
  created() {
    document.title = "Loja";

    this.getProdutos();
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
  flex-direction: column;
}

.destaque {
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-gap: 25px;
}

.produto_destaque{
  font-size: 2.5em;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  padding: 22px 2px 22px 20px;
  background: rgb(74, 91, 145);
  
  
  border-radius: 12px;
  color: whitesmoke;
  box-shadow: 6px 5px 16px 0px black;
}

.ft {
  display: flex;
  justify-content: space-between;
}

.destaque_imagem{
  padding: 15px 0 0 15px;
}

.destaque_imagem img {
  height: 100%;
  border-radius: 8px;
  object-fit: cover;
}

.descricao {
  font-size: 0.5em;
  line-height: 20px;
  padding: 12px 20px 0 20px;
  display: flex;
  justify-content: space-between;
  flex-direction: column;
  flex: 1;
}

.nome_produto{
  font-weight: 700;
  font-size: 100%;
  width:100%;
  text-align: start;
  line-height: 35px;
}

.preco {
  font-size: 2.5em;
  line-height: 45px;
}

.texto {
  color: hsl(0, 0%, 100%);
  font-size: 2.5em;
  margin-bottom: 25px;
}

.lista {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  grid-template-rows: 1fr;
  grid-gap: 25px;
}

.produto_lista, .lista_corpo {
  display: flex;
  flex-direction: column;
  padding: 10px;
  flex: 1;
}

.produto_lista {
  color: black;
  border-radius: 5px;
  box-shadow: 1px 1px 12px 0px black;
  /* background: hsl(229, 49%, 55%); */
   background: hsl(229, 78%, 61%,40%);
}

.produto_lista .nome_produto {
  line-height: 0;
  margin: 15px 0 35px 0;
  font-size: 1.8em;
}

.produto_lista img {
  width: 100%;
  height: 150px;
  border-radius: 3px;
  margin: auto;
  object-fit: cover;
}

.lista_preco {
  display: flex;
  font-size: 1.5em;
  justify-content: space-between;
}

.lista_preco p {
  line-height: 45px;
  padding: 0;
  margin: 0;
}

.botao_lista {
  font-size: 0.8em !important;
  width: 50% !important;
  padding: 2px 8px !important;
  margin: 0 !important;
  box-shadow: 1px 1px 5px 0px black;
}

p{
  margin:5px 5px 20px; 
  padding:0
}

.botao {
  font-size: 0.8em;
  width: 60%;
  color: black;
  background-color: rgba(241, 174, 30, 0.863);
  border-radius: 3px;
  cursor: pointer;
  font-weight: 1000;
  padding: 8px 12px;
  text-align: center;
  margin: 0 0 0 auto;
  border:none;
}

.botao:hover, .botao_lista:hover {
  background-color: rgb(250, 199, 88);
}

img {
  width: 200px;
  border-radius: 20px;
  margin: auto;
}
</style>
