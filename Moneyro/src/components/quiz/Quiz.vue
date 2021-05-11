<template>
  <div class="pag">
    <Cabecalho :titulo="'Quiz'"/>
    <Menu />
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
              <input type="radio" v-model="j" :id="j" :name="'pergunta'+indice" :value="j">
              <span class="checkmark"></span>
            </label>
          </div>
        </div>
      </div>
      <div class="resultado" v-else>
        <h1> Você acertou 1 de {{perguntas.length}} questões</h1>
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
export default {
  components: {
    Cabecalho,
    Menu
  },
  data() {
    return {
      indice: 0,
      respostas: [],
      perguntas: [
        {
          descricao: "Qual é o nome da filha da Xuxa?",
          resposta: 1,
          alternativas: [
              "Shaxa",
              "Sasha",
              "Chacha",
              "Xaxa"
          ]
        },
        {
          descricao: "Quanto é (345 * 23 / 42 + 23.534 ^ 231 + 231) * 34 ^ 3",
          resposta: 3,
          alternativas: [
              "3",
             "234532",
             "6",
             "Xaxa"
          ]
        },
        {
          descricao: "Ca, Ce, Ci, Co?",
          resposta: 3,
          alternativas: [
            "Cu",
            "Ku",
            "Crú",
            "Sapo Cururú"
          ]
        }
      ]
    };
  },
  methods: {
    proxima() {
      if(this.indice+1 < this.perguntas.length)
      {
        this.indice = this.indice+1;
      }
    },
    anterior() {
      if(this.indice > 0)
      {
        this.indice = this.indice-1;
      }
    },
    enviar(){
      var btnAnterior = document.getElementById("ant");
      btnAnterior.style.background = "#696969"
      btnAnterior.style.color = "darkgray";
      btnAnterior.disabled= true;
      this.indice = this.perguntas.length;
    }
  },
  mounted(){


  },
  created() {
    
document.title = "Moneyro - Quiz";
  },
   beforeCreate() {
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
  padding: 0px 525x;

  box-sizing: border-box;
  background: red;
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
  top: -15%;
  left: 45%; 
  display: flex;
  z-index:9;
  color: #ffffff96;
  font-size:1.7em;
}

</style>