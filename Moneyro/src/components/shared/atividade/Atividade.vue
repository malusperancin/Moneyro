<template>
  <div class="atividade">
    <div class="conteudo">
      <div class="cabecalho">
        <div class="infos">
          <img src="../../../images/perfil2.png">
          <div class="textos">
            <strong><b>{{nome}}</b></strong>
            <small>{{data}}</small>
          </div>
        </div>
        <strong class="nome_atividade"><b>{{infos.descricao}}</b></strong>
      </div>
    </div>
  </div>
</template>

<script>
  
export default {
  props: ["infos", "nome"],
  data() {
    return {
      data: ""
   };
  },
  methods: {
    
  },
  computed: {
    
  },
  created() {
    var a = new Date(this.infos.data);
      var dd = String(a.getDate()).padStart(2, '0');
      var mm = String(a.getMonth() + 1).padStart(2, '0'); //January is 0!
      var yyyy = a.getFullYear();
     
      this.data = dd + '/' + mm + '/' + yyyy;
   
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
