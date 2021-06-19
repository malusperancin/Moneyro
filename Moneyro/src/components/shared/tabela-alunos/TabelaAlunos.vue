<template>
  <div class="geral">
    <div class="comunicado">
      <div class="conteudo">
        <div class="cabecalho">
          <div>
              <p class="titulo">Relatório Alunos </p>
          </div>
        </div>
        <div class="corpo">
          <table class="tabela" cellspacin="0">
            <tr>
              <th>Aluno</th>
              <th> Concluído</th>
              <th> Nota </th>
            </tr>
            <tr v-for="reg in relatorio">
              <td class="linha"><img :src="'src/images/perfil'+reg.fotoAluno+'.png'"> <p>{{reg.nomeAluno}}</p></td>
              
              <td v-if="reg.concluido"> <ion-icon name="checkmark-circle" class="icone"></ion-icon> </td>
              <td v-else> <ion-icon name="close-circle" class="icone"></ion-icon> </td>
              
              <td v-if="reg.concluido"> {{reg.nota}} </td>
              <td v-else>---</td>
            </tr>
          </table> 

        </div>
        <div class="btns">
          <button class="botao" id="cancelar" v-on:click="$emit('fechar')">Fechar</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["atividade"],
  data() {
    return {
        informacoes: [],
        relatorio: []
   };
  },
  methods: {
    pegarInfos(){
        alert(this.atividade);
      this.$http
          .get("https://localhost:5001/api/salas/relatorio/"+ this.atividade)
          .then(response => {
            this.relatorio = response.body;
          }, erro =>{
            console.log(erro);
          });
    }
  },
  created(){
      this.pegarInfos();
  }
  
};

</script>

<style scoped>
.geral{
    top: 0;
    left: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    position: fixed;
    z-index: 9999999999;
    width: 100vw;
    height: 100vh;
    background-color: rgba(0, 0, 0, 0.5);
}

.comunicado {
    min-height: 60vh;
    min-width: 50vw;
    align-items: center;
    justify-content: center;
    display: flex;
}

.conteudo {
    color: rgb(255, 255, 255);
    background: rgb(46, 48, 46);
    border-radius: 15px;
    height: fit-content;
    min-width: 250px;
    display: flex;
    flex-direction: column;
    box-sizing: border-box;
    width: 100%;
}

.cabecalho {
    background: rgb(26, 26, 26);
    display: flex;
    margin-bottom: 5px;
    border-top-left-radius: inherit;
     border-top-right-radius: inherit;
     padding: 15px;
}

.cabecalho div {
    display: flex;
    flex-direction: column;
}

.corpo {
    padding: 1% 3%;
    overflow-y: auto;
    max-height: 300px;
}
.corpo::-webkit-scrollbar {
  width: 5px;
  background: transparent;
}

.corpo::-webkit-scrollbar-thumb {
  border-radius: 10px;
  background: rgba(87, 86, 86, 0.637);
}

.corpo::-webkit-scrollbar-arrow {
  color: white;
  background: yellowgreen;
}

.tabela{
    width: 100%;
    text-align: center;
    border-radius: 50px;
     -webkit-border-radius: 25px;
       -moz-border-radius: 25px;
            border-radius: 25px;
}

th:first-child {
  padding: 5px 35px;
  text-align: start !important;
  border-radius:10px 0 0 0;
}

th{
  font-size: 1.3em;
  text-align: center;
  background: rgb(26,26,26);
  padding: 15px 20px;
}

tr {
  background: rgb(35,35,35);
  padding: 10px;
}

tr:first-child {
  border-radius: 10px;
}

tr:last-child {
  border-radius: 0 0 10px 10px;
}

tr:nth-child(2n+1) {
  background: rgb(40,40,40);
}

td{
  text-align: center;
}

tr:first-child td:first-child { border-top-left-radius: 10px; }
tr:first-child td:last-child { border-top-right-radius: 10px; }
tr:last-child td:first-child { border-bottom-left-radius: 10px; }
tr:last-child td:last-child { border-bottom-right-radius: 10px; }

.linha{
    display: flex;
    grid-gap: 15px;
    padding: 8px 20px;
    align-items: center;
}

.botao {
    font-size: 1.3em;
    border: none;
    width: fit-content;
    color: white;
    background-color: rgba(241, 174, 30, 0.863);
    border-radius: 9px;
    cursor: pointer;
    font-weight: 800;
    padding: 5px 10px;
    margin: 15px 0 15px 15px

    
}

.botao:hover {
    /*background-color: rgba(241, 174, 30, 1);*/
    background-color:rgb(228,180,78);
}

#cancelar{
   background: rgb(46, 48, 46);
   border: solid gray 2px;
}

#cancelar:hover{
   background: DimGray;
   border: solid gray 2px;
}

.icone{
    font-size: 1.8em;
}

.btns{
   justify-content: space-between;
   display:flex;

}
.data{
    padding:0;
}

img{
    width:50px;
    height: 50px;
    border-radius: 50px;
}

.input {
    box-sizing: border-box;
    border-radius: 10px;
    resize: none;
    width: 100%;
    padding: 10px 12px 6px 15px;
    outline: none;
    font-size: 1em;
    border: transparent;
}

p {
    margin: 0;
    color: white;
    padding: 3px;
    font-size: 1.2em;
}
.titulo{
    font-size: 2em;
}

textarea::-webkit-scrollbar {
  width: 10px;
  border-radius: 50px;
  background-color: #F5F5F5; }

textarea::-webkit-scrollbar-thumb {
  border-radius: 10px;
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.1);
  background-color: #D3D3D3; }
</style>
