<!-- alunopic/src/components/shared/painel/Painel.vue -->
<template>
  <div class="painel">
    <div class="delete"></div>
    <table>
      <tr>
        <td colspan="2" class="tdNome">
          <p class="nome">{{ nome }}</p>
        </td>
      </tr>
      <tr class="tr">
        <td class="tdImg">
          <img class="imgPerfil" :src="'../src/images/perfil' + foto + '.png'" />
        </td>
        <td>
          <p class="comp">Shared</p>
        </td>
      </tr>
    </table>
    <div class="delete">
      <div class="iconeDel">
        <img class="imgDeletar" src="src/images/remAmigo.png" />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["id", "nome", "foto"],
  data() {
    return {
      visivel: true
    };
  },
  methods: {
    func() {
      alert(1);
    }
  }
};
</script>

<style scoped>
.painel {
  padding: 3px 10px 10px 10px;
  width: 250px;
  border-radius: 10px;
  background: #ecb318;
}

.imgPerfil {
  width: 95px;
  border: none;
  border-radius: 30px;
  box-shadow: 5px 5px 10px #00000040;
  margin-right: -25px;
}

.tr {
  padding: 0;
  margin: 0;
}

td {
  /* background: red; */
  margin: 0;
  padding: 0;
}

.nome {
  font-weight: bold;
  font-size: 1.3em;
  display: inline;
}

.tdNome {
  text-align: center;
}

.iconeDel {
  background: rgb(240, 49, 49);
  border-radius: 10px;
  padding: 4px;
}

.iconeDel:hover {
  background-color: rgb(250, 14, 14);
}

.comp {
  background: rgb(255, 226, 96);
  border-radius: 10px;
  padding: 5px 10px;
  text-align: center;
  box-sizing: border-box;
  margin: 10px;
  font-size: 1.1em;
  margin-top: 10px;
  margin-bottom: 3px;
}

.imgDeletar {
  width: 25px;
  border: 2px;
  padding: 4px;
}

.delete {
  width: fit-content;
  position: absolute;
  margin-left: 230px;
  margin-top: -25px;
  cursor: pointer;
}

table {
  width: 100%;
  box-sizing: border-box;
}
</style>
