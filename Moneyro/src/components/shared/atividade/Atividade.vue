<template>
  <div class="atividade">
    <div class="conteudo">
      <div class="cabecalho">
        <div class="infos">
          <img src="../../../images/perfil2.png">
          <div class="textos">
            <strong>{{professor}}</strong>
            <small>{{atividade.data}}</small>
          </div>
        </div>
      </div>
      <div class="infos_atividadee">
        <div class="nome_atividade">
          {{atividade.descricao}}
        </div>
        <div class="data_atividade">
          Data entrega: <strong>{{atividade.dataEntrega}}</strong>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  
export default {
  props: ["atividade", "professor"],
  data() {
    return {
   };
  },
  methods: {
    
  },
  computed: {
    
  },
  created() {
    var a = new Date(this.atividade.data);

    var dd = String(a.getDate()).padStart(2, '0');
    var mm = String(a.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = a.getFullYear();
    
    this.atividade.data = dd + '/' + mm + '/' + yyyy;

    var b = new Date(this.atividade.dataEntrega);
    dd = String(b.getDate()).padStart(2, '0');
    mm = String(b.getMonth() + 1).padStart(2, '0'); //January is 0!
    yyyy = b.getFullYear();

    this.atividade.dataEntrega = dd + '/' + mm + '/' + yyyy;
   
  },
  watch: {
    expanded(){
      
    }
  },
};

</script>

<style scoped>
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
  padding:30px;
}

.cabecalho{
    display: flex;
    flex-direction:row;
    justify-content: space-between;
    align-items: center;
    font-size: 1.4em;
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

.nome_atividade {
  padding: 0 25px;
}

.textos {
  display: flex;
  flex-direction: column;
  margin-left: 4%;
}

img{
  width: 55px;
  height: 55px;
  border-radius: 8px;
}

.infos_atividade{
  display: flex;
  flex-direction: column;
}

</style>
