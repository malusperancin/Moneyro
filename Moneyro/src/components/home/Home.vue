<template>
  <div class="pag">
    <Cabecalho :filtro="filtro"/>
    <Menu v-if="$session.exists()"/>
    <Topo />
    <Mensagem
      :msg="msg"
      v-if="msg.visivel" 
      v-on:cancelar="msg.visivel = false"
      v-on:logar="login = true, msg.visivel = false"/>
    <Login v-show="login" v-on:fechar="login = false"/>
    <div class="centro">
      <div id="conteudo">
        <div class="feed">
          <div class="postagem" v-bind:key='i' v-for="(postagem,i) of filtraPostagens">
            <!-- BLOG E NOTICIA -->
            <div v-if="postagem.tipo == 'blog' || postagem.tipo == 'noticia'" :id="postagem.id">
                      {{filtro}}
              <p class="titulo">{{ postagem.titulo }}</p>
              <div class="data">{{ postagem.data }}</div>
              <p class="texto">{{ postagem.texto }}</p>
              <img alt="" class="imagem" :src="postagem.imagem" />
              <div class="rodape">
                <span>
                  <div class="assunto">{{ postagem.assunto }}</div>
                </span>
                <div class="curtidas" v-bind:class="{like: postagem.curtido}" v-on:click="postagem.curtido?descurtir(i):curtir(i)">
                  {{ postagem.curtidas }} <img alt="" src="../../images/fav.svg" />
                </div>
              </div>
            </div>  
            <!-- VIDEO -->
            <div v-if="postagem.tipo == 'video'" :id="postagem.id">
              <p class="titulo">{{ postagem.titulo }}</p>
              <div class="data">{{ postagem.data }}</div>
              <p class="texto">{{ postagem.texto }}</p>
              <iframe width="560" height="315" src="https://www.youtube.com/embed/t5eapLCabOU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
              <div class="rodape">
                <span>
                  <div class="assunto">{{ postagem.assunto }}</div>
                </span>
                <div class="curtidas" v-bind:class="{like: postagem.curtido}" v-on:click="postagem.curtido?descurtir(i):curtir(i)">
                  {{ postagem.curtidas }} <img src="../../images/fav.svg" />
                </div>
              </div>
            </div>
            <!-- DICA -->
            <div v-if="postagem.tipo == 'dica'" :id="postagem.id">
              <p class="titulo">{{postagem.titulo}} once said: </p>
              <div class="data">{{ postagem.data }}</div>
              <p class="texto">{{ postagem.texto }}</p>
              <div class="rodape">
                <span>
                  <div class="assunto">{{ postagem.assunto }}</div>
                </span>
                <div class="curtidas" v-bind:class="{like: postagem.curtido}" v-on:click="postagem.curtido?descurtir(i):curtir(i)">
                  {{ postagem.curtidas }} <img src="../../images/fav.svg" />
                </div>
              </div>
            </div>
          </div>
        </div>
        <div id="direita">
          <div class="saldo" v-if="$session.exists()" v-on:click="$router.push('usuario')">
            <div>
              <p>{{ $session.get("usuario").apelido }}</p>
              <p><big><strong> {{ $session.get("usuario").pontos }}</strong></big> pontos</p>
            </div>
            <img :src="'src/images/perfil' + $session.get('foto') + '.png'"/>
          </div>
          <div class="filtros">
            <p class="titulo">Mostrar apenas:</p>
            <br>
            <label class="container"
              >Notícias
              <input type="checkbox" name="radio" checked="checked" v-model="tipo" value="noticia"/>
              <span class="checkmark"></span>
            </label>
            <label class="container"
              >Vídeos
              <input type="checkbox" name="radio" checked="checked" v-model="tipo" value="video"/>
              <span class="checkmark"></span>
            </label>
            <label class="container"
              >Blogs
              <input type="checkbox" name="radio" checked="checked" v-model="tipo" value="blog"/>
              <span class="checkmark"></span>
            </label>
            <label class="container"
              >Dicas
              <input type="checkbox" name="radio" checked="checked" v-model="tipo" value="dica"/>
              <span class="checkmark"></span>
            </label>
          </div>
          <div class="alta">
            <p class="titulo">Em alta</p>
            <div v-bind:key='i' v-for="(conteudo, i) in conteudos">
             <div class="enumeracao" v-if="conteudo.emAlta == true" v-else="i--" v-on:click ="clicou(conteudo.id)">
              <span class="numeros">{{ i + 1}}</span>
              <p class="tit">{{ conteudo.titulo }}</p>
             </div> 
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Cabecalho from "../shared/cabecalho-feed/CabecalhoFeed.vue";
import Menu from "../shared/menu/Menu.vue";
import Topo from "../shared/voltar-topo/Voltar-Topo.vue";
import Mensagem from "../shared/mensagem/Mensagem.vue";
import Login from '../shared/login/Login.vue'

