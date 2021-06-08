<template>
  <div class="atividade">
    <div class="conteudo">
      <div class="cabecalho">
        <div class="infos">
          <img :src="'../../src/images/perfil'+$session.get('foto')+'.png'">
            <div class="textos">
              <strong><b>{{professor}}</b></strong>
              <small>{{dataView}}</small>
            </div>
        </div>
        <div v-on:click="excluir(atividade.id)" class="deletar_icone">
          <ion-icon name="trash"></ion-icon>
        </div>
      </div>
      <div class="infos_atividade">
        <div class="nome_atividade">
          {{atividade.descricao}}
        </div>
        <div class="data_atividade">
          Data entrega: <strong> {{dataEntregaView}}</strong>
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
      dataEntregaView: '',
      dataView:'',
      imgProf:''  
    };
  },
  methods: {
    excluir(id) {
        this.$http
            .delete("https://localhost:5001/api/postagens/"+id)
            .then(
                response => {
                    this.$emit('deletada', id);
                }, 
                erro =>{
                    console.log(erro);
            });
    }
  },
  computed: {
    
  },
  created() {
    var a = new Date(this.atividade.data);

    var dd = String(a.getDate()).padStart(2, '0');
    var mm = String(a.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = a.getFullYear();
    
    this.dataView= dd + '/' + mm + '/' + yyyy;

    var b = new Date(this.atividade.dataEntrega);
    dd = String(b.getDate()).padStart(2, '0');
    mm = String(b.getMonth() + 1).padStart(2, '0'); //January is 0!
    yyyy = b.getFullYear();

    this.dataEntregaView =  dd + '/' + mm + '/' + yyyy;
  },
  watch: {
    expanded(){
      
    }
  },
};

</script>

<style scoped>
.conteudo:hover {
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
  padding: 30px 30px 15px 30px;
}

.cabecalho{
  display:flex;
  flex-direction:row;
  justify-content: space-between;
  font-size: 1.2em;
}

.infos {
  display: flex;
  width: 100%;
}

.deletar_icone {
    border: 1px solid grey;
    height: fit-content;
    padding: 5px;
    line-height: 0;
    border-radius: 87px;
    color: grey;
    transition: all 0.1s easy-in !important;
    cursor: pointer;
}

.deletar_icone:hover {
    color: white;
    background: rgb(211, 49, 49);
}

p {
  margin: 0;
  color:white;
  padding: 3px;
}

.textos {
  display: flex;
  flex-direction: column;
  margin-left: 20px;
}

img{
  border-radius: 8px;
  width: 55px;
  height: 55px;
}

.infos_atividade{
  padding: 15px 0 0 0;
  display: flex;
  justify-content: space-between;
}

.nome_atividade {
  font-size: 1.5em;
}

.data_atividade {
  display: flex;
  align-items: flex-end;
}

.data_atividade strong{
    padding-left: 8px;
}

</style>
