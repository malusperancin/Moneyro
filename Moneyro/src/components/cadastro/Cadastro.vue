<template>
  <div class="pagCadastro">
    <cabecalho :titulo="'Cadastro'"></cabecalho>
    <Mensagem v-if="mensagem"></Mensagem>
    <div id="formCadastro" v-on:click="mostrarmsg">
      <form v-on:submit.prevent="cadastrar" id="formCad">
        <div id="foto">
          <div id="editar" v-on:click="mudarFoto = true">
            <img src="src/images/editar.png" id="imgEditar" />
          </div>
          <img :src="'src/images/perfil' + informacoes.foto + '.png'" id="imgPerfil" />
          <Lista
            v-on:receber="num => informacoes.foto = num"
            v-on:fechar="mudarFoto = false"
            v-if="mudarFoto"
            :atual="informacoes.foto"
          />
        </div>
        <input
          type="text"
          class="campos"
          id="nome"
          placeholder="Nome"
          maxlength="70"
          v-model="informacoes.nome"
          required
        />
        <br />

        <input
          type="email"
          class="campos"
          id="email"
          placeholder="E-mail"
          maxlength="40"
          v-model="informacoes.email"
          required
        />
        <br />

        <input
          type="password"
          class="campos"
          id="senha"
          placeholder="Senha"
          maxlength="20"
          minlength="8"
          v-model="informacoes.senha"
          required
        />
        <br />

        <input
          type="text"
          class="campos"
          id="apelido"
          placeholder="Apelido"
          maxlength="20"
          minlength="3"
          v-model="informacoes.apelido"
          required
        />
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
            v-model="dia"
            required
          />
          <input
            placeholder="Mês"
            type="number"
            class="campos"
            id="mes"
            min="1"
            max="12"
            maxlength="2"
            v-model="mes"
            required
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
            v-model="ano"
            required
          />
        </div>

        <input
          type="tel"
          class="campos"
          pattern="(\([0-9]{2}\))([9]{1})?([0-9]{4})-([0-9]{4})"
          id="celular"
          placeholder="Celular"
          title="Número de telefone precisa ser no formato (99)9999-9999 ou (99)99999-9999"
          maxlength="14"
          v-model="informacoes.celular"
          required
        />
        <br />

        <div id="cidadeEstado">
          <input
            type="text"
            class="campos"
            id="Cidade"
            placeholder="Cidade"
            maxlength="30"
            required
            v-model="informacoes.cidade"
          />

          <select required v-model="informacoes.estado">
            <option :value="item" v-for="(item, i) in siglas" :key="i">{{item}}</option>
          </select>
        </div>
        <br />
        <br />

        <input
          class="check"
          type="checkbox"
          id="notificacoes"
          name="notif"
          v-model="informacoes.notificacoes"
        />
        <label class="labels" for="notif">Deseja receber notifições?</label>
        <br />
        <input
          class="check"
          type="checkbox"
          id="anonimo"
          name="amode"
          v-model="informacoes.modoAnonimo"
        />
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
import Mensagem from "../shared/mensagem/Mensagem.vue";

export default {
  components: {
    login: Login,
    cabecalho: Header,
    Lista: Lista,
    Mensagem
  },
  data() {
    return {
      informacoes: {
        nome: "",
        apelido: "",
        email: "",
        celular: "",
        dataDeNascimento: "",
        foto: 1,
        senha: "",
        cidade: "",
        estado: "",
        modoAnonimo: false,
        notificacoes: false,
        saldo: 0.0
      },
      dia: 1,
      mes: 1,
      ano: 1900,
      siglas: [
        "AC",
        "AL",
        "AP",
        "AM",
        "BA",
        "CE",
        "DF",
        "ES",
        "GO",
        "MA",
        "MT",
        "MS",
        "MG",
        "PA",
        "PB",
        "PR",
        "PE",
        "PI",
        "RJ",
        "RN",
        "RS",
        "RO",
        "RR",
        "SC",
        "SP",
        "SE",
        "TO"
      ],
      login: false,
      mudarFoto: false,
      mensagem: false
    };
  },
  methods: {
    mostrarmsg() {
      this.mensagem = true;
      Mensagem.methods.mostrar(
        "INÍCIO DE UM SONHO!",
        "Você foi cadastrado com sucesso!\n Agora vá na página de login e entre.",
        true,
        false,
        false
      );
      alert(Mensagem.data.mensagem);
      Mensagem.data.mensagem = "asdfghjkl";
      alert(Mensagem.data.mensagem);
    },
    cadastrar: function() {
      var d = new Date();
      d.setDate(parseInt(this.dia));
      d.setMonth(parseInt(this.mes));
      d.setFullYear(parseInt(this.ano));
      this.informacoes.dataDeNascimento = d;

      this.$http
        .post("https://localhost:5001/api/usuarios", this.informacoes)
        .then(
          response => {
            Mensagem.methods.mostrar(
              "INÍCIO DE UM SONHO!",
              "Você foi cadastrado com sucesso!\n Agora vá na página de login e entre.",
              true,
              true,
              false
            );
            this.mensagem = true;
          },
          response => {
            Mensagem.methods.mostrar(
              "Deu tudo errado...",
              response,
              true,
              false,
              false
            );
            this.mensagem = true;
          }
        );

      //  this.$http.get('/someUrl').then(response => {

      // // get body data
      // this.someData = response.body;

      // }, response => {
      //   // error callback
      // });
    }
  },
  mounted() {},
  created() {
    // Mensagem.methods.mostrar(
    //   "INÍCIO DE UM SONHO!",
    //   "Você foi cadastrado com sucesso!\n Agora vá na página de login e entre.",
    //   true,
    //   false,
    //   false
    // );
    // this.mensagem = true;
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

#cidadeEstado {
  display: flex;
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
  font-size: 1.1em;
  margin: auto;
  text-align: start;
  background: rgb(0, 0, 0, 0.2);
  border-radius: 15px;
  width: 40vw;
  padding: 3em;
}

/* @media only screen and (max-width: 600px) {
  #formCad {
    width: 80%;
    padding: 1em;
  }
} */

#formCadastro {
  /* width: 100%; */
  padding: 10% 0px 5%;
  margin: auto;
}
</style>