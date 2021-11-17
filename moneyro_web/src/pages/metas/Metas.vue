<template>
  <div class="pag">
    <Menu v-on:atualizar="getTodos()"/>
    <Perfil />
    <Topo />
    <Meta v-if="verMeta" :id="id" 
      v-on:mostrarMsg="mostrarMensagem" 
      v-on:atualizar="getTodos" 
      v-on:fechar="verMeta = false"  
      v-on:msgNaoAbrir="mensagemNao" 
      v-on:deletou="msgDeletou"/>
    <Mensagem
      :msg="msg"
      v-if="msg.visivel"
      v-on:fechar="msg.visivel = false"
    ></Mensagem>
    <div class="centro">
      <div id="lista-metas">
        <div v-if="!metas[0]">
          <h1 style="color: white">Você ainda não adicionou nenhuma meta! Mas... nada te impede de iniciar uma agora!</h1>
        </div>
        <div v-else class="lista-metas-item" v-for="(meta, i) in metas" :key="i" v-on:click="abrirMeta(i)">
          <Painel
            :id="meta.id"
            :nome="meta.nome"
            :objetivo="meta.objetivo"
            :atual="meta.atual"
            :dataLimite="formataData(meta.dataLimite)"
            :compartilhado="meta.compartilhamentos"
            v-on:fecharMeta="verMeta = false"
          ></Painel>
        </div>
        <div style="color: white">
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/perfil/Perfil.vue";
import Meta from "../shared/cards/Meta.vue";
import Painel from "./components/Meta-Exibicao.vue";
import Topo from "../shared/voltar-topo/Voltar-Topo.vue";
import Mensagem from "../shared/mensagem/Mensagem.vue";

export default {
  components: {
    Menu,
    Perfil,
    Meta,
    Painel,
    Topo,
    Mensagem
  },
  data() {
    return {
      metas: [],
      verMeta: false,
      id: null,
      pessoas: [],
      msg: {
        visivel: false,
        titulo: "",
        mensagem: "",
        botoes: []
      },
    };
  },
  methods: {
    msgDeletou(){
            this.msg.titulo = "Sucesso!";
            this.msg.mensagem = "Meta deletada com sucesso!";
            this.msg.botoes = [
             {
               mensagem: "Ok",
               evento: "fechar"
             }
            ];
            this.msg.visivel = true;
    },
    mensagemNao(){
          this.verMeta = false;
          this.msg.titulo = "Ops :P";
            this.msg.mensagem = "Você não pode mudar os compartilhados pois não é o criador dessa meta!";
            this.msg.botoes = [
             {
               mensagem: "Ok",
               evento: "fechar"
             }
            ];
            this.msg.visivel = true;
    },
    mostrarMensagem(){
            this.msg.titulo = "Alteração";
            this.msg.mensagem = "Alteração na meta feita com sucesso!";
            this.msg.botoes = [
             {
               mensagem: "Ok",
               evento: "fechar"
             }
            ];
            this.msg.visivel = true;
    },
    abrirMeta(indice) {
      this.id = this.metas[indice].id;
      this.verMeta = true;
    },
    //2020-06-12
    formataData(data) {
      data = data.substring(0,10);
      var ano = data.split("-")[0];
      var mes = data.split("-")[1];
      var dia = data.split("-")[2];
      return ("0" + dia).slice(-2) + "/" + ("0" + mes).slice(-2) + "/" + ano;
      // Utilizo o .slice(-2) para garantir o formato com 2 digitos.
    },
    getUsuario(id, i){
      this.$http
      .get("https://localhost:5001/api/usuarios/" + id)
      .then(dados => { 
        this.metas[i].compartilhamentos.push({
          id: dados.body.id,
          nome: dados.body.nome,
          foto: dados.body.foto
        });
      }, erro => {
        alert("algo deu errado metakkk" + erro.bodyText);
      });
    },
    getTodos(){
      this.$http.get("https://localhost:5001/api/metas/usu/" + this.$session.get("id"))
      .then(dados => {
        this.metas = dados.body;

        this.metas.map( m => {
          if(m.compartilhamentos)
            m.compartilhamentos = m.compartilhamentos.trim().split(" ").map(Number);
        });

        for (var i = 0; i < this.metas.length; i++)
          if(this.metas[i].compartilhamentos)
          {
              this.metas[i].compartilhamentos.map(c => {
                this.getUsuario(c, i)
              }); 
          
              if(this.metas[i].idUsuario != this.$session.get("id"))
               this.getUsuario(this.metas[i].idUsuario, i);       
          }
      },
      erro => {
        alert("algo deu errado meta");
      });
    },
  },
  created(){
    document.title = "Metas";

    this.getTodos();
  },
  beforeCreate() {
    if (!this.$session.exists())
      this.$router.push('/')
  }  
};
</script>

<style scoped>
#lista-metas {
  margin-top: 20px;
  list-style: none;
  width: 100%;
}

#lista-metas .lista-metas-item {
  display: inline-flex;
  margin: 0.5%;
}
</style>

