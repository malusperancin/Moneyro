<template>
  <div class="pagCadastro">
    <cabecalho :titulo="'Cadastro'"></cabecalho>
    <mensagem
      :msg="msg"
      v-if="msg.visivel"
      v-on:login="login = true, msg.visivel = false"
      v-on:home="msg.visivel = false, $router.push('/usuario')"
      v-on:fechar="msg.visivel = false"
    ></mensagem>
    <div id="formCadastro">
      <form v-on:submit.prevent="cadastrar" id="formCad">
        <div id="foto">
          <div id="editar" v-on:click="mudarFoto = true">
            <ion-icon name="create" v-pre></ion-icon>
          </div>
          <img alt="" :src="'src/images/perfil' + informacoes.foto + '.png'" id="imgPerfil" />
          <lista
            v-on:receber="num => informacoes.foto = num"
            v-on:fechar="mudarFoto = false"
            v-if="mudarFoto"
            :atual="informacoes.foto"
          ></lista>
        </div>
        <div :class="['input-container', {'campo-valido' : informacoes.nome != ''}]">
          <input type="text" class="campos" id="nome" maxlength="70" v-model="informacoes.nome" required/>
          <label for="nome">Nome</label>
        </div>
        
        <div :class="['input-container', {'campo-valido' : informacoes.email != ''}]">
          <input type="email" class="campos" value="" id="email" maxlength="40" v-model="informacoes.email" required/>
          <label for="email">E-mail</label>
        </div>

        <div :class="['input-container', {'campo-valido' : informacoes.senha != ''}]">
          <input v-on:keyup="validarSenha(informacoes.senha)" :type="mostrarSenha ? 'text' : 'password'" class="campos" id="senha-campo" maxlength="20" minlength="8" v-model="informacoes.senha" required/>
          <label style="display: flex" id="senha-label" for="senha">Senha <span v-if="informacoes.senha != ''">&nbsp;•&nbsp;</span> <div id="msg"></div></label>
          <div id="mostrar-senha" v-if="informacoes.senha != ''" v-on:click="mostrarSenha = !mostrarSenha"><ion-icon  v-if="mostrarSenha" name="eye"></ion-icon><ion-icon  v-if="!mostrarSenha" name="eye-off"></ion-icon></div>
        </div>

        <div :class="['input-container', {'campo-valido' : informacoes.apelido != ''}]">
          <input type="text" class="campos" id="apelido" maxlength="20" minlength="3" v-model="informacoes.apelido" required/>
          <label for="apelido">Apelido</label>
        </div>
        
        <div class="nascimento">
          <label class="labels">Nascimento</label>
          <div id="dataNasc">
            <input placeholder="Dia" type="number" id="dia" min="1" max="31" v-model="dia" required/>
            <p>/</p>
            <input placeholder="Mês" type="number" id="mes" min="1" max="12" v-model="mes" required/>
            <p>/</p>
            <input placeholder="Ano" type="number" id="ano" min="1900" max="3000" v-model="ano" required/>
          </div>
        </div>
        
        <div :class="['input-container', {'campo-valido' : informacoes.celular != ''}]">
          <input type="tel" class="campos" pattern="(\([0-9]{2}\))\s([9]{1})?([0-9]{4})-([0-9]{4})"
          id="celular" title="Número de telefone precisa ser no formato (99) 9999-9999 ou (99) 99999-9999"
          maxlength="15" v-model="informacoes.celular" required />
          <label for="celular">Celular</label>
        </div>

        <div id="cidadeEstado">
          <div :class="['input-container', {'campo-valido' : informacoes.cidade != ''}]">
            <input type="text" class="campos" id="cidade" maxlength="30" required v-model="informacoes.cidade"/>
            <label for="cidade">Cidade</label>
          </div>
          <select required v-model="informacoes.estado">
            <option :value="item.sigla" v-for="(item, i) in estados" :key="i">{{item.sigla}}</option>
          </select>
        </div>

        <br />
        <br />

        <input class="check" type="checkbox" id="notificacoes" name="notif" v-model="informacoes.notificacoes"/>
        <label class="labels" for="notif">Deseja receber notifições?</label>

        <br />

        <input class="check" type="checkbox" id="anonimo" name="amode" v-model="informacoes.modoAnonimo"/>
        <label class="labels" for="amode">
          Usar conta no <b id="mA">Modo Anônimo</b>
        </label>

        <br />
        <br />

        <button type="submit" class="botoes">Cadastrar</button>

        <br />
        <br />

        <div class="divi"></div>

        <br />

        <p style="color:white">
          Já tem conta?
          <span v-on:click="login = true" class="link">Fazer login</span>
        </p>
      </form>
    </div>
    <login v-if="login" v-on:fechar="login = false" v-on:login="$router.push('/')"></login>
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
        idSala: 1,
        cofre: -1.0
      },
      dia: null,
      mes: null,
      ano: null,
      estados: [],
      msg: {
        visivel: false,
        titulo: "",
        mensagem: "",
        botoes: []
      },
      login: false,
      mudarFoto: false,
      mostrarSenha: false
    };
  },
  methods: {
    cadastrar() {
      var d = new Date(this.ano, this.mes-1, this.dia);
      this.informacoes.dataDeNascimento = d.toJSON().split('T')[0];

      this.$http
        .post("https://localhost:5001/api/usuarios", this.informacoes)
        .then(resposta => this.mensagemSucesso(resposta))
        .catch(erro => this.mensagemErro(erro));
    },
    mensagemSucesso(corpo) 
    {
      this.msg = {
        titulo: "INÍCIO DE UM SONHO!",
        mensagem: "Você foi cadastrado com sucesso!\n Agora vá na página de login e entre.",
        botoes: [{
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
    mensagemErro(corpo)
    {
      this.msg = {
        titulo: "Deu tudo errado...",
        mensagem: corpo.bodyText,
        botoes: [{
          mensagem: "Ok",
          evento: "fechar"
        }],
        visivel: true
      };
    },
    validarSenha(senha) 
    {
      if (senha.length === 0) {
          document.getElementById("msg").innerHTML = "";
          document.getElementById("senha-label").style.color = "gray";
          document.getElementById("senha-campo").style.border = "3px solid #acacac";
          return;
      }

      var matchedCase = ["[$@$!%*#?&]","[A-Z]","[0-9]","[a-z]"];   

      var ctr = 0;
      for (var i = 0; i < matchedCase.length; i++)
        if (new RegExp(matchedCase[i]).test(senha))
          ctr++;

      var color = "";
      var strength = "";

      switch (ctr) {
        case 0:
        case 1:
          strength = "Muito fraca";
          color = "red";
          break;
        case 2:
          strength = "Fraca";
          color = "orangered";
          break;
        case 3:
          strength = "Média";
          color = "coral";
          break;
        case 4:
          strength = "Forte";
          color = "yellowgreen";
          break;
      }

      document.getElementById("msg").innerHTML = strength;
      document.getElementById("senha-campo").style.border = "3px solid " + color;
      document.getElementById("senha-campo").style.color =  color;
      document.getElementById("mostrar-senha").style.color = color;
      document.getElementById("senha-label").style.color = color;
    }
  },
  created() 
  {
    document.title = "Cadastro";

    this.$http
      .get("https://servicodados.ibge.gov.br/api/v1/localidades/estados")
      .then(response => this.estados = response.body);
  },
  mounted() 
  {
    const isNumericInput = (event) => {
      const key = event.keyCode;
      return ((key >= 48 && key <= 57) || // Allow number line
          (key >= 96 && key <= 105) // Allow number pad
      );
    };

    const isModifierKey = (event) => {
      const key = event.keyCode;
      return (event.shiftKey === true || key === 35 || key === 36) || // Allow Shift, Home, End
          (key == 8 || key === 9 || key === 13 || key === 46) || // Backspace, Tab, Enter, Delete
          (key > 36 && key < 41) || // Allow left, up, right, down
          (
              // Allow Ctrl/Command + A,C,V,X,Z
              (event.ctrlKey === true || event.metaKey === true) &&
              (key === 65 || key === 67 || key === 86 || key === 88 || key === 90)
          )
    };

    const enforceFormat = (event) => {
      // Input must be of a valid number format or a modifier key
      if(!isNumericInput(event) && !isModifierKey(event)){
        event.preventDefault();
      }
    };

    const formatToPhone = (event) => {
      if(event.keyCode != 8)
        if(isModifierKey(event)) return;
        
      const input = event.target.value.replace(/\D/g,'').substring(0,12);
      const areaCode = input.substring(0,2);
      const middle = input.substring(2,6);
      const last = input.substring(6,12);

      if(input.length > 10)
        this.informacoes.celular = `(${areaCode}) ${middle}${last[0]}-${last.substring(1)}`;
      else if(input.length > 6)
        this.informacoes.celular = `(${areaCode}) ${middle}-${last}`;
      else if(input.length > 2)
        this.informacoes.celular = `(${areaCode}) ${middle}`;
      else if(input.length > 0)
        this.informacoes.celular = `(${areaCode}`;
    };

    const inputElement = document.getElementById('celular');
    inputElement.addEventListener('keydown', enforceFormat);
    inputElement.addEventListener('keyup', formatToPhone);
  },
};
</script>

<style scoped>
#mostrar-senha {
  position: absolute;
  top: 20px;
  right: 20px;
  font-size: 25px;
  color: gray;
  cursor: pointer;
  transition: 0;
}

.nascimento {
  margin: 5px 0px 5px 0px;
}

#dataNasc {
  display: flex;
  justify-content: space-between;
  box-sizing: border-box;
  border-radius: 5px;
  background: whitesmoke;
  border: 3px solid #acacac;
}

#dataNasc input{
  width: 30%;
  border: none;
  font-size: 1.2em;
  border-radius: 5px;
  width: 100%;
  padding: 10px 20px 10px 25px;
  box-sizing: border-box;
  background: whitesmoke;
}

