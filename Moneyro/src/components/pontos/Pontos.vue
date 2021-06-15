<template>
  <div class="pag">
   <Mensagem
      :msg="msg"
      v-if="msg.visivel" 
      v-on:cancelar="msg.visivel = false"
      v-on:trocar="trocarbanco()"/>
    <Menu />
    <div class="centro">
      <div>
        <h3 class="pts"> Seus pontos: {{ $session.get("pontos") }} </h3>
      </div>
      <h1 id="titulo"> Conquistas </h1>
      <div class="conquistas">
        <div class="conquista" v-for="conquista in conquistas"> 
          <img :src="'../src/images/'+conquista.foto+'.png'"> 
          <div class="descricao">
          <div class="linha">
            <p><b>{{conquista.nome}}</b></p>
            <p><b>{{conquista.pontos}} pontos</b></p>
          </div>
            <p>{{conquista.descricao}}</p>
            <div class="progresso">
              <div class="porcentagem">
                <div class="numero">
                  {{conquista.feito}}/{{conquista.objetivo}}
                </div>
              </div>
              <div :style="'width:' + (conquista.feito/conquista.objetivo*100) + '%'" class="progresso-barra"></div>
            </div>
          </div> 
        </div>
      </div>
      
      <h1> Já Adquiridos </h1>
      <div class="conquistas">
        <div class="conquista" v-for="feito in feitos"> 
          <img :src="'../src/images/' + feito.foto + '.png'"> 
          <div class="descricao">
            <div class="linha">
            <p><b>{{feito.nome}}</b></p>
            <p><b>{{feito.pontos}} pontos</b></p>
          </div>
            <p>{{feito.descricao}}</p>
            <div class="progresso">
              <div class="porcentagem">
                  {{feito.feito}}/{{feito.objetivo}}
                </div>
              <div :style="'width:100%'" class="progresso-barra concluido"></div>
            </div>
          </div> 
        </div>
      </div>

      <h1> Troca de Pontos </h1>
      <div class="conteudo">
        <div class="quadrado" v-for="produto in produtos">
          <img :src="'../src/images/'+produto.foto+'.png'">
          <p class="infotroca">{{produto.nome}} </p>
          <p class="infotroca">{{produto.preco}} pontos </p>
          <button class="btncompra" v-on:click="trocar(produto)">Trocar</button>
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
       msg: {
        visivel: false,
        titulo: "",
        mensagem: "",
        botoes: [],
      },
      conquistas: [],
      produtos: [],
      idProd: 0,
      feitos: [
        {
          nome: "A primeira é inesquecível",
          descricao: "Faça sua primeira receita",
          feito: 1,
          objetivo: 1,
          pontos: 10,
          foto: "status4"
        },
        {
          nome: "Quase um professor!",
          descricao: "Complete um de nossos quizzes",
          feito: 1,
          objetivo: 1,
          pontos: 50,
          foto: "tornarprof"
        }
      ],
    };
  },
  methods: {
    trocarbanco(){
      this.msg.visivel = false;
      this.$http
          .post("https://localhost:5001/api/trocas/"+this.$session.get("id") +"/"+ this.idProd)
          .then(response => {
            this.produtos = this.produtos.filter(p => p.id != this.idProd);
          }, erro =>{
            console.log(erro);
          });
    },
    trocar(produto){
      alert(this.$session.get("pontos"));
      var pontos = this.$session.get("pontos");

      if(pontos < produto.preco)
        this.msg = {
          visivel: true,
          titulo: "Poucos pontos",
          mensagem: "Você não possui a quantidade de pontos necessária!",
          botoes: [
            {
              mensagem: "Ok",
              evento: "cancelar",
            }
          ],
        };
      else
      {
        this.msg = {
          visivel: true,
          titulo: "Trocar pontos",
          mensagem: "Deseja trocar "+ produto.preco + " pontos pelo(a) "+ produto.nome +"?",
          botoes: [
            {
              mensagem: "Cancelar",
              evento: "cancelar",
            },
            {
              mensagem: "Sim",
              evento: "trocar",
            }
          ],
        };
        this.idProd = produto.id;
      }
    },
    getConquistas() {
      this.$http
        .get("https://localhost:5001/api/conquistas") 
        .then(
          dados => {
            this.conquistas = dados.body;
          }
        ); 
    },
    getProdutos() {
      this.$http
        .get("https://localhost:5001/api/trocas/"+this.$session.get("id")) 
        .then(
          dados => {
            this.produtos = dados.body;
          }
        ); 
    }
  },
  created() {
    document.title = "Pontos";
    this.getConquistas();
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
/*
.pag{
  padding: 15px 10vw;
  color: white;
}
*/
.linha{
  display: flex;
  justify-content: space-between;
}
.pts{
  float:right;
  margin:0;
}

.conquistas {
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-gap: 10px;
}

.conquista {
  background-color: #303030;
  display: flex;
  flex-direction:row;
  box-sizing: boder-box;
  padding: 1%;
  padding-bottom:1.5%;
  border-radius: 5px;
}

.conquista p {
  padding: 0;
  margin: 0;
}

.conquista img {
  width: 60px;
  height: 60px; 
  margin: 8px 5px 5px 6px;
  border-radius:5px;
}

.descricao {
  flex: 1;
  padding: 0px 10px;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
}

.progresso {
  margin-top:1%;
  position: relative;
  overflow: hidden;
  height: 18px;
  border-radius: 5px;
  background: #202020;
}

.progresso-barra {
  position: absolute;
  top: 0;
  left: 0;
  height: 25px;
  background-color: rgba(241, 174, 30, 0.863);
  border-radius: 2px;
}

.porcentagem {
  position: absolute;
  top: -15%;
  left: 45%; 
  display: flex;
  z-index:9;
  color: #ffffff96
}

.numero {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100px;
  background: red;
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
  color: white;
}

.conteudo {
  display: flex;
  overflow-x: scroll;
  justify-content: space-between;
  background-color: #303030;
  padding: 2%;
  border-radius: 20px;
}
    
.retangulo img{
  width: 100%;
  border-radius: 20px;
}

#titulo{
    margin-top:0;
}


/*------------TROCA DE PONTOS---------------*/

.quadrado img {
    width: 170px;
    border-radius: 20px;
    border-right: 4px solid #00000050;
    border-bottom: 4px solid #00000050;
}

.quadrado{
    cursor: pointer;
    position: relative;
    width:fit-content;
    margin:2%;
    text-align:center;
}

.infotroca{
    margin: 5px;
    font-size: 1.3em;
}

.btncompra{
    border: 0;
    border-radius: 5px;
    font-size: 1.2em;
    border: none;
    width: 90%;
    color: white;
    background-color: rgba(241, 174, 30, 0.863);
    border-radius: 13px;
    cursor: pointer;
    font-weight: 600;
    padding: 7px;
    text-align: center;
    margin: 3% auto;
}

/* scroll */

.conteudo::-webkit-scrollbar {
  width: 5px;
  background: transparent;
}

.conteudo::-webkit-scrollbar-thumb {
  border-radius: 10px;
  background: rgba(87, 86, 86, 0.637);
}

.conteudo::-webkit-scrollbar-arrow {
  color: white;
  background: yellowgreen;
}
</style>