<template>
  <div class="pagCadastro">
    <cabecalho :titulo="'Cadastro'"></cabecalho>
    <div id="formCadastro">
      <form action method="post" id="formCad">
        <div id="foto">
          <div id="editar" v-on:click="mudarFoto = true">
            <img src="src/images/editar.png" id="imgEditar" />
          </div>
          <img :src="'src/images/perfil' + this.informacoes.foto + '.png'" id="imgPerfil" />
          <Lista
            v-on:receber="receber"
            v-on:fechar="mudarFoto = false"
            v-if="mudarFoto"
            :atual="informacoes.foto"
          />
        </div>

        <input type="text" class="campos" id="nome" placeholder="Nome" maxlength="70" />
        <br />

        <input type="email" class="campos" id="email" placeholder="E-mail" maxlength="40" />
        <br />

        <input type="password" class="campos" id="senha" placeholder="Senha" maxlength="20" />
        <br />

        <input type="text" class="campos" id="apelido" placeholder="Apelido" maxlength="20" />
        <br />

        <label class="labels">Nascimento</label>
        <div id="dataNasc">
          <input
            placeholder="Dia"
            type="number"
            class="campos"
            id="dia"
            min="1"
            max="31"
            maxlength="2"
          />
          <input
            placeholder="Mês"
            type="number"
            class="campos"
            id="mes"
            min="1"
            max="12"
            maxlength="2"
          />
          <input
            placeholder="Ano"
            type="number"
            class="campos"
            id="ano"
            min="1900"
            max="3000"
            maxlength="4"
            minlength="4"
          />
        </div>

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
          <span v-on:click="login = true" class="link">Fazer login</span>
        </p>
        <!-- <div>
        <label for="msg">Mensagem:</label>
        <textarea id="msg"></textarea>
        </div>-->
      </form>
    </div>
    <login v-if="login" v-on:fechar="login = false"></login>
  </div>
</template>

<script>
import Login from "../shared/login/Login.vue";
import Header from "../shared/header/Header.vue";
import Lista from "../shared/lista-fotos/Lista-Fotos.vue";

export default {
  components: {
    login: Login,
    cabecalho: Header,
    Lista: Lista
  },
  data() {
    return {
      informacoes: {
        apelido: "",
        nome: "",
        foto: "1",
        email: "",
        diaNasc: 1,
        mesNasc: 1,
        anoNasc: 1900,
        celular: "",
        cidade: "",
        estado: ""
      },
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
      ],
      login: false,
      mudarFoto: false
    };
  },
  methods: {
    receber: function(numero) {
      this.informacoes.foto = numero;
    }
  }
};
</script>

<style scoped>
#foto {
  width: 150px;
  height: 150px;
  margin: -15px auto 15px;
}

#editar {
  position: absolute;
  width: inherit;
  height: inherit;
  background: rgba(0, 0, 0, 0.32);
  display: none;
  border-radius: 15px;
}

#imgEditar {
  margin: auto;
  width: 80px;
}

#foto:hover #editar {
  display: grid;
  cursor: pointer;
}

#imgPerfil {
  width: inherit;
  border-radius: 15px;
}

.pagCadastro {
  background-color: rgb(11, 83, 148);
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
  border: 0;
  padding: 0px 5px;
  display: flex;
  justify-content: space-around;
}

#dataNasc input {
  width: 30%;
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
  font-size: 1.2em;
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