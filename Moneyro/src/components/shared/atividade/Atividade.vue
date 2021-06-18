<template>
  <div class="atividade">
    <Mensagem
      :msg="msg"
      v-if="msg.visivel" 
      v-on:cancelar="msg.visivel = false"
      v-on:excluir="$emit('excluirPostagem', atividade.id)"/>
    <div class="conteudo">
      <div class="cabecalho">
        <div class="infos">
          <img :src="'../../src/images/perfil'+professor.foto+'.png'">
            <div class="textos">
              <strong><b>{{professor.nome}}</b></strong>
              <small>{{dataView}}</small>
            </div>
        </div>
        <div v-if="professor.id == $session.get('usuario').id" class="acoes">
            <div v-on:click="$emit('tabela', atividade.id)" class="ver_icone">
                <ion-icon name="eye"></ion-icon>
            </div>
            <div v-on:click="msgExluir()" class="deletar_icone">
                <ion-icon name="trash"></ion-icon>
            </div>
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
import Mensagem from "../../shared/mensagem/Mensagem.vue";

export default {
  props: ["atividade", "professor"],
  components: {
      Mensagem
  },
  data() {
    return {
      dataEntregaView: '',
      dataView:'',
      msg: {
        visivel: false,
        titulo: "",
        mensagem: "",
        botoes: []
      }  
    };
  },
  methods: {
    msgExluir(id) {
      this.msg = {
          visivel: true,
          titulo: "Excluir Postagem",
          mensagem: "Deseja mesmo excluir essa postagem de forma definitiva?",
          botoes: [
              {
                  mensagem: "Cancelar",
                  evento: "cancelar",
              },
              {
                  mensagem: "Sim",
                  evento: "excluir",
              }
          ],
      };
    }
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
  padding: 30px 30px 25px 30px;
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

.acoes {
    display: flex;
    grid-gap: 6px;
}

.deletar_icone, .ver_icone {
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

.ver_icone:hover {
    color: white;
    background: grey;
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
  flex-direction: column;
}

.nome_atividade {
  font-size: 1.5em;
}

.data_atividade {
  text-align: end;
}

.data_atividade strong{
    padding-left: 8px;
}

</style>
