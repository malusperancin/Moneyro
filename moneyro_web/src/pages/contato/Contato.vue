<template>
  <div class="pag">
    <cabecalho :titulo="'Contato'"></cabecalho>

        <div id="centro">
        <form method="POST" action="https://formspree.io/f/mleapolz">
        <fieldset>
            <input type="hidden" name="_subject" value="Novo contato!" />
            <input type="hidden" name="_next" value="https://www.rossener.com/contato/mensagem-enviada/" />
            <input type="hidden" name="_language" value="pt" />

            <input type="text" name="nome" placeholder="Seu nome" required>

            <input type="text" name="email" placeholder="Seu e-mail" required>

            <textarea name="mensagem" placeholder="Sua mensagem" required></textarea>

            <input type="submit" text="Enviar"></input>
        </fieldset>
        </form>
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
#centro {
  display: flex;
  flex-direction: column;
  }
form{
    max-width: 1000px;
    margin: 12% auto 0 auto;
    font-family: 'Open Sans', sans-serif;
    font-weight: weight;
    padding: 10px;
    width: 100%;


}
fieldset{
    border:none;
}
        
input[type="text"], input[type="email"], textarea{

        box-sizing: border-box;
        outline: none;
        display: block;
        color: #333333;
        width: 100%;
        padding: 11px;
        border: none;
        border-radius: 10px;
        border-bottom: 5px solid #ddd;
        margin-bottom: 30px;
        font-family: inherit;
        font-size: 21px;
        height: 55px;
    }
    textarea{
        height: 200px;
    }
    input[type="submit"]
    {
        font-size: 20px;
        background-color: rgba(12, 65, 111,0.9);
        color: white;
        padding: 14px 20px;
        margin: 8px 0;
        border: none;
        cursor: pointer;
        width: 100%;
        border-radius: 15px;
    }

    input[type="submit"]:hover
    {
         background-color: rgba(12, 65, 111,0.8);
    }


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


