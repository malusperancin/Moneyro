<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <div class="centro">
      <div id="texto">
        <p>Bem-vindo(a) de volta {{usuario.nome}}</p>
        <h1>Seu saldo é R$ {{usuario.saldo}}</h1>
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
import Perfil from "../shared/perfil/Perfil.vue";
import Mensagem from "../shared/mensagem/Mensagem.vue";

export default {
  components: {
    Menu,
    Perfil,
    mensagem: Mensagem
  },
  data() {
    return {
      mensagem: false,
      usuario: {
        id: -1,
        nome: "",
        saldo: 0.0
      },
      text: ""
    };
  },
  created() {
    this.$http
      .get("https://localhost:5001/api/usuarios/" + this.$session.get("id"))
      .then(dados => {
        dados = dados.body;
        this.usuario.id = dados.id;
        this.usuario.nome = dados.nome;
        this.usuario.saldo = dados.saldo;
      });

    document.title = "Bem-Vindah";    
  },
   beforeCreate() {
    if (!this.$session.exists()) {
      this.$router.push('/')
    }
  },
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