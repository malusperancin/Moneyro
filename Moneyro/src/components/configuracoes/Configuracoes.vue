<template>
  <div class="pag">
    <Menu />
    <Histrograma v-if="avaliacoes" v-on:fechar="avaliacoes= false" />
    <mudar-senha v-on:sucesso="mudarSenha" v-if="senha" v-on:fechar="senha = false"></mudar-senha>
    <Mensagem
      :msg="msg"
      v-if="msg.visivel"
      v-on:home="msg.visivel = false, $router.push('/')"
      v-on:fechar="msg.visivel = false"
      v-on:restaurar="msg.visivel = false, getUsuario()"
      v-on:cancelar="msg.visivel = false"
    ></Mensagem>
    <div class="centro">
      <form v-on:submit.prevent id="informacoes">
        <div class="informacoes">
          <div id="principal">
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
              <input
                type="text"
                class="campos"
                name="apelido"
                maxlength="14"
                v-model="usuario.apelido"
              />
              <div class="pretty p-switch p-fill p-primary" style="margin: 10px 0">
                <input type="checkbox" v-model="usuario.notificacoes"/>
                <div class="state p-primary">
                  <label>Receber Notificações</label>
                </div>
              </div>
              <div class="pretty p-switch p-fill p-primary" style="margin: 0 0 10px">
                <input type="checkbox" v-model="usuario.modoAnonimo"/>
                <div class="state p-primary">
                  <label>Modo Anônimo</label>
                </div>
              </div>
              <button id="trocarSenha" v-on:click="senha = true">Trocar senha</button>
            </div>
          </div>
          <form v-on:submit.prevent="enviarAvaliacao" id="avaliacao">
            <label
              class="enunciado"
              v-on:click="avaliacoes = true"
              style="margin-bottom:20px"
              title="clique para ver mais avaliações"
            >Avaliações do Aplicativo</label>
            <label class="tituloAva" style="color:black">Deixe sua opinião:</label>
            <div id="estrelas">
            <fieldset class="rating">
                <input type="radio" id="star5" name="rating" value="5" v-on:click="estrelas = 5" /><label class = "full" for="star5" title="Bem Bem bon - 5 estrelas"></label>
                <input type="radio" id="star4" name="rating" value="4" v-on:click="estrelas = 4"/><label class = "full" for="star4" title="Ben bon - 4 estrelas"></label>
                <input type="radio" id="star3" name="rating" value="3" v-on:click="estrelas = 3"/><label class = "full" for="star3" title="Meh - 3 estrelas"></label>
                <input type="radio" id="star2" name="rating" value="2" v-on:click="estrelas = 2"/><label class = "full" for="star2" title="Mei ruinzin - 2 estrelas"></label>
                <input type="radio" id="star1" name="rating" value="1" v-on:click="estrelas = 1"/><label class = "full" for="star1" title="Ta um horrô - 1 estrela"></label>
            </fieldset>
            </div>
            <div id="comentario">
              <textarea maxlength="200" id="opiniao" v-model="comentario" required></textarea>
            </div>
            <button type="submit" class="botoes" id="enviar">Enviar</button>
          </form>
        </div>

        <div class="divi"></div>

        <div class="informacoes">
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

          <label class="enunciado" for="nome">Nome</label>
          <input
            type="text"
            class="campos"
            v-model="usuario.nome"
            maxlength="70"
            name="nome"
          />
          
          <label for="data" class="enunciado">Data de Nascimento</label>
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


          <label for="celular" class="enunciado">Celular</label>
          <input
            type="tel"
            class="campos"
            pattern="(\([0-9]{2}\))\s([9]{1})?([0-9]{4})-([0-9]{4})"
            maxlength="15"
            v-model="usuario.celular"
            style="width: 35%"
          />

          <label for="cidade" class="enunciado">Cidade</label>
          <div id="outras">
            <input type="text" class="campos" v-model="usuario.cidade" maxlength="30" />
            <select id="estado" class="campos" name="estado" required v-model="usuario.estado">
              <option :value="item" v-for="(item, i) in siglas" :key="i">{{item}}</option>
            </select>
          </div>

          <div>
            <button v-on:click="cancelar" type="submit" name="action" value="cancelar" class="cancelar botoes">Cancelar</button>
            <button v-on:click="salvar" type="submit" name="action" value="salvar" class="botoes" id="salvar">Salvar</button>
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
      senha: false,
      mudarFoto: false,
      estrelas: 0,
      comentario: "",
      avaliacoes: false,
      msg: {
        visivel: false,
        titulo: "",
        mensagem: "",
        botoes: []
      },
      siglas: []
    };
  },
  methods: {
    receber: function(numero) {
      this.usuario.foto = numero;
    },
    getUsuario(){
      this.$http
            .get("https://localhost:5001/api/usuarios/" + this.$session.get("id"))
            .then(response => {
              this.usuario = response.body;

              var data = new Date(response.body.dataDeNascimento);

              this.dia = data.getDate();
              this.mes = data.getMonth()+1;
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
       qtdEstrelas: this.estrelas,
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
      var mm = String(this.mes).padStart(2, '0');
      this.usuario.dataDeNascimento = this.ano + "-" + mm + "-" + dd;

      this.$session.set("MA", this.usuario.modoAnonimo);
      this.$session.set("foto", this.usuario.foto);
      this.$session.set("nome", this.usuario.nome);
      this.$http.put("https://localhost:5001/api/usuarios/" + this.usuario.id, this.usuario)
      .then(
          response => {
            this.msg.titulo = "Sucesso";
            this.msg.mensagem =
              "Suas informações foram alteradas com sucesso";
            this.msg.botoes = [
              {
                mensagem: "OK",
                evento: "fechar"
              }
            ]; 
          },
          response => {
            this.msg.titulo = "Opa neném";
            this.msg.mensagem = "Algo deu errado ao alterar suas informações";
            this.msg.botoes = [
              {
               mensagem: "Tentar Novamente",
               evento: "fechar"
             }
            ];
            
            this.getUsuario();
          }
        );

        this.msg.visivel = true;
    },
    cancelar(){
        this.msg.titulo = "Cancelamento";
        this.msg.mensagem =
          "Deseja restaurar os valores anteriores?";
        this.msg.botoes = [
          {
            mensagem: "Sim",
            evento: "restaurar"
          },
          {
            mensagem: "Não",
            evento: "cancelar"
          }
        ];
        this.msg.visivel = true; 
    },
    mudarSenha(){
        this.msg.titulo = "Sucesso";
            this.msg.mensagem =
            "Sua senha foi alterada com sucesso";
          this.msg.botoes = [
            {
              mensagem: "Ok",
              evento: "fechar"
            }
          ];

          this.msg.visivel = true;
          this.senha = false;
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
}
</script>

<style scoped src="../../css/estrelas.css"></style>
<style scoped>
.rating>label {
    color: #ddd;
    float: right;
    transform: scale(1.5);
    margin: 2px;
}

.tituloAva{
  font-size: 1.3em;
  margin: 5px;
}

#estrelas{
  text-align:center;
  width:100%;
}

#enviar {
  border-top: 0px;
  background: rgb(11, 83, 148);
  border-radius: 30px;
  color: white;
  margin-top: 1%;
  margin-bottom: 1%;
  width: 50%;
}

#opiniao {
  width: 100%;
  resize: none;
  padding: 10px;
  margin-top:10px;
  font-size: 1.2em;
  box-sizing: border-box;
  border-radius: 10px;
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
  display: flex;
}

