<template>
  <div id="menu" @mouseenter="ativo = true" @mouseleave="ativo = false">
    <table cellspacing="0" border="0">
      <tr id="btnAdd">
        <td class="icones">
          <img src="../../../images/adicionar.png" alt="a" />
        </td>
        <td class="titulos" @mouseenter="tipos = true" @mouseleave="tipos = false">
          <p>Adicionar</p>
          <ul id="opcoesCard">
            <li v-on:click="abrirCard">Despesa ou Receita</li>
            <li v-on:click="abrirMeta">Meta</li>
          </ul>
        </td>
      </tr>
      <tr>
        <td class="icones">
          <img src="../../../images/planilha.png" alt="a" />
        </td>
        <td class="titulos">
          <router-link to="/planilhas">Planilhas</router-link>
        </td>
      </tr>
      <tr>
        <td class="icones">
          <img src="../../../images/comunidade.png" alt="a" />
        </td>
        <td class="titulos">
          <router-link to="/comunidade">Comunidade</router-link>
        </td>
      </tr>
      <tr>
        <td class="icones">
          <img src="../../../images/relatorios.png" alt="a" />
        </td>
        <td class="titulos">
          <router-link to="/relatorios">Relatórios</router-link>
        </td>
      </tr>
      <tr>
        <td class="icones">
          <img src="../../../images/amigos.png" alt="a" />
        </td>
        <td class="titulos">
          <router-link to="/amigos" class="menuIcon">Amigos</router-link>
        </td>
      </tr>
      <tr>
        <td class="icones">
          <img src="../../../images/metas.png" alt="a" />
        </td>
        <td class="titulos">
          <router-link to="/metas">Metas</router-link>
        </td>
      </tr>
      <tr id="divisor">
        <td class="icones"></td>
        <td></td>
      </tr>
      <tr>
        <td class="icones">
          <img src="../../../images/configuracao.png" alt="a" />
        </td>
        <td class="titulos">
          <router-link to="/configuracoes">Configurações</router-link>
        </td>
      </tr>
      <tr>
        <td class="icones">
          <img src="../../../images/sair.png" alt="a" />
        </td>
        <td class="titulos">
          <router-link to="/" style="color: black">Sair</router-link>
          <!-- <a v-on="sair()">Sair</a> -->
        </td>
      </tr>
    </table>
    <Card v-on:fecharCard="fechar('card')" v-if="card"></Card>
    <Meta v-on:fecharMeta="fechar('meta')" v-if="meta"></Meta>
  </div>
</template>

<script>
import Card from "../cards/Card.vue";
import Meta from "../cards/Metas.vue";

export default {
  components: {
    Card,
    Meta
  },
  data() {
    return {
      ativo: false,
      tipos: false,
      card: false,
      meta: false
    };
  },
  methods: {
    abrirCard: function() {
      this.card = true;
    },
    abrirMeta: function() {
      this.meta = true;
    },
    fechar(comp) {
      if (comp == "meta") {
        this.meta = false;
      } else {
        this.card = false;
      }
    }
  },
  watch: {
    ativo() {
      var div = document.getElementsByClassName("titulos");
      if (this.ativo)
        for (var i = 0; i < div.length; i++)
          div.item(i).style = "display: block";
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
}

.titulos:hover {
  background-color: #0c406f;
}

.titulos a {
  text-decoration: none;
  color: rgb(0, 0, 0);
  float: left;
  margin-top: 18px;
}

#divisor {
  height: 100%;
}

#btnAdd td {
  background-color: rgb(8, 45, 77);
  color: white;
}

#opcoesCard {
  position: fixed;
  top: 0;
  left: 186px; /*arrumar esse left*/
  margin: 0;
  width: fit-content;
  height: fit-content;
  display: none;
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