<template>
  <div class="pagCadastro">
    <cabecalho :titulo="'Cadastro'"></cabecalho>
    <div id="formCadastro">
      <form action method="post" id="formCad">
        <input type="text" class="campos" id="nome" placeholder="Nome" maxlength="70" />
        <br />

        <input type="email" class="campos" id="email" placeholder="E-mail" maxlength="40" />
        <br />

        <input type="password" class="campos" id="senha" placeholder="Senha" maxlength="20" />
        <br />

        <input type="text" class="campos" id="apelido" placeholder="Apelido" maxlength="20" />
        <br />

        <fieldset id="dataNasc">
          <legend>Nascimento</legend>
          <input
            type="number"
            class="campos"
            id="dia"
            placeholder="Dia"
            min="1"
            max="31"
            maxlength="2"
          />
          <input
            type="number"
            class="campos"
            id="mes"
            placeholder="Mês"
            min="1"
            max="12"
            maxlength="2"
          />
          <input
            type="number"
            class="campos"
            id="ano"
            placeholder="Ano"
            min="1900"
            max="3000"
            maxlength="4"
            minlength="4"
          />
        </fieldset>

        <input
          type="tel"
          class="campos"
          pattern="([0-9]{2})9[0-9]{4}-[0-9]{4}"
          id="celular"
          placeholder="Celular"
          maxlength="14"
        />
        <br />

        <div id="cidadeEstado">
          <input type="text" class="campos" id="Cidade" placeholder="Cidade" maxlength="30" />

          <select>
            <option :value="item" v-for="item in siglas" :key="item.sigla" s>{{item.sigla}}</option>
          </select>
        </div>
        <br />
        <br />

        <input class="check" type="checkbox" id="notificacoes" name="notif" />
        <label class="labels" for="notif">Deseja receber notifições?</label>
        <br />
        <input class="check" type="checkbox" id="anonimo" name="amode" />
        <label class="labels" for="amode">
          Usar conta no
          <b id="mA">Modo Anônimo</b>
        </label>
        <br />
        <br />

        <!-- Fazer btnClick q mostra modal esplicando o modo anonimo -->

        <div class="button">
          <button type="submit" class="botoes">Cadastrar</button>
        </div>
        <br />
        <div class="divi"></div>
        <br />
        <p style="color:white">
          Já tem conta?
          <span v-on:click="abrirLogin" class="link">Fazer login</span>
        </p>
        <!-- <div>
        <label for="msg">Mensagem:</label>
        <textarea id="msg"></textarea>
        </div>-->
      </form>
    </div>
    <login :visivel="active"></login>
  </div>
</template>

<script>
import Login from "../shared/login/Login.vue";
import Header from "../shared/header/Header.vue";

export default {
  components: {
    login: Login,
    cabecalho: Header
  },
  data() {
    return {
      active: false,
      siglas: [
        { sigla: "AC" },
        { sigla: "AL" },
        { sigla: "AP" },
        { sigla: "AM" },
        { sigla: "BA" },
        { sigla: "CE" },
        { sigla: "DF" },
        { sigla: "ES" },
        { sigla: "GO" },
        { sigla: "MA" },
        { sigla: "MT" },
        { sigla: "MS" },
        { sigla: "MG" },
        { sigla: "PA" },
        { sigla: "PB" },
        { sigla: "PR" },
        { sigla: "PE" },
        { sigla: "PI" },
        { sigla: "RJ" },
        { sigla: "RN" },
        { sigla: "RS" },
        { sigla: "RO" },
        { sigla: "RR" },
        { sigla: "SC" },
        { sigla: "SP" },
        { sigla: "SE" },
        { sigla: "TO" }
      ]
    };
  },
  methods: {
    abrirLogin: function() {
      if (this.active) {
        this.active = false;
        this.active = true;
      } else this.active = true;
    }
  }
};
</script>

<style scoped>
.pagCadastro {
  background-color: rgb(11, 83, 148);
}

#moneyro {
  width: 100%;
  color: white;
  background-color: rgba(12, 65, 111, 0.9);
  position: fixed;
}

#moneyro p {
  margin-top: 20px;
  display: inline-block;
}

#moneyro h1 {
  margin-left: 42%;
}

#logo {
  width: 70px;
  float: left;
  margin: 10px;
}

#cidadeEstado select {
  height: 41px;
}

#cidadeEstado .campos {
  width: 80%;
}

.link {
  display: inline-block;
  text-decoration: underline;
  cursor: pointer;
}

#dataNasc {
  width: 100%;
  color: rgb(226, 226, 226);
  padding: 4px;
  border: 0;
  padding: 0px 5px;
}

#dataNasc input {
  width: 29%;
  margin: 5px 15px 5px 3px;
}

.labels {
  color: white;
}

select {
  background-color: whitesmoke;
  border-radius: 5px;
  border: 1px solid gray;
  margin: 5px 0 5px 0;
  padding: 8px 15px;
  float: right;
}

.campos {
  font-size: 1em;
  background-color: whitesmoke;
  border-radius: 5px;
  border: 1px solid gray;
  width: 100%;
  margin: 5px 0px 5px 0px;
  padding: 8px 15px;
  box-sizing: border-box;
}

.botoes {
  font-size: 20px;
  background-color: rgba(0, 0, 0, 0.2);
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
  border-radius: 3px;
}

.divi {
  width: 100%;
  background-color: rgba(0, 0, 0, 0.2);
  height: 3px;
  border-radius: 15px;
}

#formCad {
  padding: 35px;
  margin: auto;
  text-align: start;
  background: rgb(0, 0, 0, 0.2);
  border-radius: 15px;
  width: 35%;
}

#formCadastro {
  width: 100%;
  padding: 10% 0px 5%;
  margin: auto;
}
</style>