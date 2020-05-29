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
      metas: [
        {
          id: 1,
          atual: "1",
          objetivo: "3",
          nome: "Open de Caldicana😎😎",
          dataLimite: "2020-05-01",
          compartilhado: [
            { id: 1, nome: "Maria", foto: 6 },
            { id: 2, nome: "Giovanna", foto: 11 }
          ]
        },
        {
          id: 2,
          atual: "50",
          objetivo: "3000",
          nome: "cerular",
          dataLimite: "2020-06-15",
          compartilhado: null
        },
        {
          id: 3,
          atual: "120",
          objetivo: "120",
          nome: "Boot da naike",
          dataLimite: "2020-07-10",
          compartilhado: null
        },
        {
          id: 4,
          atual: "1",
          objetivo: "3",
          nome: "Presentenho da mamae",
          dataLimite: "2021-03-04",
          compartilhado: [{ id: 4, nome: "Vinícius", foto: 7 }]
        },
        {
          id: 5,
          atual: "3",
          objetivo: "3",
          nome: "Presentenho da mamae",
          dataLimite: "2020-06-02",
          compartilhado: null
        }
      ],
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
      var ano = data.split("-")[0];
      var mes = data.split("-")[1];
      var dia = data.split("-")[2];
      return ("0" + dia).slice(-2) + "/" + ("0" + mes).slice(-2) + "/" + ano;
      // Utilizo o .slice(-2) para garantir o formato com 2 digitos.
    }
  },
  computed: {
    // Get all metas order by data e concluida
  },
  mounted() {
    //
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

