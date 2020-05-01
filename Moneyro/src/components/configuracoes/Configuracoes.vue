<template>
  <div class="pag">
    <Menu />
    <div class="centro">
      <form action method="post" id="informacoes">
        <div id="principal">
          <div id="foto">
            <div id="editar" v-on:click="mudarFoto = true">
              <img src="src/images/editar.png" id="imgEditar" />
            </div>
            <img :src="'src/images/perfil' + this.informacoes[0].foto + '.png'" id="imgPerfil" />
            <Lista
              v-on:receber="receber"
              v-on:fechar="mudarFoto = false"
              v-if="mudarFoto"
              :atual="this.informacoes[0].foto"
            />
          </div>
          <div id="coisas">
            <label class="enunciado" for="apelido">Apelido</label>
            <br />
            <input
              type="text"
              class="campos"
              name="apelido"
              maxlength="14"
              :value="this.informacoes[0].apelido"
            />
            <label class="enunciado" for="apelido">Senha</label>
            <input
              type="password"
              class="campos"
              name="senha"
              :value="this.informacoes[0].senha"
              readonly
              disabled
            />
            <button id="trocarSenha">Trocar senha</button>
            <div class="pretty p-switch p-fill">
              <input type="checkbox" />
              <div class="state">
                <label>Receber Notificações</label>
              </div>
            </div>
            <br />
            <div class="pretty p-switch p-fill p-primary">
              <input type="checkbox" />
              <div class="state p-primary">
                <label>Modo Anônimo</label>
              </div>
            </div>
          </div>
        </div>
        <div class="divi"></div>
        <div id="outrasInfos">
          <label class="enunciado" for="email">E-mail</label>
          <input
            type="text"
            class="campos"
            :value="this.informacoes[0].email"
            maxlength="70"
            name="email"
            readonly
            disabled
          />
          <br />
          <label class="enunciado" for="nome">Nome</label>
          <input
            type="text"
            class="campos"
            :value="this.informacoes[0].nome"
            maxlength="70"
            name="nome"
          />
          <br />
          <label class="enunciado">Data de Nascimento</label>
          <div id="dataNasc">
            <input
              type="number"
              class="campos"
              min="1"
              max="31"
              maxlength="2"
              :value="this.informacoes[0].diaNasc"
            />
            <p class="barra">/</p>
            <input
              type="number"
              class="campos"
              min="1"
              max="12"
              maxlength="2"
              :value="this.informacoes[0].mesNasc"
            />
            <p class="barra">/</p>
            <input
              type="number"
              class="campos"
              min="1900"
              max="3000"
              maxlength="4"
              minlength="4"
              :value="this.informacoes[0].anoNasc"
            />
          </div>

          <div id="infos">
            <label for="celular" class="enunciado">Celular</label>
            <br />
            <input
              type="tel"
              class="campos"
              pattern="([0-9]{2})9[0-9]{4}-[0-9]{4}"
              maxlength="14"
              :value="this.informacoes[0].celular"
            />
            <br />
            <label for="cidade" class="enunciado">Cidade</label>
            <br />
            <input type="text" class="campos" :value="this.informacoes[0].cidade" maxlength="30" />
            <select id="estado" class="campos" name="estado">
              <option :value="item" v-for="item in siglas" :key="item.sigla">{{item.sigla}}</option>
            </select>
          </div>
          <div>
            <button id="cancelar" class="botoes">Cancelar</button>
            <button type="submit" class="botoes" id="salvar">Salvar</button>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Menu from "../shared/menu/Menu.vue";
import Lista from "../shared/lista-fotos/Lista-Fotos.vue";

export default {
  components: {
    Menu,
    Lista
  },
  data() {
    return {
      informacoes: [
        {
          apelido: "maru",
          senha: "senhadamalu",
          nome: "Maria Luiza Sperancin Mancebo",
          foto: "6",
          email: "malu@gmail.com",
          diaNasc: 2,
          mesNasc: 6,
          anoNasc: 2004,
          celular: "(19)999000206",
          cidade: "Valinhos",
          estado: "SP"
        }
      ],
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
      mudarFoto: false
    };
  },
  created() {
    var lista = document.getElementById("estado");
    lista.value = this.informacoes[0].estado;
  },
  methods: {
    receber: function(numero) {
      this.informacoes[0].foto = numero;
    }
  }
};
</script>

<style scoped>
#informacoes {
  display: flex;
}

#principal {
  display: flex;
  padding: 15px;
  background: rgba(0, 0, 0, 0.05);
  border-radius: 15px;
}

#outrasInfos {
  padding: 15px;

  background: rgba(0, 0, 0, 0.05);
  border-radius: 15px;
}

#foto {
  width: 180px;
  height: 180px;
}

#editar {
  position: absolute;
  display: grid;
  width: inherit;
  height: inherit;
  background: rgba(0, 0, 0, 0.3);
  opacity: 0;
  border-radius: 15px;
  transition: opacity 0.25s;
}

#imgEditar {
  margin: auto;
  width: 80px;
}

#imgPerfil {
  width: inherit;
  border-radius: 15px;
}

#foto:hover #editar {
  opacity: 1;
  cursor: pointer;
}

#coisas {
  box-sizing: border-box;
  padding: 10px;
  padding-top: 0;
}

.enunciado {
  font-size: 1.5em;
  color: rgb(11, 83, 148);
  margin: 5px;
  font-weight: bold;
}

.campos {
  box-sizing: border-box;
  border-radius: 5px;
  width: 100%;
  background-color: rgba(116, 116, 116, 0.452);
  border: 0px solid gray;
  padding: 4px 15px;
  margin: 2% 0;
  color: rgb(0, 0, 0);
  font-size: 1.3em;
}

#trocarSenha {
  font-size: 1.3em;
  background-color: rgb(11, 83, 148);
  border: none;
  border-radius: 5px;
  color: white;
  padding: 4px 15px;
  cursor: pointer;
  width: 100%;
  margin: 2% 0;
}

.divi {
  width: 5px;
  border-radius: 87px;
  height: 100;
  margin: 5px;
  background: rgba(0, 0, 0, 0.2);
}

#dataNasc {
  border: 0;
  display: flex;
  justify-content: start;
}

/* MALU ARRUMA AKI PFF ME DESCULPE EU ESTRAGAY SEM QUERER */
#dataNasc input {
  width: fit-content;
}
#dia,
#mes {
  width: 58%;
}

.barra {
  font-size: 2.3em;
  color: rgb(11, 83, 148);
  margin: 0px 5px;
}

#infos {
  margin-top: 8px;
  width: 100%;
  border: 0;
}

#infos input {
  width: 45%;
}

#estado {
  width: fit-content;
}

.botoes {
  font-size: 20px;
  padding: 14px 20px;
  margin: 15px 5px;
  border: none;
  cursor: pointer;
  border-radius: 3px;
}

#cancelar {
  background: transparent;
  border: 2px solid #00000000;
  border-radius: 30px;
}

#cancelar:hover {
  border: 2px solid rgb(49, 48, 48);
}

#salvar {
  color: white;
  background: rgb(11, 83, 148);
  border-radius: 30px;
}
</style>
