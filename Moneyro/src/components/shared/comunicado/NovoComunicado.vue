<template>
  <div class="geral">
    <div class="comunicado">
      <div class="conteudo">
        <div class="titulo">
          <img src="../../../images/perfil2.png" style="width: 50px">
          <div>
              <strong><b>{{sala.professor}}</b></strong>
              <p class="data">{{datahoje}} </p>
          </div>
        </div>
        <div class="texto">
          <textarea class="input" v-model="comunicado.descricao" type="text" rows="3" placeholder="Adicionar comentário..."/>  
        </div>
        <div class="btns">
          <button class="botao" id="cancelar" v-on:click="$emit('fechar')">Cancelar</button>
          <button class="botao" v-on:click="publicar()">Enviar</button>
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
      comunicado: {
        idSala: 0,
        descricao: "",
        data: new Date(),
        tipo: "comunicado",
        dataEntrega: new Date(),
        idAtividade: 1
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
        this.datahoje = diaF+"/"+mesF+"/"+anoF;
    },
    publicar(){
      this.comunicado.idSala = this.sala.id;
      this.$http
          .post("https://localhost:5001/api/postagens", this.comunicado)
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

.btns{
   justify-content: space-between;
   display:flex;

}
.data{
    padding:0;
}

img{
    width:100%;
    height: 100%;
}

.enviar {
    font-size: 1.75rem;
    color: gray;
    background: white;
    padding: 5px 10px;
    border-radius: 0 25px 25px 0;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.enviar:hover {
    color: black;
    cursor: pointer;
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
}

.comunicado {
    height: 100%;
    width: 80%;
    align-items: center;
    justify-content: center;
    display: flex;
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
    width:55%;
}

.titulo div {
    display: flex;
    flex-direction: column;
    margin-left: 2%;
}

.titulo {
    display: flex;
    margin-bottom: 5px;
}

.texto {
    padding: 1% 0;
}

.botao {
    font-size: 1em;
    border: none;
    width: fit-content;
    color: white;
    background-color: rgba(241, 174, 30, 0.863);
    border-radius: 9px;
    cursor: pointer;
    font-weight: 800;
    padding: 5px 10px;
    
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




textarea::-webkit-scrollbar {
  width: 10px;
  border-radius: 50px;
  background-color: #F5F5F5; }

textarea::-webkit-scrollbar-thumb {
  border-radius: 10px;
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.1);
  background-color: #D3D3D3; }
</style>
