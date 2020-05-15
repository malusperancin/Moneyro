<template>
  <div id="menu" @mouseenter="ativo = true" @mouseleave="ativo = false">
    <table cellspacing="0" border="0">
      <tr id="btnAdd">
        <td class="icones">
          <img src="../../../images/adicionar.png" alt="a" />
        </td>
        <td class="titulos" @mouseenter="tipos = true" @mouseleave="tipos = false">
          <p>Adicionar</p>
          <table id="opcoesCard">
            <tr v-on:click="verCard = true">Despesa ou Receita</tr>
            <tr v-on:click="verMeta = true">Meta</tr>
          </table>
        </td>
      </tr>
      <tr v-on:click="$router.push('planilhas')">
        <td class="icones">
          <img src="../../../images/planilha.png" alt="a" />
        </td>
        <td class="titulos">Planilhas</td>
      </tr>
      <tr v-on:click="$router.push('comunidade')">
        <td class="icones">
          <img src="../../../images/comunidade.png" alt="a" />
        </td>
        <td class="titulos">Comunidade</td>
      </tr>
      <tr v-on:click="$router.push('relatorios')">
        <td class="icones">
          <img src="../../../images/relatorios.png" alt="a" />
        </td>
        <td class="titulos">Relatórios</td>
      </tr>
      <tr v-on:click="$router.push('amigos')">
        <td class="icones">
          <img src="../../../images/amigos.png" alt="a" />
        </td>
        <td class="titulos">Amigos</td>
      </tr>
      <tr v-on:click="$router.push('metas')">
        <td class="icones">
          <img src="../../../images/metas.png" alt="a" />
        </td>
        <td class="titulos">Metas</td>
      </tr>
      <tr id="divisor">
        <td class="icones"></td>
        <td></td>
      </tr>
      <tr v-on:click="$router.push('configuracoes')">
        <td class="icones">
          <img src="../../../images/configuracao.png" alt="a" />
        </td>
        <td class="titulos">Configurações</td>
      </tr>
      <tr v-on:click="$router.push('http://localhost:8080/#/')">
        <td class="icones">
          <img src="../../../images/sair.png" alt="a" />
        </td>
        <td class="titulos">
          Sair
          <!-- <a v-on="sair()">Sair</a> -->
        </td>
      </tr>
    </table>
    <Card v-on:fecharCard="verCard = false" v-if="verCard"></Card>
    <Meta v-on:fecharMeta="verMeta = false" v-if="verMeta"></Meta>
  </div>
</template>

<script>
import Card from "../cards/Card.vue";
import Meta from "../cards/Meta.vue";

export default {
  components: {
    Card,
    Meta
  },
  data() {
    return {
      ativo: false,
      tipos: false,
      verCard: false,
      verMeta: false
    };
  },
  methods: {},
  watch: {
    ativo() {
      var div = document.getElementsByClassName("titulos");
      if (this.ativo)
        for (var i = 0; i < div.length; i++)
          div.item(i).style = "display: flex";
      else
        for (var i = 0; i < div.length; i++)
          div.item(i).style = "display: none";
    },
    tipos() {
      var tipos = document.getElementById("opcoesCard");
      if (this.tipos) tipos.style = "display: block";
      else tipos.style = "display: none";
    }
  }
};
</script>

<style scoped>
#menu {
  width: fit-content;
  height: 100%;
  z-index: 5;
  position: fixed;
  box-shadow: 5px 0px 5px #00000040;
  overflow: auto;
}

table {
  background-color: rgb(11, 83, 148);
  height: 100%;
  box-sizing: border-box;
  transition: all 0.5s;
}

/* tr td:nth-child(2) {
} */

.icones {
  text-align: start;
  background-color: #0c406f;
  padding: 20px;
  cursor: pointer;
}

.icones img {
  width: 30px;
  display: table-column;
}

/* tr td:nth-child(2) {
} */

.titulos {
  box-sizing: border-box;
  padding-left: 15px;
  padding-right: 30px;
  background: rgb(11, 83, 148);
  font-size: 1.2em;
  height: 100%;
  display: none;
  cursor: pointer;
  align-items: center;
}

.titulos:hover {
  background-color: #0c406f;
}

#divisor {
  height: 100%;
}

#btnAdd td {
  background-color: rgb(8, 45, 77);
  color: white;
}

#opcoesCard {
  /* position: fixed;
  top: 0;
  left: 186px; */
  margin: 0;
  width: fit-content;
  height: fit-content;
}

#opcoesCard li {
  list-style: none;
  padding: 15px 20px;
  background: #0c406f;
  cursor: pointer;
}

#opcoesCard li:hover {
  background: rgb(8, 45, 77);
}
</style>