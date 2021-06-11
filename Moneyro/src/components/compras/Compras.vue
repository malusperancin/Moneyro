<template>
  <div class="pag">
    <Menu />
    <Compra :carrinho="carrinho" v-if="mostrarCarrinho" v-on:fechar="mostrarCarrinho = false" />
    <div class="centro">
      <span class="texto">Confira nossos produtos exclusivos Moneyro:</span>
      <div class="produtos">
        <span class="texto" style="font-size: 2em">Feitos para você </span>
        <div class="destaque">
          <div v-for="(prod, i) in produtos_destaque" :key="i" class="produto_destaque">
            <p class="nome_produto"> {{prod.nome}} </p>
            <div class="ft">
              <div class="destaque_imagem">
                <img alt="" :src="'../src/images/' + prod.foto + '.png'">
              </div>
              <div class="descricao">
                <p>{{prod.descricao}}</p>
                <p class="preco">R$ {{prod.preco}}.00</p>
                
                <button style="background: grey;" v-if="prod.nome == 'Área do Professor' && $session.get('professor')" class="botao" title="Você já comprou este produto!">Já Possui</button>
                <button v-else class="botao" v-on:click="comprar(prod)">Comprar</button>
              </div>
            </div>
          </div>
        </div>
        <span class="texto" style="font-size: 2em; margin-top: 45px;">Feitos para dar de presente</span>
        <div class="lista">
          <div v-for="(prod, i) in produtos" :key="i" class="produto_lista">
            <p class="nome_produto"> {{prod.nome}}</p>
            <div class="lista_corpo">
              <img alt="" :src="'../src/images/' + prod.imagem + '.png'">
              <p>{{prod.descricao}}</p>
              <div class="lista_preco">
                <p class="">R$ {{prod.preco}}.00</p>
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
import Compra from '../shared/compra/Compra.vue';

export default {
  components: {
    Menu,
    Compra
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
      produtos_destaque: [
]
    };
  },
  methods: {
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
        .get("https://localhost:5001/api/produtos") 
        .then(
          dados => {
            this.produtos = dados.body;
          }
        ); 
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
  background: hsl(229, 78%, 61%,40%);
  
  
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
}

.produto_lista {
  color: white;
  border-radius: 5px;
  box-shadow: 1px 1px 12px 0px black;
  /* background: hsl(229, 49%, 55%); */
   background: hsl(229, 78%, 61%,40%);
}

.produto_lista .nome_produto {
  line-height: 0;
  margin: 25px 0 25px 15px;
  font-size: 1.8em;
}

.produto_lista img {
  width: 100%;
  height: 110px;
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
}

p{
  margin:5px 5px 20px; 
  padding:0
}

.botao {
  font-size: 0.8em;
  border: none;
  width: 60%;
  color: white;
  background-color: rgba(241, 174, 30, 0.863);
  border-radius: 3px;
  cursor: pointer;
  font-weight: 1000;
  padding: 8px 12px;
  text-align: center;
  margin: 0 0 0 auto;
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
