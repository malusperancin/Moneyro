<template>
  <div class="pagCadastro">
    <cabecalho :titulo="'Cadastro'"></cabecalho>
    <Mensagem
      :msg="msg"
      v-if="msg.visivel"
      v-on:login="login = true, msg.visivel = false"
      v-on:home="msg.visivel = false, $router.push('/usuario')"
      v-on:fechar="msg.visivel = false"
    ></Mensagem>
    <div id="formCadastro">
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
          pattern="(\([0-9]{2}\))\s([9]{1})?([0-9]{4})-([0-9]{4})"
          id="celular"
          placeholder="Celular"
          title="Número de telefone precisa ser no formato (99) 9999-9999 ou (99) 99999-9999"
          maxlength="15"
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

      </form>
    </div>
    <login v-if="login" v-on:fechar="login = false, $router.push('/')"></login>
  </div>
</template>

<script>
import Login from "../shared/login/Login.vue";
import Header from "../shared/cabecalho/Cabecalho.vue";
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
        foto: "1",
        senha: "",
        cidade: "",
        estado: "",
        modoAnonimo: false,
        notificacoes: false,
        saldo: 0.0,
        professor: false,
        pontos: 0,
        idSala: 1
      },
      dia: 1,
      mes: 1,
      ano: 2000,
      siglas: [],
      msg: {
        visivel: false,
        titulo: "",
        mensagem: "",
        botoes: []
      },
      login: false,
      mudarFoto: false
    };
  },
  methods: {
    cadastrar: function() {
      var d = new Date();
      d.setDate(parseInt(this.dia));
      d.setMonth(parseInt(this.mes) - 1);
      d.setFullYear(parseInt(this.ano));
      this.informacoes.dataDeNascimento = d;

      this.$http
        .post("https://localhost:5001/api/usuarios", this.informacoes)
        .then(
          response => {
            this.msg = {
              titulo: "INÍCIO DE UM SONHO!",
              mensagem: "Você foi cadastrado com sucesso!\n Agora vá na página de login e entre.",
              botoes: [
              {
                mensagem: "Fazer login",
                evento: "login"
              },
              {
                mensagem: "OK",
                evento: "home"
              }],
              visivel: true
            };
          },
          erro => {
            this.msg = {
              titulo: "Deu tudo errado...",
              mensagem: erro.bodyText,
              botoes: [{
                mensagem: "Ok",
                evento: "fechar"
              }],
              visivel: true
            };
          }
        );
    }
  },
  created() {
    this.$http
      .get("https://servicodados.ibge.gov.br/api/v1/localidades/estados")
      .then(response => {
        for (var i = 0; i < response.body.length; i++)
          this.siglas.push(response.body[i].sigla);
      });
    document.title = "Cadastro";
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
  padding: 5px 0px;
  display: flex;
  justify-content: space-between;
  box-sizing: border-box;
}

#dataNasc input{
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
  font-size: 1em;
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
  text-align: start;
  background: rgb(0, 0, 0, 0.2);
  border-radius: 10px;
  width: 35vw;
  padding: 3em;
}

#formCadastro {
  padding: 12% 0px 5%;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>