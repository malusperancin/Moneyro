<template>
  <div class="nova-atividade">
    <div class="conteudo">
      <div class="cabecalho">
        <div class="escrita">
          <div class="titulo">
            <img src="../../../images/perfil2.png" style="width: 50px">
            <div class="infos">
              <strong><b>{{professor.nome}}</b></strong>
              <p style="margin: 0; padding: 0;">{{datahojebarra}} </p>
            </div>
            <div class="campos">
              <div> 
                <strong><b>Título:</b></strong>
                <input class="input" 
                type="text"
                placeholder="Atividade 1 - Jogo"/>
              </div>
              <div> 
                <strong><b>Data de Entrega:</b></strong>
                <input type="date" class="data" v-model="datahojetraco">
              </div>
            </div>
          </div>
        </div>  
      </div>
      <!-- V-FOR NO BANCO DE ACTIVITIES -->
      <div class="atividades">
        <div class="quadrado">
          <img class="imagens" src="../../../images/jogo.png">
        </div>

        <div class="quadrado">
          <img class="imagens" src="../../../images/quiz1.png">
        </div>

        <div class="quadrado">
          <img class="imagens" src="../../../images/quiz2.png">
        </div>

        <div class="quadrado">
           <img class="imagens" src="../../../images/breve.png">
        </div>

        <div class="quadrado">
           <img class="imagens" src="../../../images/breve.png">
        </div>

        <div class="quadrado">
          <img class="imagens" src="../../../images/breve.png">
        </div>
      </div>

      <div id="btn">
             <button class="botao">Enviar</button>
      </div>

    </div>
  </div>
</template>


<script>
  
export default {
  data() {
    return {
      datahoje: "",
      sala:{
        nome: "Sala da Maria Luzia",
        codigo: "x5f7h6"
      },
      professor: {
        nome: "Maria Luzia", 
      },
   };
  },
  methods: {
    dataAtual(){
    var data = new Date(),
        dia  = data.getDate().toString(),
        diaF = (dia.length == 1) ? '0'+dia : dia,
        mes  = (data.getMonth()+1).toString(), //+1 pois no getMonth Janeiro começa com zero.
        mesF = (mes.length == 1) ? '0'+mes : mes,
        anoF = data.getFullYear();
        this.datahojebarra = diaF+"/"+mesF+"/"+anoF;
        this.datahojetraco = anoF+"-"+mesF+"-"+diaF;
    }
  },
  computed: {
  },
  created() {
   this.dataAtual();
  },
  beforeCreate(){

  },
  watch: {
    expanded(){
      
    }
  },
};

</script>

<style scoped>
.imagens{
  border-radius:10px;
  border: 3px solid transparent;
}
.imagens:hover{
  border:solid rgb(8, 90, 180) 3px;
}

.botao {
  font-size: 1em;
    border: none;
    width: 15%;
    color: white;
    background-color: rgba(241, 174, 30, 0.863);
    border-radius: 9px;
    cursor: pointer;
    font-weight: 800;
    padding: 5px;
    float: right;
}

.botao:hover {
  background-color: rgba(241, 174, 30, 1);
}

.titulo {
  display: flex;
  margin-bottom: 5px;
}

/* campos de titulo e data */

.titulo .infos { 
  margin-left: 2%;
  flex: 1;
}

.titulo .campos {
  flex: 3;
  display: flex;
  justify-content: space-between; 
}

.titulo .campos div {
  display: flex;
  flex-direction: column;
  margin: 0 0 0 20px;
}

.titulo .campos div:first-child {
  flex: 2;
}

.input{
  width: 100%;
  border: none;
  border-radius: 5px;
  padding: 3px 2px 3px 12px;
  font-size: 1em;
  box-sizing: border-box;
}

.data{
    border-radius: 5px;
    padding: 2px 2px 2px 12px; *
    outline: none;
    border: none;
    width: 80%;
      font-size: 1em;
}

.quadrado{
  width: 32%;
    margin-bottom: 2%;
}

img{
  width:100%;
    height: 100%;
}

/* -------------------- */
.atividades{
  display: flex;
  flex-flow: row wrap;
  justify-content: space-between;
  overflow-y: scroll;
  height: 350px;
  padding-right: 15px;
  margin: 4% 2% 2% 2%;
}

.atividades::-webkit-scrollbar {
        width: 5px;
    }

    /* Track */
.atividades::-webkit-scrollbar-track {
        box-shadow: inset 0 0 2px black; 
        border-radius: 10px;
    }

    /* Handle */
.atividades::-webkit-scrollbar-thumb {
        background: gray; 
        border-radius: 10px;
    }

    /* Handle on hover */
.atividades::-webkit-scrollbar-thumb:hover {
        background: lightgray; 
    }
    


p {
  margin: 0;
  color:white;
  padding: 3px;
}

.nova-atividade{
  height: 100%;
  width: 80%;
  align-items: center;
}

.escrita{
    display: flex;
    flex-direction: column;
    width: 100%;
}

.conteudo {
  color: rgb(255, 255, 255);
  background: rgb(46, 48, 46);
  border-radius: 5px;
  height: fit-content;
  min-width: 250px;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  padding: 15px;
}

.cabecalho{
  display: flex;
}

.texto {
  background: green;
  margin-left: 2.3%;
  margin-bottom: 1%;
  margin-top:1%;
}


/* .topo-atividade {
  background: rgb(37, 33, 33);
  padding: 10px;
  display: flex;
  justify-content: space-between;
  border-top-left-radius: inherit;
  border-top-right-radius: inherit;
} */

</style>
