<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <Mensagem mensagem="Receita registrada com sucesso!" id="msg"></Mensagem>
    <div class="centro">
      <div id="texto">
        <p>Bem-vindo(a) de volta geraldo13</p>
        <h1>Seu saldo é R$-90,00</h1>
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
      info: ""
    };
  },
  methods: {},
  mounted() {
    // this.$http.get("https://localhost:5001/api/aluno").then(response => {
    //   this.info = response;
    // });
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