<template>
  <div class="modal">
    <form v-on:submit.prevent class="modal-conteudo animate width-25">
        <div class="cima">
          <span class="fechar" v-on:click="$emit('fechar')">&times;</span>
        </div>

        <div class="corpo">
          <div class="prof produto" v-if="produto.nome == 'professor'">
            <img src="../../../images/porcoprofessor.png" />
            <p class="nomeProduto">Área do Professor</p>
            <p>R$ 85,00</p>
          </div>
          <div class="cofre produto" v-if="produto.nome == 'cofre'">
            <img src="../../../images/cofre.png" />
            <p class="nomeProduto">Cofre Inteligente</p>
            <p>R$ 35,00</p>
            
            <div class="quantia">
              <label>Qtd</label>
              <input
                id = "qtd"
                placeholder="1"
                type="number"
                min="1"
                max="9"
                step="1"
                class="campos"
                v-model="qtd"
                required
              />
            </div>
          </div>
        </div>
        
        <div class="baixo">
          <div id="cep-div" >
                <p>CEP</p>
                <input 
                  type="text" 
                  id="cep" 
                  v-model="cep" 
                  placeholder="_____-___" 
                  pattern="[0-9]{5}-[0-9]{3}" 
                  required
                />
            </div>
          <div class="total">
            <!-- <div class="risco"></div> -->
            <p>Total</p>
            <p id="valorTotal" v-if="produto.nome == 'cofre'">R$ {{qtd * 35}},00</p>
            <p id="valorTotal" v-if="produto.nome == 'professor'">R$ 85,00</p>
          </div>
          <button class="botao" v-on:click="$router.push({ path: 'boleto', query: { cep: cep, produto: produto.nome} })">Comprar</button>
        </div>
    </form> 
  </div>

</template> 

<script>
export default {
  props: ["produto"],
  data() {
    return {
      visivel: false,
      cep: null,
      qtd: 1
    };
  },
  methods: {
    
  },
  computed: {
    
  },
  created() {
    //  visivel = carrinho;
  },
  watch: {
    expanded(){
      
    }
  },
};
// this.$set(this.someObject, "b", 2);
</script>


<style scoped>
  .modal {
      z-index:99999999;
      display: flex;
      font-family: "Baloo Chettan 2", cursive;
      position: fixed;
      right: 0;
      top: 0;
      width: 25%;
      height: 100%;
  }
  
  .cima {
      width: 100%;
      display: flex;
      justify-content: flex-end;
  }
  
  p {
      color: white;
      margin: 0;
      font-size: 1.2rem;
  }
    
  form {
      border-radius:10px 0 0 10px;
      background-color: #fefefe;
      padding: 5px 20px 0 20px;
      /* padding: 20px; */
      border: 1px solid rgb(78, 78, 78);
      width: 100%;
      height: 100%;
      background-color: rgb(88, 88, 88);
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      box-sizing: border-box;
  }

  .baixo {
    display: flex;
    flex-direction: column;
    margin-bottom:5%;
  }

  .total {
    margin-top: 5%; 
    display: flex;
    flex-direction: row;
    justify-content: left;
    text-align:center
  }

  .total p{
    padding: 5px;
  }
    
  .fechar {
    font-family: "sans-serif";
    color: #000;
    width: 17px;
    height: 17px;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 10px;
    border-radius: 87px;
    font-size: 25px;
    font-weight: bold;
    background: rgb(220, 105, 105);
    margin: 10px;
  }

  .fechar:hover,
  .fechar:focus {
    background: red;
    cursor: pointer;
  }
    
  .titulo {
    display: flex;
    overflow: hidden;
    text-align: center;
    margin-right: -10px;
    border-radius: 4px;
  }

  .nomeProduto {
    margin-bottom: 10px;
    margin-top: 0;
    font-weight: 5;
    font-size: 150%;
  }

  img {
      width: 70%;
      border-radius: 10px;
  }

  #cep {
    width: 33%;
  }

  #qtd{
      width: 20%;
  }
  
  input{
    font-size: 1em;
    background-color: whitesmoke;
    border-radius: 5px;
    border: 1px solid gray;
    padding: 4px 7px;
    box-sizing: border-box;
    margin-left:10px;
  }
  
  .produto {
    text-align: center;
    padding: 0px;
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
  
  .quantia{
    margin-top: 10px;
  }

  #cep-div{
    margin-top: 13%;
    display: flex;
    flex-direction: row;
    justify-content: left;
    text-align:center
  }

  #cep-div label{
    margin-top: auto;
    padding-right: 7px;
    margin-right: 7px;
  }
</style>
