<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <Mensagem
      v-if="mensagem"
      v-on:ok="mensagem = false"
      mensagem="Receita registrada com sucesso!"
      titulo="Toma o titulo"
      sair="oi"
    ></Mensagem>
    <div class="centro">
      <div id="texto">
        <p>Bem-vindo(a) de volta {{info.body.nome}}</p>
        <h1>Seu saldo é R$ {{info.body.saldo}}</h1>
        <h4>
          seu saldo ta ruim seu gastao irreponsavel tsc tsc...
          <br />OU ai q bonitineo c ta no positivo
        </h4>
      </div>
    </div>
  </div>
</template>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/float-perfil/Float-Perfil.vue";
import Mensagem from "../shared/mensagem/Mensagem.vue";

export default {
  components: {
    Menu,
    Perfil,
    Mensagem
  },
  data() {
    return {
      info: "",
      mensagem: false
    };
  },
  methods: {},
  mounted() {
    this.$http.get("https://localhost:5001/api/usuarios/2").then(response => {
      this.info = response;
    });
    alert(this.$session.id());
  }
};
</script>

<style scoped>
#texto {
  margin: auto;
  text-align: center;
}
#texto p {
  margin-top: 10%;
  margin-bottom: 50px;
}
</style>