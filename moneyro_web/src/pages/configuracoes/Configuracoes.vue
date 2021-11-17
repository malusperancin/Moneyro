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
                <ion-icon name="create" v-pre></ion-icon>
              </div>
              <img alt="" :src="'src/images/perfil' + usuario.foto + '.png'" id="imgPerfil" />
              <Lista
                v-on:receber="receber($event)"
                v-on:fechar="mudarFoto = false"
                v-if="mudarFoto"
                :atual="usuario.foto"
              />
            </div>
            <div id="coisas">
              <div :class="['input-container', {'campo-valido' : usuario.apelido != ''}]">
                <input type="text" class="campos" id="apelido" maxlength="20" v-model="usuario.apelido" required/>
                <label for="apelido">Apelido</label>
              </div>
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
        <div class="informacoes">
          <div :class="['input-container', {'campo-valido' : usuario.email != ''}]">
            <input type="text" class="campos" id="email" maxlength="40" v-model="usuario.email" required readonly/>
            <label for="email">E-mail</label>
          </div>

          <div :class="['input-container', {'campo-valido' : usuario.nome != ''}]">
            <input type="text" class="campos" id="nome" maxlength="70" v-model="usuario.nome" required/>
            <label for="nome">Nome</label>
          </div>
          
          <div class="flex">
            <div class="nascimento">
              <label class="labels">Data de Nascimento</label>
              <div id="dataNasc">
                <input placeholder="Dia" type="number" id="dia" min="1" max="31" v-model="dia" required/>
                <p>/</p>
                <input placeholder="Mês" type="number" id="mes" min="1" max="12" v-model="mes" required/>
                <p>/</p>
                <input placeholder="Ano" type="number" id="ano" min="1900" max="3000" v-model="ano" required/>
              </div>
            </div>

            <div :class="['input-container', {'campo-valido' : usuario.celular != ''}]">
              <input type="tel" class="campos" pattern="(\([0-9]{2}\))\s([9]{1})?([0-9]{4})-([0-9]{4})"
              id="celular" title="Número de telefone precisa ser no formato (99) 9999-9999 ou (99) 99999-9999"
              maxlength="15" v-model="usuario.celular" required />
              <label for="celular">Celular</label>
            </div>
          </div>

          <div class="cidade_estado">
            <div :class="['input-container', {'campo-valido' : usuario.estado != ''}]">
              <input type="text" class="campos" id="cidade" maxlength="30" v-model="usuario.cidade" required/>
              <label for="cidade">Cidade</label>
            </div>

            <select id="estado" class="campos" name="estado" >
              <option :value="item.sigla" v-for="(item, i) in siglas" :key="i">{{item.sigla}}</option>
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
import Histrograma from "./components/Histograma.vue";
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
        saldo: 0.0,
        professor: false,
        pontos: 0,
        idSala: 1,
        cofre: 0.0
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
    receber(foto) {
      this.usuario.foto = foto;
    },
    getUsuario(){
      this.$http
        .get("https://localhost:5001/api/usuarios/" + this.$session.get("id"))
        .then(response => {
          this.usuario = response.body;
          
          this.usuario.dataDeNascimento = response.body.dataDeNascimento.split("T")[0];

          var data = new Date(response.body.dataDeNascimento);

          this.dia = data.getDate()+ 1;
          this.mes = data.getMonth()+1;
          this.ano = data.getFullYear();
        });
    },
    enviarAvaliacao() 
    {
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

       this.$http.post("https://localhost:5001/api/avaliacoes", avaliacao)
       .then(response => { 
            this.qtdEstrelas = "";
            this.comentario = "";
            
            this.msg = {
              titulo: "Enviado!",
              mensagem: "Sua avaliacao de " + this.estrelas + "⭐ foi enviada com sucesso",
              botoes: [
              {
                mensagem: "OK",
                evento: "fechar"
              }],
              visivel: true
            };
          })
          .catch(erro => {
            this.msg = {
              titulo: "Opa neném",
              mensagem: "Algo deu errado ao enviar sua avaliação.",
              botoes: [{
               mensagem: "Tentar Novamente",
               evento: "fechar"
              }],
              visivel: true
            };
          });
    },
    salvar()
    {
      var dd = String(this.dia).padStart(2, '0');
      var mm = String(this.mes).padStart(2, '0');
      this.usuario.dataDeNascimento = this.ano + "-" + mm + "-" + dd;

      this.$session.set("MA", this.usuario.modoAnonimo);
      this.$session.set("foto", this.usuario.foto);
      this.$session.set("nome", this.usuario.nome);

      this.$http.put("https://localhost:5001/api/usuarios/" + this.usuario.id, this.usuario)
      .then(
          response => {
            this.msg = {
              titulo: "Sucesso",
              mensagem: "Suas informações foram alteradas com sucesso",
              botoes: [
              {
                mensagem: "OK",
                evento: "fechar"
              }]
            };
          },
          erro => {
            this.msg = {
              titulo: "Opa neném",
              mensagem: "Algo deu errado ao alterar suas informações",
              botoes: [
              {
               mensagem: "Tentar Novamente",
               evento: "fechar"
              }]
            };
            
            this.getUsuario();
          }
        );

        this.msg.visivel = true;
    },
    cancelar()
    {
      this.msg = {
        titulo: "Cancelamento",
        mensagem: "Deseja restaurar os valores anteriores?",
        botoes: [
        {
          mensagem: "Sim",
          evento: "restaurar"
        },
        {
          mensagem: "Não",
          evento: "cancelar"
        }],
        visivel: true
      };
    },
    mudarSenha()
    {
      this.msg = {
        titulo: "Sucesso",
        mensagem: "Sua senha foi alterada com sucesso",
        botoes : [{
            mensagem: "Ok",
            evento: "fechar"
        }],
        visivel: true
      };
    }
  },
  mounted() 
  {
    var lista = document.getElementById("estado");
    lista.value = this.usuario.estado;

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
        this.usuario.celular = `(${areaCode}) ${middle}${last[0]}-${last.substring(1)}`;
      else if(input.length > 6)
        this.usuario.celular = `(${areaCode}) ${middle}-${last}`;
      else if(input.length > 2)
        this.usuario.celular = `(${areaCode}) ${middle}`;
      else if(input.length > 0)
        this.usuario.celular = `(${areaCode}`;
    };

    const inputElement = document.getElementById('celular');
    inputElement.addEventListener('keydown', enforceFormat);
    inputElement.addEventListener('keyup', formatToPhone);
  },
  created() 
  {
    document.title = "Configurações";

    this.$http
    .get("https://servicodados.ibge.gov.br/api/v1/localidades/estados")
    .then(response => this.siglas = response.body);

    this.getUsuario();
  },
  beforeCreate() 
  {
    if (!this.$session.exists())
      this.$router.push('/');
  }
}
</script>