#dataNasc p {
  padding: 0;
  margin: auto;
  font-size: 1.5em;
  color: #acacac;
}

.input-container {
  position: relative;
}

.input-container label {
  position: absolute;
  font-size: 1.2em;
  top: 25%;
  left: 20px;
  color: grey;
  cursor: text;
}

.input-container input {
  border-radius: 5px;
  border: 3px solid #acacac;
}

.campos:focus + label, .campo-valido label {
  top: 14%;
  left: 10px;
  font-size: 0.8em;
}

.campos {
  font-size: 1.2em;
  background-color: whitesmoke;
  width: 100%;
  margin: 5px 0px 5px 0px;
  padding: 18px 15px 2px;
  box-sizing: border-box;
}

#foto {
  width: 150px;
  height: 150px;
  margin: -15px auto 15px;
}

#editar {
  position: absolute;
  width: inherit;
  height: inherit;
  display: flex;
  background: rgba(0, 0, 0, 0.32);
  opacity: 0;
  border-radius: 15px;
  transition: all .2s ease-in-out;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  font-size: 4em;
}

#editar:hover {
  opacity: 1;
}

#imgPerfil {
  width: 100%;
  border-radius: 15px;
}

.pagCadastro {
  background-color: rgb(11, 83, 148);
  width: 100%;
}

#logo {
  width: 70px;
  float: left;
  margin: 10px;
}

#cidadeEstado {
  display: flex;
  grid-gap: 8px;
}

.link {
  display: inline-block;
  text-decoration: underline;
  cursor: pointer;
}

.link:hover {
  color: plum;
}

.labels {
  color: white;
}

select {
  background-color: whitesmoke;
  border-radius: 5px;
  border: 3px solid #acacac;
  margin: 5px 0 5px 0;
  padding: 8px 15px;
  float: right;
  font-size: 1em;
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

.botoes:hover {
  background-color: rgba(0, 0, 0, 0.3);
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
  width: calc(30% + 75px);
  padding: 3em;
}

#formCadastro {
  padding: 150px 0px 5%;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>