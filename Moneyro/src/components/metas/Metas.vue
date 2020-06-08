<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <Topo />
    <Meta v-if="verMeta" :id="id" v-on:fecharMeta="verMeta = false" />
    <div class="centro">
      <div id="lista-metas">
        <div class="lista-metas-item" v-for="(meta, i) in metas" :key="i" v-on:click="abrirMeta(i)">
          <Painel
            :id="meta.id"
            :nome="meta.nome"
            :objetivo="meta.objetivo"
            :atual="meta.atual"
            :dataLimite="formataData(meta.dataLimite)"
            :compartilhado="meta.compartilhado"
            v-on:fecharMeta="verMeta = false"
          ></Painel>
        </div>
        <div style="color: white">
          {{metas}}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/perfil/Perfil.vue";
import Meta from "../shared/cards/Meta.vue";
import Painel from "../shared/meta-exibicao/Meta-Exibicao.vue";
import Topo from "../shared/voltar-topo/Voltar-Topo.vue";

export default {
  components: {
    Menu,
    Perfil,
    Meta,
    Painel,
    Topo
  },
  data() {
    return {
      metas: [],
      verMeta: false,
      id: null
    };
  },
  methods: {
    abrirMeta(indice) {
      this.id = this.metas[indice].id;
      this.verMeta = true;
    },
    formataData(data) {
      data = data.substring(0,10);
      var ano = data.split("-")[0];
      var mes = data.split("-")[1];
      var dia = data.split("-")[2];
      return ("0" + dia).slice(-2) + "/" + ("0" + mes).slice(-2) + "/" + ano;
      // Utilizo o .slice(-2) para garantir o formato com 2 digitos.
    },
    getUsuario(id, i)
    { 
      this.$http
      .get("https://localhost:5001/api/usuarios/" + id)
      .then(dados => {
        this.metas[i].compartilhamentos.push({
          id: dados.body.id,
          nome: dados.body.nome,
          foto: dados.body.foto
        })
      }, erro => {
        alert("algo deu errado meta");
      });
    }
  },
  computed: {
    // Get all metas order by data e concluida
  },
  mounted() {
    //
  },
  created(){
    document.title = "Metas";

    this.$http
      .get("https://localhost:5001/api/metas")
      .then(dados => {
        this.metas = dados.body;

        for(var i = 0; i < dados.body.length; i++)
        {
          var ids = this.metas[i].compartilhamentos.trim().split(/(\s+)/);
          this.metas[i].compartilhamentos = [];
          
          for(var j = 0; j < ids.length; j++)
            this.methods.getUsuario(ids[j]);
            
        }
      }, erro => {
        alert("algo deu errado meta");
      });

      // { 
      //   id: 1,
      //   nome: "Open de Caldicana😎😎",
      //   atual: "1",
      //   objetivo: "3",
      //   dataLimite: "2020-05-01",
      //   compartilhado: [
      //     { id: 1, nome: "Maria", foto: 6 },
      //     { id: 2, nome: "Giovanna", foto: 11 }
      //   ]
      // },

      // meta: {
      //   idUsuario: this.$session.get("id"),
      //   nome: "",
      //   objetivo: 0,
      //   atual: 0,
      //   dataLimite: Date,
      //   compartilhamentos: ""
      // },
  },
  beforeCreate() {
    if (!this.$session.exists()) {
      this.$router.push('/')
    }
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
  display: inline-block;
  margin: 0.5%;
}
</style>

