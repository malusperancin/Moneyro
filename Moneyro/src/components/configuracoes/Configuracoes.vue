<template>
  <div class="pag">
    <Menu />
    <Histrograma v-if="avaliacoes" v-on:fechar="avaliacoes= false" />
    <Mensagem
      v-if="mensagem"
      v-on:ok="mensagem = false"
      mensagem="Receita registrada com sucesso!"
      titulo="Toma o titulo"
      sair="oi"
    ></Mensagem>
    <div class="centro">
      <form action method="post" id="informacoes">
        <div id="principal">
          <div id="mudaessenome">
            <div id="foto">
              <div id="editar" v-on:click="mudarFoto = true">
                <img src="src/images/editar.png" id="imgEditar" />
              </div>
              <img :src="'src/images/perfil' + this.informacoes.foto + '.png'" id="imgPerfil" />
              <Lista
                v-on:receber="receber"
                v-on:fechar="mudarFoto = false"
                v-if="mudarFoto"
                :atual="this.informacoes.foto"
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
                :value="this.informacoes.apelido"
              />
              <label class="enunciado" for="apelido">Senha</label>
              <input
                type="password"
                class="campos"
                name="senha"
                :value="this.informacoes.senha"
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
          <div id="avaliacao">
            <label
              class="enunciado"
              v-on:click="avaliacoes = true"
              style="margin-bottom:20px"
              title="clique para ver mais avaliações"
            >Avaliações do Aplicativo</label>
            <br />
            <label>Nota:</label>
            <span
              id="estrelas"
              v-on:click="setEstrelas(num)"
              @mouseenter="colorirEstrela(num)"
              @mouseleave="descolorirEstrelas"
              v-for="num in [1,2,3,4,5]"
              :key="num"
              class="fa fa-star"
              :title="num"
            ></span>
            <div id="comentario">
              <label c="titulo">Deixe sua opinião:</label>
              <br />
              <textarea maxlength="200" id="opiniao" v-model="avaliacao"></textarea>
            </div>
            <button type="submit" class="botoes" id="enviar">Enviar</button>
          </div>
        </div>
        <div class="divi"></div>
        <div id="outrasInfos">
          <label class="enunciado" for="email">E-mail</label>
          <input
            type="text"
            class="campos"
            :value="this.informacoes.email"
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
            :value="this.informacoes.nome"
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
              :value="this.informacoes.diaNasc"
            />
            <p class="barra">/</p>
            <input
              type="number"
              class="campos"
              min="1"
              max="12"
              maxlength="2"
              :value="this.informacoes.mesNasc"
            />
            <p class="barra">/</p>
            <input
              type="number"
              class="campos"
              min="1900"
              max="3000"
              maxlength="4"
              minlength="4"
              :value="this.informacoes.anoNasc"
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
              :value="this.informacoes.celular"
            />
            <br />
            <label for="cidade" class="enunciado">Cidade</label>
            <br />
            <input type="text" class="campos" :value="this.informacoes.cidade" maxlength="30" />
            <select id="estado" class="campos" name="estado">
              <option :value="item" v-for="(item, i) in siglas" :key="i">{{item.sigla}}</option>
            </select>
          </div>
          <div>
            <button class="cancelar botoes">Cancelar</button>
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
import Histrograma from "../shared/histograma/Histograma.vue";
import Mensagem from "../shared/mensagem/Mensagem.vue";

export default {
  components: {
    Menu,
    Lista,
    Histrograma,
    Mensagem
  },
  data() {
    return {
      informacoes: {
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
      mudarFoto: false,
      estrelas: 0,
      avaliacao: "",
      avaliacoes: false,
      mensagem: false
    };
  },
  methods: {
    receber: function(numero) {
      this.informacoes.foto = numero;
    },
    setEstrelas(num) {
      for (var i = 0; i < num; i++) estrelas.item(i).classList.add("checked");
      this.estrelas = num;
    },
    colorirEstrela(num) {
      for (var i = 0; i < 5; i++) estrelas.item(i).classList.remove("checked");
      for (var i = 0; i < num; i++) estrelas.item(i).classList.add("checked");
    },
    descolorirEstrelas() {
      for (var i = 0; i < 5; i++) estrelas.item(i).classList.remove("checked");
      for (var i = 0; i < this.estrelas; i++)
        estrelas.item(i).classList.add("checked");
    },
    enviarAvaliacao() {
      // var avaliacao = {
      // }
      // this.$http.post()
    }
  },
  mounted() {
    var lista = document.getElementById("estado");
    lista.value = this.informacoes.estado;
  }
};
</script>

<style scoped>
#enviar {
  border-top: 0px;
  background: rgb(11, 83, 148);
  border-radius: 30px;
  color: white;
  margin-top: 1%;
  margin-bottom: 1%;
}

#opiniao {
  width: 100%;
  resize: none;
  padding: 10px;
  font-size: 1.2em;
  box-sizing: border-box;
  border-radius: 15px;
}

#titulo {
  font-size: 1.15em;
  font-weight: 600;
}

.fa-star {
  cursor: pointer;
  color: rgba(92, 89, 89, 0.459);
  transform: scale(1.5);
  margin: 5px;
  /* margin-bottom: 10px; */
  text-shadow: 2px 2px rgba(0, 0, 0, 0.116);
}

.fa-star:hover {
  transform: scale(2);
}

.checked {
  color: orange;
}

#informacoes {
  display: inline-flex;
  width: 70vw;
}

#principal {
  padding: 15px;
  background: rgba(0, 0, 0, 0.05);
  border-radius: 15px;
  width: 100%;
}

#mudaessenome {
  display: flex;
}

#avaliacao {
  margin-top: 5.9%;
  border-radius: 10px;
  padding: 8px 16px;
  /* width: fit-content; */
  height: max-content;
  background: #ecb3188f;
}

#avaliacao div {
  width: 100%;
}

#avaliacao .enunciado:hover {
  text-decoration: underline;
  cursor: pointer;
}

#outrasInfos {
  padding: 15px;
  background: rgba(0, 0, 0, 0.05);
  border-radius: 15px;
  width: 100%;
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
  padding: 7px 20px;
  margin: 15px 5px;
  border: none;
  cursor: pointer;
  border-radius: 3px;
}

.cancelar {
  background: transparent;
  border: 2px solid #00000000;
  border-radius: 30px;
}

.cancelar:hover {
  border: 2px solid rgb(49, 48, 48);
}

#salvar {
  color: white;
  background: rgb(11, 83, 148);
  border-radius: 30px;
}
</style>
