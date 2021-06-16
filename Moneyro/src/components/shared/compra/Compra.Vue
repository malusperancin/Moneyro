<template>
  <div class="modal">
    <form v-on:submit.prevent class="modal-conteudo animate">
      <div class="cima">
        <p>Carrinho <ion-icon name="cart"></ion-icon></p>
        <span class="fechar" v-on:click="$emit('fechar')">&times;</span>
      </div>

      <div class="corpo">
        <div class="produto" v-if="carrinho[0]">
         <img alt="" :src="'../src/images/' + carrinho[carrinho.length-1].foto + '.png'"> 
          <div class="flex">
            <p>{{carrinho[carrinho.length-1].nome}}</p>
            <p class="prec">R${{carrinho[carrinho.length-1].preco}}</p>
          </div>
        </div>

        <div class="carrinho">
          <p style="font-size: 1.3em">Seu carrinho: {{carrinho[0]?"":"Vazio"}}</p>
          <div class="carrinho_produto flex" v-for="(prod, i) in carrinho">
            <p>{{prod.quantidade>1?prod.quantidade+"x":""}}{{prod.nome}}</p>
            <p class="preco">R${{prod.preco}} <span class="remover" v-on:click="remover(prod, i)">-</span></p>
            
          </div>
        </div>
      </div>
        <div class="risco"></div>

        <div class="baixo">
          <div class="total">
            <p>Total: R${{Math.round(total * 100) / 100}}</p>
          </div>
          <div class="cep_div" >
            <p>CEP</p>
            <input 
              type="text" 
              v-model="cep" 
              placeholder="_____-___" 
              pattern="[0-9]{5}-[0-9]{3}" 
              required
            />
          </div>
        </div>
        
        <button class="botao" v-on:click="carrinho.total = total, $router.push({ path: 'boleto', query: { cep: cep, carrinho: carrinho} })">Finalizar</button>
    </form> 
  </div>

</template> 

<script>
export default {
  props: ["carrinho"],
  data() {
    return {
      visivel: false,
      cep: null,
      qtd: 1,
      total: 0,
    };
  },
  methods: {
    remover(produto, i){
      if(this.carrinho[i].quantidade == 1)
        this.carrinho.splice(i, 1);
      else
      {
        produto.quantidade -= 1;
        this.carrinho.splice(i, 1);
        this.carrinho.push(produto);
      }
    }
  },
  created() {
    this.total = 0;

    this.carrinho.map(p => {
      if(p.quantidade)
        this.total += p.preco*p.quantidade;
      else
        this.total += p.preco;
    });
  },
  watch: {
    carrinho(){
      this.total = 0;

       this.carrinho.map(p => {
        if(p.quantidade)
          this.total += p.preco*p.quantidade;
        else
          this.total += p.preco;
      });
    }
  },
};
</script>


<style scoped>
.modal-conteudo {
  overflow-y: scroll;
  overflow-x: hidden;
}

.modal-conteudo::-webkit-scrollbar {
  width: 0px;
}

/* Track */
.modal-conteudo::-webkit-scrollbar-track {
  background: #f1f1f1; 
}
 
/* Handle */
.modal-conteudo::-webkit-scrollbar-thumb {
  background: #888; 
}

/* Handle on hover */
.modal-conteudo::-webkit-scrollbar-thumb:hover {
  background: #555; 
}


.preco {
  display: flex;
  grid-gap: 15px;
}

.prec{
  color: hsl(208, 80%, 5%);
}

.risco {
  background: rgba(0, 0, 0, 0.35);
  width: 100%;
  height: 1px;
  margin: 10px 0;
}

.modal {
    z-index: 99999;
    display: flex;
    font-family: "Baloo Chettan 2", cursive;
    position: fixed;
    right: 0;
    top: 0;
    width: 25%;
    height: 100%;
    align-items: center;
}
  
.cima {
  width: 100%;
  display: flex;
  justify-content: space-between;
  padding: 5px 0 0 15px;
}

.cima p {
  display: flex;
  align-items: center;
  grid-gap: 10px;
  font-size: 1.75em;
}
  
.fechar {
  font-family: "sans-serif";
  color: #000;
  width: 35px;
  display: flex;
  padding: 5px;
  justify-content: center;
  align-items: center;
  border-radius: 87px;
  font-size: 30px;
  font-weight: bold;
  background: rgb(220, 105, 105);
  margin: 10px;
}

.fechar:hover,
.fechar:focus {
  background: red;
  cursor: pointer;
}

.corpo {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 15px 0 10px;
}

p {
  color: white;
  margin: 0;
  padding: 0;
}
    
form {
  border-radius: 25px 0 0 25px;
  background-color: #fefefe;
  padding: 5px 20px 0 20px;
  border: 1px solid rgb(78, 78, 78);
  width: 100%;
  height: calc(100% - 35px);
  background-color: rgb(88, 88, 88);
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  box-sizing: border-box;
}

.produto {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.produto img {
  width: 70%;
  height: 200px;
  object-fit: cover;  
  border-radius: 15px;
}

.flex {
  display: flex;
  justify-content: space-between;
  font-size: 1.75em;
  width: 100%;
  padding: 15px 0;
  box-sizing: border-box;
}

.carrinho {
  max-height: 100px;
  overflow: auto;
}

.carrinho::-webkit-scrollbar {
  width: 5px;
}

/* Track */
::-webkit-scrollbar-track {
  background: #f1f1f1; 
}
 
/* Handle */
::-webkit-scrollbar-thumb {
  background: #888; 
}

/* Handle on hover */
::-webkit-scrollbar-thumb:hover {
  background: #555; 
}

.carrinho_produto {
  font-size: 1em;
  display: flex;
  justify-content: space-between;
  padding: 0 10px 0 0;
  position: relative;
  margin-bottom: 3px;
}

.baixo {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
}

.total {
  display: flex;
  font-size: 1.25em;
}

.cep_div, .quantia{
  display: flex;
  grid-gap: 12px;
  align-items: center;
  justify-content: flex-end;
  font-size: 1.25em;
}

#qtd{
  width: 20%;
}

input {
  font-size: 1em;
  background-color: whitesmoke;
  border-radius: 5px;
  border: 1px solid gray;
  padding: 4px 12px 4px 16px;
  box-sizing: border-box;
  width: 45%;
}

.botao {
  font-size: 1.4em;
  border: none;
  width: 100%;
  color: black;
  background-color: rgba(241, 174, 30, 0.863);
  border-radius: 13px;
  cursor: pointer;
  font-weight: 600;
  padding: 8px;
  text-align: center;
  margin: 20px auto 20px;
}

.remover {
  background: tomato;
  width: 30px;
  height: 30px;
  border-radius: 5px;
  font-size: 1.5em;
  padding: 1px;
  max-width:15px;
  max-height:15px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  line-height: 0;
}
</style>