export default {
  components: {
    Cabecalho,
    Menu,
    Topo,
    Mensagem,
    Login
  },
  data() {
    return {
      posiScroll: 0,
      login: false,
      filtro: "",
      tipo: ["noticia", "video", "blog", "dica"],
      altas: [],
      conteudos: [],
      msg: {
        visivel: false,
        titulo: "",
        mensagem: "",
        botoes: [],
      },
    };
  },
  methods: {
    clicou(id){
      document.getElementById(id).scrollIntoView({ behavior: 'smooth', block: 'center' });
    },
    getConteudos(){
      var id = 0
      if(this.$session.exists())
        id = this.$session.get("id");

      this.$http
        .get("https://localhost:5001/api/conteudos/" + id) 
        .then(
          dados => {
            this.conteudos = dados.body;
          }
        ); 
    
    },
    curtir(i){
      if(this.$session.exists())
      {
        var post = {
          id: 1,
          idConteudo: this.conteudos[i].id,
          idUsuario: this.$session.get("id")
        };
        
        this.$http
        .post("https://localhost:5001/api/curtidasUsuarios", post) 
        .then(
        dados => {
          this.conteudos[i].curtidas++;
          this.conteudos[i].curtido = true;
        }); 
      } 
      else
      {
        this.msg = {
          visivel: true,
          titulo: "Ops",
          mensagem: "Você precisa estar logado para curtir as postagens!",
          botoes: [
            {
              mensagem: "Cancelar",
              evento: "cancelar",
            },
            {
              mensagem: "Logar",
              evento: "logar",
            }
          ],
        };
      }
    },
    descurtir(i){
      var post = {
          id: 1,
          idConteudo: this.conteudos[i].id,
          idUsuario: this.$session.get("id")
        };

      this.$http
        .put("https://localhost:5001/api/curtidasUsuarios", post) 
        .then(
        dados => {
          this.conteudos[i].curtidas--;
          this.conteudos[i].curtido = false;
        });
    },
    getPerfil() {
      var saldo = this.$session.get("usuario").saldo;
      var situacao;

      if(saldo <= -20)
        situacao = 2;

      if(saldo <= -200)
        situacao= 1;

      if(saldo >= 100)
        situacao = 4;

      if(saldo >= 500)
        situacao = 5;
           
      if(saldo > -20 && saldo < 100)
        situacao = 3;

      this.$http
        .get("https://localhost:5001/api/situacoes")
        .then(
          dados => {
            document.getElementsByClassName("saldo")[0].style.backgroundColor = dados.body[(situacao-1)].cor;
          },
          erro => {
            console.log(erro.bodyText);
          }
        );
    }
  },
  created() {
    document.title = "Moneyro";

    this.getConteudos();
    this.getPerfil();

    this.posiScroll = window.pageYOffset;
    window.onscroll = function() {

      if(window.scrollY.valueOf() > 200)
      {
        if (this.posiScroll > window.pageYOffset) //subiu => mostrou
          document.getElementById("header").style.top = "0";
        else //desceu => sumiu
          document.getElementById("header").style.top = "-110px";
  
        this.posiScroll = window.pageYOffset;
      }
    }
  },
  computed: {
    filtraPostagens() {
      var ret = this.conteudos.filter(c => this.tipo.includes(c.tipo));

      if (this.filtro) {
        let exp = new RegExp(this.filtro.trim(), "i");
        return ret.filter(c => exp.test(c.titulo));
      }
      
      return ret;
    },
  },
};
</script>

<style scoped>
@media only screen and (max-width: 1000px) {
  #conteudo {
    flex-direction: column-reverse;
  }

  .centro {
    padding: 160px 120px !important;
  }
}