.informacoes {
  width: 50%;
  padding: 15px;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 10px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  box-sizing: border-box;
}

#outras{
  display: flex;
}

#outras input{
  width: 50%;
}

#principal {
  display: flex;
}

#avaliacao {
  margin-top: 5.9%;
  border-radius: 10px;
  padding: 8px 16px;
  height: max-content;
  background: #ecb318a6; 
  display: flex;
  flex-direction: column;
}

/* #avaliacao div {
   width: 100%; 
} */

#avaliacao .enunciado:hover {
  text-decoration: underline;
  cursor: pointer;
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
  display: flex;
  flex-direction: column;
  justify-content: space-around;
}

.enunciado {
  font-size: 1.5em;
  color: rgb(11, 83, 148);
  font-weight: bold;
}

label{
  color: whitesmoke;
}

.campos {
  box-sizing: border-box;
  border-radius: 5px;
  background-color: rgba(116, 116, 116, 0.45);
  border: 1px solid gray;
  padding: 4px 15px;
  color: whitesmoke;
  font-size: 1.3em;
  width: 100%;
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
  box-sizing: border-box;
}

.divi {
  width: 5px;
  border-radius: 87px;
  height: 100;
  margin: 5px;
  background: rgba(0, 0, 0, 0);
}

#dataNasc {
  border: 0;
  display: flex;
  justify-content: space-around;
  box-sizing: border-box;
  align-items: center;
  width: 100%;
}

#dataNasc input {
  margin: 5px;
}

.barra {
  font-size: 2.5em;
  color: rgb(11, 83, 148);
  margin: 0;
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
  color: whitesmoke;
}

.cancelar {
  background: transparent;
  border: 2px solid #00000000;
  border-radius: 30px;
}

.cancelar:hover {
  border: 2px solid rgb(73, 73, 73);
}

#salvar {
  color: white;
  background: rgb(11, 83, 148);
  border-radius: 30px;
}

.rating>input:checked~label,

/* show gold star when clicked */

.rating:not(:checked)>label:hover,

/* hover current star */

.rating:not(:checked)>label:hover~label {
    color: rgb(70, 117, 121);
}

/* hover previous stars in list */

.rating>input:checked+label:hover,

/* hover current star when changing rating */

.rating>input:checked~label:hover,
.rating>label:hover~input:checked~label,

/* lighten current selection */

.rating>input:checked~label:hover~label {
    color: rgb(148, 155, 156);
}

</style>