<style scoped src="../../css/estrelas.css"></style>
<style scoped>
.flex {
  display: flex;
  grid-gap: 15px;
}

.nascimento {
  margin: 0 0 5px;
  background-color: transparent;
  border-radius: 5px;
  border: 2px solid #acacac;
  position: relavite;
}

.nascimento label {
  color: rgb(11, 92, 163);
  font-size: .9em;
  font-weight: bold;
  margin: 2px 8px;
  position: absolute;
}

#dataNasc {
  display: flex;
  justify-content: space-between;
  box-sizing: border-box;
  border-radius: 5px;
  padding: 14px 0 0;
}

#dataNasc p {
  color: rgb(11, 92, 163);
  font-size: 1.5em;
  margin: 0 ;
}

#dataNasc input{
  width: 30%;
  border: none;
  font-size: 1.2em;
  border-radius: 5px;
  width: 100%;
  box-sizing: border-box;
  background: transparent;
  color: whitesmoke;
}

.input-container {
  position: relative;
}

.input-container label {
  position: absolute;
  font-size: 1.2em;
  top: 22%;
  left: 20px;
  cursor: text;
  color: rgb(11, 92, 163);
  font-weight: bold;
}

.input-container input {
  border-radius: 5px;
  border: 2px solid #acacac;
  padding: 20px 8px 2px;
}

.campos:focus + label, .campo-valido label {
  top: 8%;
  left: 10px;
  font-size: 0.9em;
}

.campos {
  font-size: 1.2em;
  width: 100%;
  padding: 18px 15px 2px;
  box-sizing: border-box;
}

.cidade_estado {
  display: flex;
  background-color: transparent;
  border: 2px solid #acacac;
  width: fit-content;
  border-radius: 5px;
}

#cidade {
  background: transparent;
  border: none;
  padding: 18px 10px 2px !important;
}

#estado {
  width: fit-content;
  background-color: rgba(116, 116, 116, 0.45) !important;
  border-left: 2px solid #acacac;
}

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
  align-items: stretch;
  grid-gap: 10px;
}

.informacoes {
  width: 50%;
  padding: 15px;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 10px;
  display: flex;
  flex-direction: column;
  grid-gap: 15px;
  box-sizing: border-box;
}

.informacoes:nth-child(2) > div:last-child {
  margin-top: auto;
}

#principal {
  display: flex;
}

@media only screen and (max-width: 1100px) {
  #principal {
    display: inline;
  }

  #foto {
    margin: auto;
  }

  .flex {
    flex-direction: column;
  }
}

@media only screen and (max-width: 425px) {
  #principal {
    display: inline !important;
  }

  #foto {
    margin: auto !important;
  }
}

#avaliacao {
  margin-top: 5.9%;
  border-radius: 10px;
  padding: 8px 16px;
  height: max-content;
  background: #ecb318; 
  display: flex;
  flex-direction: column;
}

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

label{
  color: whitesmoke;
}

.campos {
  box-sizing: border-box;
  border-radius: 5px;
  background-color: transparent;
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
  border: 2px solid pink;
  border-radius: 30px;
}

.cancelar:hover {
  border: 2px solid rgb(255, 99, 99);
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
