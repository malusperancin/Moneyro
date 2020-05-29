<template>
  <div class="pag">
    <Menu />
    <Histrograma v-if="avaliacoes" v-on:fechar="avaliacoes= false" />
    <mudar-senha v-if="senha" v-on:fechar="senha = false"></mudar-senha>
    <Mensagem
      :msg="msg"
      v-if="msg.visivel"
      v-on:home="msg.visivel = false, $router.push('/')"
      v-on:fechar="msg.visivel = false"
    ></Mensagem>
    <div class="centro">
      <form v-on:submit.prevent="salvar"  id="informacoes">
        <div id="principal">
          <div id="mudaessenome">
            <div id="foto">
              <div id="editar" v-on:click="mudarFoto = true">
                <img src="src/images/editar.png" id="imgEditar" />
              </div>
              <img :src="'src/images/perfil' + usuario.foto + '.png'" id="imgPerfil" />
              <Lista
                v-on:receber="receber"
                v-on:fechar="mudarFoto = false"
                v-if="mudarFoto"
                :atual="usuario.foto"
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
                v-model="usuario.apelido"
              />
              <div class="pretty p-switch p-fill p-primary">
                <input type="checkbox" v-model="usuario.notificacoes"/>
                <div class="state p-primary">
                  <label>Receber Notificações</label>
                </div>
              </div>
              <br />
              <div class="pretty p-switch p-fill p-primary">
                <input type="checkbox" v-model="usuario.modoAnonimo"/>
                <div class="state p-primary">
                  <label>Modo Anônimo</label>
                </div>
              </div>
              <button v-on:submit.prevent="" id="trocarSenha" v-on:click="senha = true">Trocar senha</button>
            </div>
          </div>
          <form v-on:submit.prevent="enviarAvaliacao" id="avaliacao">
            <label
              class="enunciado"
              v-on:click="avaliacoes = true"
              style="margin-bottom:20px"
              title="clique para ver mais avaliações"
            >Avaliações do Aplicativo</label>
            <br />
            <label>Nota:</label>
            <div>
              <div class="rating-group">
                  <input disabled  class="rating__input rating__input--none" name="rating3" id="rating3-none" value="0" type="radio">

                    <label aria-label="1 star" class="rating__label" for="rating3-1"><i class="rating__icon rating__icon--star fa fa-star"></i></label>
                    <input class="rating__input" name="rating3" id="rating3-1" value="1" type="radio">

                    <label aria-label="2 stars" class="rating__label" for="rating3-2"><i class="rating__icon rating__icon--star fa fa-star"></i></label>
                    <input class="rating__input" name="rating3" id="rating3-2" value="2" type="radio">

                    <label aria-label="3 stars" class="rating__label" for="rating3-3"><i class="rating__icon rating__icon--star fa fa-star"></i></label>
                    <input class="rating__input" name="rating3" id="rating3-3" value="3" type="radio">

                    <label aria-label="4 stars" class="rating__label" for="rating3-4"><i class="rating__icon rating__icon--star fa fa-star"></i></label>
                    <input class="rating__input" name="rating3" id="rating3-4" value="4" type="radio">

                    <label aria-label="5 stars" class="rating__label" for="rating3-5"><i class="rating__icon rating__icon--star fa fa-star"></i></label>
                    <input class="rating__input" name="rating3" id="rating3-5" value="5" type="radio">
              </div>
            </div>
            <div id="comentario">
              <label c="titulo">Deixe sua opinião:</label>
              <br />
              <textarea maxlength="200" id="opiniao" v-model="comentario"></textarea>
            </div>
            <button type="submit" class="botoes" id="enviar">Enviar</button>
          </form>
        </div>
        <div class="divi"></div>
        <div id="outrasInfos">
          <label class="enunciado" for="email">E-mail</label>
          <input
            type="text"
            class="campos"
            v-model="usuario.email"
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
            v-model="usuario.nome"
            maxlength="70"
            name="nome"
          />
          <br />
          
          <label for="data" class="enunciado">Data de Nascimento</label>
          <!-- <input type="date" class="campos" name="data" v-model="usuario.dataDeNascimento"> -->
          <div id="dataNasc">
            <input
              type="number"
              class="campos"
              min="1"
              max="31"
              maxlength="2"
              v-model="dia"
            />
            <p class="barra">/</p>
            <input
              type="number"
              class="campos"
              min="1"
              max="12"
              maxlength="2"
              v-model="mes"
            />
            <p class="barra">/</p>
            <input
              type="number"
              class="campos"
              min="1900"
              max="this"
              maxlength="4"
              minlength="4"
              v-model="ano"
            />
          </div>

          <div id="infos">
            <label for="celular" class="enunciado">Celular</label>
            <br />
            <input
              type="tel"
              class="campos"
              pattern="(\([0-9]{2}\))\s([9]{1})?([0-9]{4})-([0-9]{4})"
              maxlength="15"
              v-model="usuario.celular"
            />
            <br />
            <label for="cidade" class="enunciado">Cidade</label>
            <br />
            <input type="text" class="campos" v-model="usuario.cidade" maxlength="30" />
            <select id="estado" class="campos" name="estado" required v-model="usuario.estado">
             <option :value="item" v-for="(item, i) in siglas" :key="i">{{item}}</option>
          </select>
          </div>
          <div>
            <button class="cancelar botoes">Cancelar</button>
            <button type="submit" class="botoes" id="salvar">Salvar</button>
          </div>
        </div>
      </form>
        {{a}}
    </div>
  </div>
