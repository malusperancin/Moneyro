<template>
  <div id="menu">
    <table cellspacing="0" border="0">
      <tr id="btnAdd">
        <td class="icones">
          <img src="../../../images/adicionar.png" alt="a" />
        </td>
        <td class="titulos">
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
    <div id="card">
      <card-dual v-on:fecharCard="fechar('card')" v-if="card"></card-dual>
    </div>
    <div id="meta">
      <card-meta v-on:fecharMeta="fechar('meta')" v-if="meta"></card-meta>
    </div>
  </div>
</template>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
import $ from "jquery";

$(document).ready(function() {
  $(".titulos").hide();

  $(".icones").mouseenter(function() {
    $(".titulos").show();
  });
  $("#menu").mouseleave(function() {
    $(".titulos").hide();
  });

  $("#btnAdd").mouseenter(function() {
    $("#opcoesCard").css("display", "block");
  });

  $("#btnAdd").mouseleave(function() {
    $("#opcoesCard").css("display", "none");
  });
});

import Card from "../cards/Card.vue";
import Meta from "../cards/Metas.vue";

export default {
  components: {
    "card-dual": Card,
    "card-meta": Meta
  },
  data() {
    return {
      active: false,
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
  events: {
    fecharMeta() {
      this.fechar("meta");
    },
    fecharCard() {
      this.fechar("card");
    }
  }
};
</script>

<style scoped>
/*
@keyframes fadein {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

@keyframes fadeout {
  from {
    opacity: 1;
  }
  to {
    opacity: 0;
  }
}

 #meta,
#card {
  opacity: 1;
  -webkit-trasition: opacity 0.3s ease-in-out;
  -moz-transition: opacity 0.3s ease-in-out;
  -ms-transition: opacity 0.3s ease-in-out;
  -o-transition: opacity 0.3s ease-in-out;
  transition: opacity 0.3s ease-in-out;
}

#meta.fade {
  opacity: 0;
}
#card.fade {
  opacity: 0;
} 

*/

#menu {
  width: fit-content;
  height: 100%;
  z-index: 5;
  position: fixed;
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
}

.titulos:hover {
  background-color: #0c406f;
}

#divisor {
  height: 100%;
}

a {
  text-decoration: none;
  color: rgb(0, 0, 0);
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