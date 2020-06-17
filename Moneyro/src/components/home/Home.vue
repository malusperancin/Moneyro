<template>
  <div class="pag">
    <cabecalho :titulo="'Moneyro'"></cabecalho>
    <div id="inicio">
      <div class="frase">
        <h2>Bem Vinda(o), </h2> ao melhor aplicativo de finanças pessoais para jovens deste Brasil! <br>  
        <br>
        <small>
          Tá duvidando? <b>Só vem!</b>  
        </small> 
      </div>
      <div class="container">
        <img id="imgCenter" src="src/images/Imagem1.png" alt />
        <div id="botoes">
          <button v-on:click="login = true">Login</button>
          <button v-on:click="$router.push('cadastro')">Cadastro</button>
        </div>
      </div>
    </div>
    <div id="porque">
      <h3 id="titulo">
        <b>Por que eu devo usar o Moneyro?</b>
      </h3>
      <table>
        <tr>
          <td class="pqs">
            <img src="src/images/1.png" />
            <p class="titulo">Controlar seu dinheiro direitin</p>
          </td>
          <td class="pqs">
            <img src="src/images/2.png" />
            <p class="titulo">Não gastar com besteira</p>
          </td>
          <td class="pqs">
            <img src="src/images/3.png" />
            <p class="titulo">Se informar sobre economia</p>
          </td>
          <td class="pqs">
            <img src="src/images/4.png" />
            <p class="titulo">Layout simples, belo e fácil</p>
          </td>
        </tr>
        <tr>
          <td class="pqs">
            <img src="src/images/5.png" />
            <p class="titulo">Analisar seus gastos</p>
          </td>
          <td class="pqs">
            <img src="src/images/6.png" />
            <p>Receber diquinhas</p>
          </td>
          <td class="pqs">
            <img src="src/images/7.png" />
            <p>
              Feito especialmente para você,
              <br />jovem gafanhoto
            </p>
          </td>
          <td class="pqs">
            <img src="src/images/8.png" />
            <p class="titulo">O jeito mais moneyro de economizar!</p>
          </td>
        </tr>
      </table>
    </div>
    <login v-if="login" v-on:fechar="login = false"></login>
  </div>
</template>

<script>
import Login from "../shared/login/Login.vue";
import Header from "../shared/cabecalho/Cabecalho.vue";

export default {
  components: {
    login: Login,
    cabecalho: Header
  },
  data() {
    return {
      login: false
    };
  },
  methods: {},
  created(){
    document.title = "Moneyro";
  },
  beforeCreate() {
    if(this.$session.exists())
      this.$router.push("usuario");
  },
};
</script>

<style scoped>
#titulo {
  text-align: center;
  padding-top: -15px;
  padding-bottom: 15px;
}

a {
  text-decoration: none;
  color: black;
}

#inicio {
  width: 100%;
  background-color: rgb(255, 227, 74);
  padding-top: 100px;
  display: flex;
}

.frase{
  font-size: 45px;
  flex: 1;
  padding: 30px 70px;
  text-align: left;
  display: flex;
  flex-direction: column;
}

.container{
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  flex: 1.2;
  padding: 90px 100px 60px;
}

#imgCenter {
  margin: -5vh 0;
  width: 40vw;
}

h2{
  margin: 25px 0;
}

#botoes button {
  font-size: 1.8em;
  font-weight: bolder;
  border-radius: 2px;
  border: 0;
  padding: 15px;
  box-sizing: border-box;
  box-shadow: 1px black;
  text-align: center;
  background-color: rgb(241 194 50);
  z-index: 1;
  cursor: pointer;
  color: #000;
  /* margin: 0px 20px; */
  flex: 0.4;
}

#botoes button:hover {
  box-shadow: 5px -5px rgba(245, 147, 35);
}

#botoes {
  display: flex;
  justify-content: center;
  justify-content: space-between;
  width: 100%;
}

#porque {
  background-color: rgb(241, 194, 50);
  font-size: 1.5em;
  padding: 10px;
}

table {
  margin: auto;
}

td {
  margin: auto;
  width: 130px;
}

.pqs {
  font-size: 15px;
  text-align: center;
  float: left;
  font-weight: bold;
  margin: 10px;
}

.pqs img {
  width: 50px;
}
</style>


