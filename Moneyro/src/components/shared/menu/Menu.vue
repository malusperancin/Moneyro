<template>
  <div id="menu">
    <table cellspacing="0" border="0" class="tb">
      <tr id="btnAdd">
        <td class="icones" id="btnAdd">
          <img src="../../../images/adicionar.png" alt="a" />
        </td>
        <td class="titulos">Adicionar</td>
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
          Sair
          <!-- <a v-on="sair()">Sair</a> -->
        </td>
      </tr>
    </table>
  </div>
</template>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
import $ from "jquery";
import { routes } from "../../../routes.js";

$(document).ready(function() {
  $(".titulos").hide();
  $("#menu").css("width", "3%");
  $(".icones").mouseenter(function() {
    $(".titulos").show();
  });
  $("#menu").mouseleave(function() {
    $(".titulos").hide();
    $("#menu").css("width", "3%");
  });
});

export default {
  data() {
    return {
      routes,
      active: false
    };
  }
};
</script>

<style scoped>
table {
  background-color: rgb(11, 83, 148);
  height: 100%;
  width: 100%;
  box-sizing: border-box;
  transition: all 0.5s;
}

.icones {
  background-color: #0c406f;
  width: 100%;
}

.icones img {
  width: 30px;
  display: table-column;
  padding: 5px;
  margin: auto;
}

table tr {
  width: 100%;
}

tr td:nth-child(2) {
  background: rgb(11, 83, 148);
  width: 100%;
  box-sizing: border-box;
}

.titulos:hover {
  background-color: #0c406f;
}

tr td:nth-child(1) {
  text-align: start;
}

#divisor {
  height: 209px;
}

.icones {
  padding: 12px;
  background-color: #0c406f;
}

.titulos {
  width: 70px;
  padding: 10px;
  padding-right: 25px;
  background: rgb(11, 83, 148);
  font-size: 1.1em;
}

a {
  text-decoration: none;
  color: rgb(0, 0, 0);
}

#menu {
  width: fit-content;
  transition: 1s;
  height: 100%;
  z-index: 5;
  position: absolute;
}

#btnAdd td {
  background-color: rgb(8, 45, 77);
  color: white;
}
</style>