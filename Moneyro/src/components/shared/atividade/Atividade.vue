<template>
  <div class="atividade">
    <div class="conteudo">
      <div class="cabecalho">
        <div class="infos">
          <img src="../../../images/perfil2.png">
          <div class="textos">
            <strong><b>{{professor.nome}}</b></strong>
            <small>{{comunicado.data}}</small>
          </div>
        </div>
        <strong class="nome_atividade"><b> Atividade numero 1 - Quiz</b></strong>
      </div>
    </div>
  </div>
</template>

<script>
  
export default {
  data() {
    return {
        sala:{
        nome: "Sala da Maria Luzia",
        codigo: "x5f7h6"
      },
      professor: {
        nome: "Maria Luzia", 
      },
      comunicado: {
        texto: "Informamos: Fuleco faleceu!",
        data: "12/02/2004"
      },
   };
  },
  methods: {
    
  },
  computed: {
    
  },
  created() {
   
  },
  watch: {
    expanded(){
      
    }
  },
};

</script>

<style scoped>

.atividade{
  width: 80%;
  align-items: center;
}

.atividade :hover {
  background: rgb(60, 62, 60);
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
}

.cabecalho{
    display: flex;
    flex-direction:row;
    justify-content: space-between;
    align-items: center;
    padding:30px;
    font-size:1.5em;
}

p {
  margin: 0;
  color:white;
  padding: 3px;
}

.infos{
  display:flex;
  flex-direction:row;
  width: 50%;
}

.textos {
  display: flex;
  flex-direction: column;
  margin-left: 4%;
}

img{
  width:75px;
  height:75px;
  border-radius: 8px;
}
</style>
