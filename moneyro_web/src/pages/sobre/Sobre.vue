<template>
  <div class="pag">
    <cabecalho :titulo="'Moneyro'"></cabecalho>

    <div id="porque">
      <h3 id="titulo">
        <b>O que é o Moneyro?</b>
      </h3>
      <p id="texto"> Moneyro é um aplicativo de gestao financeira para crianças e adolescentes. <br> 
      É um conjunto de tecnologias, composto por um site e um aplicativo mobile para crianças e jovens de 6 a 18 anos, que contém jogos, 
      simulações, parte de seleção de conteúdos, a sua própria área de gestão financeira e um produto à parte: o cofre tecnológico que separa 
      e conta o seu dinheiro.
      </p>
      <h3 id="titulo">
        <b>Por que eu devo usar o Moneyro?</b>
      </h3>
      <table id="tablepq">
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
      <h3 id="titulo">
        <b>Qual nosso objetivo?</b>
      </h3>
      <p id="texto"> Com o Moneyro, visamos tornar o ensino de gestão financeira pessoal mais acessível e eficiente para crianças e jovens do Brasil.
     <br> Buscamos, portanto, incentivar a educação financeira da população brasileira desde cedo para que, futuramente, tenhamos mais adultos responsáveis e financeiramente saudáveis. <br>
Gestão financeira pessoal não é apenas quanto dinheiro devo gastar ou não, nisso ou naquilo, mas é sobre ser cidadão, ter um consumo consciente e sustentável, e ser uma dona ou um dono responsável do seu próprio dinheiro. 

  </p>
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

  },
};
</script>

<style scoped>
.pag {
}

@media only screen and (max-width: 1000px) {
  #inicio {
    padding-top: 70px !important;
  }

  .container{
    padding: 30px 80px 40px !important;
  }

  .frase{
    font-size: 35px !important;
    padding: 20px 40px !important;
  }

  #botoes button {
    font-size: 1.8em !important;
    padding: 8px 18px !important;
  }

  #imgCenter {
    width: 400px !important;
  }
}

@media only screen and (max-width: 900px) {
  #inicio {
    padding-top: 70px !important;
    flex-direction: column !important;
  }

  .container{
    font-size: 20px !important;
    padding: 30px 80px 40px !important;
  }

  #imgCenter {
    width: 310px !important;
  }

  .frase{
    font-size: 30px !important;
    padding: 10px 20px !important;
  }

  #botoes button {
    font-size: 1.2em !important;
    padding: 8px 18px !important;
  }

  #botoes {
    width: 80vw !important;
  }
}

#titulo {
  text-align: center;
  padding-top: -15px;
  padding-bottom: 15px;
  margin: 50px 0 0 0;
}

#texto {
  text-align: center;
  padding: 0 15% 0 15%;
  margin: center;
}

a {
  text-decoration: none;
  color: black;
}

#inicio {
  width: 100%;
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
  background-color: rgba(241, 194, 50,0.85);
  font-size: 1.5em;
  padding: 70px 10px 80px 10px;
  height: 100%;
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