.centro {
  padding: 160px 180px;
}

#conteudo {
  position: relative;
  display: flex;
  color: white;
  grid-gap: 10px;
  min-height: 800px;
}

.feed {
}

#direita{
  min-width: 400px;
  display: flex;
  flex-direction: column;
  grid-gap: 10px;
}

.saldo {
  display: flex;
  background: grey;
  justify-content: space-between;
  padding: 10px;
  border-radius: 10px;
}

.saldo div {
  font-size: 2em;
  flex: 1;
  padding-left: 10px;
}

.saldo img {
  width: 120px;
  border-radius: 10px;
}

/* ---------- FEED ----------- */

p {
  padding: 0;
  margin: 0;
}

.postagem {
  background: #101010;
  padding: 40px 30px;
  margin-bottom: 20px;
  border-radius: 10px;
  border: solid 3px #232323;
  font-size: 1.2em;
  line-height: 32px;
  display: flex;
  flex-direction: column;
}

.texto {
  margin: 10px 0 20px 15px;
  color: Gainsboro;
  font-size: 19px;
  line-height: 25px;
  word-wrap: break-word;
}

.imagem {
  flex: 1;
  width: 96%;
  border-radius: 5px;
  margin-left: 15px;
}

.rodape {
  display: flex;
  margin-top: 10px;
  font-size: 1.25em;
  justify-content: space-between;
  padding: 0 0 0 15px;
  align-items: center;
  /*background: red;*/
}

.rodape span {
  display: flex;
}

.rodape span div {
  margin: 0 10px 0 0;
}

.assunto {
  background: #202020;
  border-radius: 5px;
  padding: 2px 14px;
}

.curtidas {
  display: flex;
  margin: 0 10px;
  font-size: 1.8em;
  background: gray;
  justify-content: center;
  align-items: center;
  padding: 0 8px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 1.1em;
}

.like {
  color: #ff3232;
  background: white;
  font-weight:550;
}

.like img{
  /* filter:red; */
  filter: contrast(116%) invert(68%) sepia(90%) saturate(6532%) hue-rotate(338deg) brightness(95%);
}

.curtidas img {
  margin: 4px 0 0 5px;
}

.data {
  font-size: 0.75em;
  color: gray;
}

.titulo {
  font-size: 1.5em;
  line-height: 32px;
  margin-bottom: 1%;
  font-weight: bold;
  color: Gainsboro;
  word-break: break-word;
}  

iframe{
  margin-left: 15px;
}

/*------- FILTRO DE RADIO BUTTONS ------*/

.filtros {
  background-color: #303030;
  border-radius: 10px;
  padding: 8% 0 5% 8%;
}

.container {
  display: flex;
  align-items: center;
  position: relative;
  padding-left: 35px;
  margin-bottom: 12px;
  cursor: pointer;
  font-size: 22px;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

/* Hide the browser's default radio button */
.container input {
  position: absolute;
  opacity: 0;
  cursor: pointer;
}

/* Create a custom radio button */
.checkmark {
  position: absolute;
  top: 4px;
  left: 0;
  height: 25px;
  width: 25px;
  background-color: #eee;
  border-radius: 50%;
}

/* On mouse-over, add a grey background color */
.container:hover input ~ .checkmark {
  background-color: #ccc;
}

/* When the radio button is checked, add a blue background */
.container input:checked ~ .checkmark {
  background-color: hsl(208, 80%, 24%);
}

/*-------- EM ALTA--------*/
.alta {
  background-color: #303030;
  border-radius: 10px;
  padding: 5px 15px 5px 30px;
}

.alta .titulo {
  padding: 15px 0px;
}

.enumeracao {
  display: flex;
  position: relative;
  margin: 0 0 4% -5%;
  background-color: rgba(255, 255, 255, 0.078);
  border-radius: 10px;
  min-height: 35px;
  padding: 2% 4% 2% 0;
  align-items: center;
}

.tit {
  margin: 0 0 0 15%;
}

.numeros {
  background-color: hsl(208, 80%, 24%);
  margin: 3px 0 0 10px;
  border-radius: 50%;
  width: 25px;
  position: absolute;
  text-align: center;
}
</style>


