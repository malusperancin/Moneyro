<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <div class="centro">
      <div id="lista-metas">
        <div id="lista-metas-item" v-for="(meta, i) in metas" :key="i">
          <Painel
            :id="meta.id"
            :nome="meta.nome"
            :objetivo="meta.objetivo"
            :atual="meta.atual"
            :dataLimite="meta.dataLimite"
            :compartilhado="meta.compartilhado"
          ></Painel>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/float-perfil/Float-Perfil.vue";
import Meta from "../shared/cards/Meta.vue";
import Painel from "../shared/meta/Meta.vue";

export default {
  components: {
    Menu,
    Perfil,
    Meta,
    Painel
  },
  data() {
    return {
      metas: [
        {
          id: 1,
          atual: "1",
          objetivo: "3",
          nome: "Open de Caldicana😎😎",
          dataLimite: "01/05/2020"
          // compartilhado: [
          //     { id: 1,
          //     nome: "Maria",
          //     foto: 6 },
          //     {"Giovanna"}]
        },
        {
          id: 2,
          atual: "50",
          objetivo: "3000",
          nome: "cerular",
          dataLimite: "15/06/2020",
          compartilhado: null
        },
        {
          id: 3,
          atual: "120",
          objetivo: "120",
          nome: "Boot da naike",
          dataLimite: "04/05/2020",
          compartilhado: null
        },
        {
          id: 4,
          atual: "1",
          objetivo: "3",
          nome: "Presentenho da mamae",
          dataLimite: "01/05/2020",
          compartilhado: ["Vinicius"]
        },
        {
          id: 5,
          atual: "3",
          objetivo: "3",
          nome: "Presentenho da mamae",
          dataLimite: "01/05/2020",
          compartilhado: null
        }
      ]
    };
  }
};
</script>

<style scoped>
#lista-metas {
  margin-top: 20px;
  list-style: none;
  width: 100%;
}

#lista-metas #lista-metas-item {
  display: inline-block;
  margin: 0.5%;
}
</style>

