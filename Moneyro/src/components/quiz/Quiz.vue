<template>
  <div class="pag">
    <Cabecalho :titulo="'Quiz'"/>
    <Menu />
    <Mensagem
      :msg="msg"
      v-if="msg.visivel"
      v-on:fechar="msg.visivel = false"
    ></Mensagem>
    <div class="centro">
      <div class="titulo">
        <p>Quiz do Moneyro</p>
      </div>
      <div class="questao" v-if="indice < perguntas.length">
        <div class="pergunta">
          <span class="numeros">{{ indice + 1 }}</span>
          <h1>{{perguntas[indice].descricao}} </h1>
        </div>
        <div class="alternativas">
          <div class="alternativa" v-for="(alternativa,j) in perguntas[indice].alternativas">   
            <label class="container">
              {{perguntas[indice].alternativas[j]}}
              <input type="radio" class="rb" v-model="respostas[indice]" :id="j" :name="'pergunta'+indice" :value="j">
              <span class="checkmark"></span>
            </label>
          </div>
        </div>
      </div>
      <div class="resultado" v-else>
        <h1 style="text-align:center"> Você acertou {{acertos}} de {{perguntas.length}} questões</h1>
      </div>
      <div class="controles">
          <button class="botao" id="ant" v-on:click="anterior()">Anterior</button>
          <div class="progresso">
            <div class="porcentagem">
              {{Math.round(((indice)/perguntas.length)*100)}}%
            </div>
            <div :style="'width:'+((indice)/perguntas.length)*100+'%'" class="progresso-barra"></div>
          </div>
          <div>
            <button class="botao" v-if="indice<perguntas.length-1" v-on:click="proxima()">Proximo</button> 
            <button class="botao" id="env" v-else-if="indice === perguntas.length-1" v-on:click="enviar()">Enviar</button>
            <button class="botao" id="sair" v-else v-on:click="$router.push('atividades')">Sair</button> 
          </div>
      </div>
    </div>
  </div>
</template>

<script>
import Cabecalho from '../shared/cabecalho/Cabecalho.vue';
import Menu from '../shared/menu/Menu.vue';
import Mensagem from "../shared/mensagem/Mensagem.vue";

export default {
  components: {
    Cabecalho,
    Mensagem,
    Menu
  },
  data() {
    return {
      acertos: 0,
      j: 0,
      indice: 0,
      respostas: [],
      perguntas: [],
      msg: {
        visivel: false,
        titulo: "",
        mensagem: "",
        botoes: []
      },
    };
  },
  methods: {
    pontuar(){
      if(this.respostas[this.indice] == this.perguntas[this.indice].resposta)
      {
        this.acertos++;
      }
    },
    proxima() {
      if(this.respostas[this.indice] == null) //se não respondeu
      {
          this.msg.titulo = "Tem certeza que deseja ir para proxima?";
          this.msg.mensagem = "Você esqueceu de marcar a ultima questão,\n pode voltar quando quiser para arrumar";
          this.msg.botoes = [
            {
            mensagem: "Ok",
            evento: "fechar"
            }
          ];
          this.msg.visivel = true;
        }
      
      this.pontuar();
      this.indice = this.indice+1;
    },
    anterior() {
      if(this.indice > 0)
      {
        this.indice = this.indice-1;
      }
    },
    enviar(){
      if(this.respostas[this.indice])
      {
        this.pontuar();
        var btnAnterior = document.getElementById("ant");
        btnAnterior.style.background = "#696969"
        btnAnterior.style.color = "darkgray";
        btnAnterior.disabled= true;
        this.indice = this.perguntas.length;
        alert(this.acertos);
      }
    }
  },
  mounted(){
    var rb = document.getElementsByClassName("rb");
    for(var i=0;i<rb.length;i++)
      rb[i].checked = false;

  },
  created() {  
    document.title = "Moneyro - Quiz";
    alert(this.$route.query.codigo);
    this.$http
        .get("https://localhost:5001/api/quiz/" + this.$route.query.codigo)
        .then(dados => {
          this.perguntas = dados.body;
        });
  },
   beforeCreate() {
     if (!this.$session.exists()) {
      this.$router.push('/')
    }
  },
  watch: {
  }
};
</script>

<style scoped>
h1{
  margin-top: 0;
}

.controles {
  display: grid;
  grid-template-columns: 1fr 10fr 1fr;
  grid-gap: 30px;
  align-items: center;
}

.alternativas {
  padding: 0px 10px;
  box-sizing: border-box;
}

.centro {
  display: flex;
  flex-direction: column;
  padding: 8% 15%;
}

.numeros {
  background-color: hsl(208, 80%, 24%);
  margin-right: 15px; 
  border-radius: 50%;
  width: 20px;
  height:20px;
  padding: 12px;
  font-size:1.7em;
  font-weight: bold;
  justify-content: center;
  align-items: center;
  display: flex;
} 

#sair {
  background-color: tomato;
}

.pergunta {
  padding-top: 15px;
  display: flex;
}

.titulo {
  color: white;
  font-size: 3em;
}

.questao, .resultado{
  color:white;
  /* background: : */
  border-radius: 10px;
  border: 1px gray solid;
  padding: 1.5% 3%;
  margin: 2% 0;
  min-height: 250px;
}

p {
  margin: 0;
  padding: 0;
}

.botao {
  font-size:1.5em;
  border: none;
  width: 180px;
  color: white;
  background-color: rgba(241, 174, 30, 0.863);
  border-radius: 13px;
  cursor: pointer;
  font-weight: 1000;
  padding: 5px;
  text-align: center;
}

/*------CHECK------*/

.container {
  display: block;
  position: relative;
  padding-left: 35px;
  margin-bottom: 12px;
  cursor: pointer;
  font-size: 22px;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

/* Hide the browser's default radio button */
.container input {
  position: absolute;
  opacity: 0;
  cursor: pointer;
}

/* Create a custom radio button */
.checkmark {
  position: absolute;
  top: 0;
  left: 0;
  height: 25px;
  width: 25px;
  background-color: #eee;
  border-radius: 50%;
}

/* On mouse-over, add a grey background color */
.container:hover input ~ .checkmark {
  background-color: #ccc;
}

/* When the radio button is checked, add a blue background */
.container input:checked ~ .checkmark {
  background-color: rgb(241, 174, 30);
}

.progresso {
  position: relative;
  overflow: hidden;
  height: 75%;
  border-radius: 5px;
  background: #101010;
}

.progresso-barra {
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  background-color: rgba(241, 174, 30, 0.863);
  border-radius: 2px;
}

.porcentagem {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  text-align: center;
  line-height: 35px;
  z-index:9;
  color: #ffffff96;
  font-size:1.7em;
}

</style>