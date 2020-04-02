<template>
  <div class="pag">
    <div id="moneyro">
      <h1>
        <p>Cadastro</p>
        <img id="logo" src="src/images/logo.png" alt />
      </h1>
    </div>
    <div id="topo">
      <h1>Casdatre-se!</h1>
      <h3>Frasesinha esgraçada hahaha</h3>
    </div>
    <div id="formCadastro">
      <form action method="post">
        <input type="text" class="campo" id="nome" placeholder="Nome" maxlength="70" />
        <br />

        <input type="email" class="campo" id="email" placeholder="E-mail" maxlength="40" />
        <br />

        <input type="password" class="campo" id="senha" placeholder="Senha" maxlength="20" />
        <br />

        <input type="text" class="campo" id="apelido" placeholder="Apelido" maxlength="20" />
        <br />

        <div id="dataNasc">
          <fieldset>
            <legend>Nascimento</legend>
            <input
              type="number"
              class="campo"
              id="dia"
              placeholder="Dia"
              min="1"
              max="31"
              maxlength="2"
            />
            <input
              type="number"
              class="campo"
              id="mes"
              placeholder="Mês"
              min="1"
              max="12"
              maxlength="2"
            />
            <input
              type="number"
              class="campo"
              id="ano"
              placeholder="Ano"
              min="1900"
              max="3000"
              maxlength="4"
              minlength="4"
            />
          </fieldset>
        </div>
        <input
          type="tel"
          class="campo"
          pattern="([0-9]{2})9[0-9]{4}-[0-9]{4}"
          id="celular"
          placeholder="Celular"
          maxlength="14"
        />
        <br />

        <input type="text" class="campo" id="Cidade" placeholder="Cidade" maxlength="30" />

        <select>
          <option :value="item" v-for="item in siglas" :key="item.sigla" s>{{item.sigla}}</option>
        </select>
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
          <button type="submit">Cadastrar</button>
        </div>
        <br />
        <div class="divi"></div>
        <br />
        <p style="color:white">
          Já tem conta?
          <span v-on:click="openMenu" class="link">Fazer login</span>
        </p>
        <!-- <div>
        <label for="msg">Mensagem:</label>
        <textarea id="msg"></textarea>
        </div>-->
      </form>
    </div>
    <menu :visivel="active"></menu>
  </div>
</template>

<script>
import Login from "../login/Login.vue";

export default {
  components: {
    login: Login
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
    openMenu: function() {
      if (this.active) {
        this.active = false;
        this.active = true;
      } else this.active = true;
    }
  }
};
</script>

<style>
.pag {
  background-color: rgb(11, 83, 148);
  height: 900px;
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
  border-radius: 40px;
  width: 70px;
  float: left;
  margin: 10px;
  border: 2px solid rgb(255, 227, 74);
}

/* aaaaaaaaaaaaa */

.link {
  display: inline-block;
  text-decoration: underline;
  cursor: pointer;
}

#dataNasc input {
  width: 30%;
  margin: auto;
  margin-left: 7px;
}

fieldset {
  color: rgb(226, 226, 226);
  padding: 4px;
  border-radius: 4px;
  margin-bottom: 10px;
  width: 100%;
  border: 0;
}

.labels {
  color: white;
}

select {
  background-color: whitesmoke;
  border-radius: 5px;
  border: 1px solid gray;
  height: 30px;
  margin: 5px 0 5px 0;
  padding: 2px 8px;
  float: right;
}

.campo {
  font-size: 1em;
  background-color: whitesmoke;
  border-radius: 5px;
  border: 1px solid gray;
  width: 100%;
  margin: 5px 0px 5px 0px;
  padding: 8px 15px;
  box-sizing: border-box;
}

button {
  font-size: 20px;
  background-color: rgb(12, 65, 111);
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
  height: 5px;
  border-radius: 15px;
}

form {
  width: 95%;
  padding: 5px;
  margin: auto;
  text-align: start;
}

#formCadastro {
  padding: 20px;
  width: 32%;
  margin: 5% auto 5%;
  background-color: rgba(0, 0, 0, 0.1);
  border-radius: 5px;
}
</style>