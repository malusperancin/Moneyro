<template>
  <div class="geral">
    <div class="nova-atividade">
      <div class="conteudo">
        <div class="cabecalho">
          <div class="info_professor">
            <img alt="" src="../../../images/perfil2.png" style="width: 50px; height: 50px;">
            <div class="infos">
              <strong><b>{{sala.professor}}</b></strong>
              <p>{{datahojebarra}} </p>
            </div>
          </div>
          <div class="campos">
            <strong><b>Título:</b></strong>
            <strong><b>Data de Entrega:</b></strong>
            <input class="input" 
            type="text"
            placeholder="Atividade 1 - Jogo"
            v-model="tarefa.descricao"/>
            <input type="datetime-local" class="data input" v-model="tarefa.dataEntrega">
          </div>
        </div>

        <div class="atividades">
          <div class="quadrado" :key="i" v-for="(ativ, i) in atividades">
            <img alt="" class="imagens" :src="'../src/images/' + ativ.foto + '.png'" >
          </div>
        </div>

        <div class="btns">
          <button class="botao" id="cancelar" v-on:click="$emit('fechar')">Cancelar</button>
          <button class="botao">Enviar</button>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
  
export default {
  props: ["sala", "postagens"],
  data() {
    return {
      datahojebarra: "",
      datahojetraco: "",
      tarefa: {
        id: 0,
        idSala: this.sala.id,
        descricao: "",
        data: "",
        dataEntrega: "",
        tipo: "atividade",
        idAtividade: 1
      },
      atividades: []
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
    },
     publicar(){
      this.$http
          .post("https://localhost:5001/api/postagens", this.tarefa)
          .then(response => {
            this.postagens.push(response.body);
            this.$emit('fechar');
          }, erro =>{
            console.log(erro);
          });
    }
  },
  created() {
    this.dataAtual();
    this.tarefa.data = this.datahojetraco;

    this.$http
      .get("https://localhost:5001/api/atividades")
      .then(
        response => {
          this.atividades = response.body;
        }, 
        erro =>{
          console.log(erro);
      });
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

.nova-atividade{
  height: 90%;
  width: 44%;
  display: flex;
  justify-content: center;
  align-items: center;
  box-sizing: border-box;
}

.conteudo {
  max-height: 90%;
  height: fit-content;
  color: hsl(0, 0%, 100%);
  background: hsl(120, 2%, 18%);
  border-radius: 5px;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  padding: 20px;
  overflow: auto;
}

.cabecalho {
  display: flex;
  flex-direction: column;
  margin-bottom: 20px;
}

.info_professor {
  display: grid;
  grid-template-columns: 60px 1fr;
  margin-bottom: 12px;
}

.campos {
  display: grid;
  grid-template-columns: 3fr 2fr;
  grid-template-rows: 1fr 1fr;
  grid-column-gap: 10px;
}

/* -------------------- */
.atividades{
  display: grid;
  grid-gap: 10px;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  overflow-y: scroll;
  max-height: 350px;
  min-height: 200px;
  padding-right: 15px;
  margin-bottom: 25px;
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

.btns{
  justify-content: space-between;
  display:flex;
}

.botao {
  font-size: 1em;
  border: none;
  color: white;
  background-color: rgba(241, 174, 30, 0.863);
  border-radius: 9px;
  cursor: pointer;
  font-weight: 800;
  padding: 5px 12px;
}

.botao:hover {
  background-color: rgba(241, 174, 30, 1);
}

.imagens{
  border-radius:10px;
  border: 3px solid transparent;
  width: 100%;
}

.imagens:hover{
  border:solid rgb(8, 90, 180) 3px;
}

#cancelar{
  background: rgb(46, 48, 46);
  border: solid gray 2px;
}

#cancelar:hover{
  background: DimGray;
  border: solid gray 2px;
}

.input{
  border: none;
  border-radius: 5px;
  padding: 3px 2px 3px 12px;
  font-size: 1em;
  outline: none;
}

.data{
  padding: 2px 2px 2px 12px;
}

p {
  margin: 0;
  color:white;
  padding: 3px;
}
</style>