</template>

<script>
import Menu from "../shared/menu/Menu.vue";
import Lista from "../shared/lista-fotos/Lista-Fotos.vue";
import Histrograma from "../shared/histograma/Histograma.vue";
import Mensagem from "../shared/mensagem/Mensagem.vue";
import Senha from '../shared/mudar-senha/Mudar-Senha.vue';

export default {
  components: {
    Menu,
    Lista,
    Histrograma,
    Mensagem,
    "mudar-senha": Senha
  },
  data() {
    return {
      usuario: {
        id: 0,
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
      ano: 2000,
      siglas: [],
      mudarFoto: false,
      estrelas: 0,
      comentario: "",
      avaliacoes: false,
      senha: false,
      msg: {
        visivel: false,
        titulo: "",
        mensagem: "",
        botoes: []
      },
      a: ""
    };
  },
  methods: {
    receber: function(numero) {
      this.usuario.foto = numero;
    },
    setEstrelas(num) {
      // for (var i = 0; i < num; i++) estrelas.item(i).classList.add("checked");
      // this.estrelas = num;
    },
    colorirEstrela(num) {
      // for (var i = 0; i < 5; i++) estrelas.item(i).classList.remove("checked");
      // for (var i = 0; i < num; i++) estrelas.item(i).classList.add("checked");
    },
    descolorirEstrelas() {
      // for (var i = 0; i < 5; i++) estrelas.item(i).classList.remove("checked");
      // for (var i = 0; i < this.estrelas; i++)
        // estrelas.item(i).classList.add("checked");
    },
    getUsuario(){
      this.$http
            .get("https://localhost:5001/api/usuarios/" + this.$session.get("id"))
            .then(response => {
              this.usuario = response.body;

              var data = new Date(response.body.dataDeNascimento);

              this.dia = data.getDate();
              this.mes = data.getMonth();
              this.ano = data.getFullYear();
            });
    },
    enviarAvaliacao() {
      var today = new Date();

      var dd = String(today.getDate()).padStart(2, '0');
      var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
      var yyyy = today.getFullYear();
      today = yyyy + '-' + mm + '-' + dd;
      
      var avaliacao = {
       qtdEstrelas: 3,
       comentario: this.comentario,
       data: today,
       idUsuario: this.$session.get('id')
      }

       this.$http.post("https://localhost:5001/api/avaliacoes", avaliacao).then(
          response => {
            this.msg.titulo = "Enviado!";
            this.msg.mensagem =
              "Sua avaliacao de " + this.estrelas + "⭐ foi enviada com sucesso";
            this.msg.botoes = [
              {
                mensagem: "OK",
                evento: "fechar"
              }
            ];
            this.qtdEstrelas = "";
            this.comentario = "";
            this.msg.visivel = true;
          },
          response => {
            this.msg.titulo = "Opa neném";
            this.msg.mensagem = "Algo deu errado ao enviar sua avaliação.";
            this.msg.botoes = [
             {
               mensagem: "Tentar Novamente",
               evento: "fechar"
             }
            ];
            this.msg.visivel = true;
          }
        );
    },
    salvar(){
      var dd = String(this.dia).padStart(2, '0');
      var mm = String(this.mes + 1).padStart(2, '0');
      this.usuario.dataDeNascimento = this.ano + "-" + mm + "-" + dd;

      this.$http.put("https://localhost:5001/api/usuarios/"+this.$session.get('id'), this.usuario)
      .then(
          response => {
            this.msg.titulo = "Sucesso";
            this.msg.mensagem =
              "Suas informações foram alteradas sucesso";
            this.msg.botoes = [
              {
                mensagem: "OK",
                evento: "fechar"
              }
            ];
          },
          response => {
            this.a=response;
            this.msg.titulo = "Opa neném";
            this.msg.mensagem = "Algo deu errado ao alterar suas informações";
            this.msg.botoes = [
              {
               mensagem: "Tentar Novamente",
               evento: "fechar"
             }
            ];

            this.msg.visivel = true;

            this.getUsuario();
          }
        );
    }

  },
  mounted() {
    var lista = document.getElementById("estado");
    lista.value = this.usuario.estado;
  },
  created() {
    this.$http
      .get("https://servicodados.ibge.gov.br/api/v1/localidades/estados")
      .then(response => {
        for (var i = 0; i < response.body.length; i++)
          this.siglas.push(response.body[i].sigla);
      });

      this.getUsuario();

      document.title = "Configurações";
  },
  beforeCreate() {
    if (!this.$session.exists()) {
      this.$router.push('/')
    }
  }
};
</script>

<style src="../../css/estrelas.css"></style>
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
  /* background: #ecb3188f; */
  background: rgb(144, 112, 175);
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
  display: flex;
  flex-direction: column;
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
  justify-content: space-around;
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

.botoes:active{
  outline: none;
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
