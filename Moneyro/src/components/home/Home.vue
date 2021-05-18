<template>
  <div class="pag">
    <Menu />
    <Cabecalho />
    <div class="centro">
      <div class="feed">
        <div class="postagem" v-bind:key='i' v-for="(postagem,i) in conteudos">
          <!-- BLOG E NOTICIA -->
          <div v-if="postagem.tipo == 'blog' || postagem.tipo == 'noticia'">
            <p class="titulo">{{ postagem.titulo }}</p>
            <div class="data">{{ postagem.data }}</div>
            <p class="texto">{{ postagem.texto }}</p>
            <img class="imagem" :src="postagem.imagem" />
            <div class="rodape">
              <span>
                <div class="assunto">{{ postagem.assunto }}</div>
              </span>
              <div class="curtidas" v-bind:class="{like: postagem.curtido}" v-on:click="curtir(i,this)">
                {{ postagem.curtidas }} <img src="../../images/fav.svg" />
              </div>
            </div>
          </div>  
          <!-- VIDEO -->
          <div v-if="postagem.tipo == 'video'">
            <p class="titulo">{{ postagem.titulo }}</p>
            <div class="data">{{ postagem.data }}</div>
            <p class="texto">{{ postagem.texto }}</p>
            <iframe width="560" height="315" src="https://www.youtube.com/embed/t5eapLCabOU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            <div class="rodape">
              <span>
                <div class="assunto">{{ postagem.assunto }}</div>
              </span>
              <div class="curtidas" v-bind:class="{like: postagem.curtido}" v-on:click="curtir(i,this)">
                {{ postagem.curtidas }} <img src="../../images/fav.svg" />
              </div>
            </div>
          </div>
          <!-- DICA -->
          <div v-if="postagem.tipo == 'dica'">
            <p class="titulo">{{postagem.autor}} once said: </p>
            <div class="data">{{ postagem.data }}</div>
            <p class="texto">{{ postagem.texto }}</p>
            <div class="rodape">
              <span>
                <div class="assunto">{{ postagem.assunto }}</div>
              </span>
              <div class="curtidas" v-bind:class="{like: postagem.curtido}" v-on:click="curtir(i, this)" >
                {{ postagem.curtidas }} <img src="../../images/fav.svg" />
              </div>
            </div>
          </div>
        </div>
      </div>
      <div id="direita">
        <div class="filtros">
          <label class="container"
            >Notícias
            <input type="checkbox" checked="checked" name="radio" />
            <span class="checkmark"></span>
          </label>
          <label class="container"
            >Vídeos
            <input type="checkbox" name="radio" />
            <span class="checkmark"></span>
          </label>
          <label class="container"
            >Blogs
            <input type="checkbox" name="radio" />
            <span class="checkmark"></span>
          </label>
          <label class="container"
            >Dicas
            <input type="checkbox" name="radio" />
            <span class="checkmark"></span>
          </label>
        </div>
        <div class="alta">
          <p class="titulo">Em alta</p>
          <div class="enumeracao" v-bind:key='i' v-for="(alta, i) in altas">
            <span class="numeros">{{ i + 1 }}</span>
            <p class="tit">{{ alta.titulo }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Menu from "../shared/menu-inicial/MenuInicial.vue";
import Cabecalho from "../shared/cabecalho-feed/CabecalhoFeed.vue";

export default {
  components: {
    Menu,
    Cabecalho,
  },
  data() {
    return {
      login: false,
      altas: [
        {
          titulo:
            "Homem invade escola e mata crianças e funcionárias em Santa Catarina",
        },
        {
          titulo: "Paulo Gustavo",
        },
        {
          titulo: "Cloroquina",
        },
        {
          titulo: "São Paulo: as últimas notícias sobre a pandemia",
        },
        {
          titulo:
            "Colômbia vive semana de protestos; ao menos 19 manifestantes foram mortos e centenas ficaram feridos",
        },
        {
          titulo:
            "Bolsonaro queria que Anvisa mudasse bula da cloroquina, diz Mandetta em CPI da Covid-19",
        },
      ],
      conteudos: [
        {
          titulo:
            "Rafael Portugal diz que irá colocar Gil novamente no 'BBB' 21 e Boninho se pronuncia",
          link:
            "https://kogut.oglobo.globo.com/noticias-da-tv/noticia/2021/05/rafael-portugal-diz-que-ira-colocar-gil-novamente-na-casa-e-boninho-se-pronuncia.html",
          texto:
            "Portugal postou uma foto com a frase: “Vou colocar o Gil na casa de novo. Não quero nem saber!”. Na legenda, ele escreveu: “Tá resolvido”. Nos comentários, o diretor do programa escreveu: 'Bora, concordo'.",
          imagem:
            "https://s2.glbimg.com/Ixaj3VTK0so1XmtEdOM0lqZpE0w=/640x424/top/i.glbimg.com/og/ig/infoglobo/f/original/2021/05/04/image-1_3.jpg",
          assunto: "BBB",
          data: "04/05/2021",
          curtidas: 5,
          tipo: "noticia",
          curtido: true
        },
        {
          titulo:
            "Guedes: país teve desempenho 'bastante razoável' na pandemia",
          link:
            "https://noticias.uol.com.br/ultimas-noticias/ansa/2021/05/04/papa-cobra-regulamentacao-do-mercado-financeiro.htm",
          texto:
            "O ministro da Economia, Paulo Guedes, argumentou nesta terça-feira (4) que o Brasil",
          imagem:
            "https://img.r7.com/images/paulo-guedes-audiencia-publica-comissoes-camara-04052021122850483?dimensions=771x420",
          assunto: "Economy",
          data: "04/05/2021",
          curtidas: 5,
          tipo: "noticia",
          curtido: false
        },
        {
          titulo: "Papa cobra regulamentação do mercado financeiro",
          link:
            "https://kogut.oglobo.globo.com/noticias-da-tv/noticia/2021/05/rafael-portugal-diz-que-ira-colocar-gil-novamente-na-casa-e-boninho-se-pronuncia.html",
          texto:
            "VATICANO, 4 MAI (ANSA) - O Vaticano divulgou nesta terça-feira (4) uma mensagem em que o papa Francisco defende a regulamentação da especulação financeira no mundo e pede a construção de uma 'economia inclusiva e sustentável'",
          imagem:
            "https://ibcdn.canaltech.com.br/tSVFGtIt8j4M5Kx3Ay8PLS_5b0U=/512x288/smart/i11063.jpeg",
          assunto: "Economy Religion",
          data: "04/05/2021",
          curtidas: 5,
          tipo: "noticia",
          curtido: true
        },
        {
          titulo: "PAULO GUEDES QUER TAXAR OS LIVROS! TE CONTAMOS TUDO AQUI!",
          link: "https://www.youtube.com/watch?v=t5eapLCabOU",
          texto:
            "Na semana passada, Receita Federal, disse em um documento que os livros podem perder a isenção tributária porque no Brasil, quem lê é a população mais rica, que recebe mais de 10 salários mínimos.",
          assunto: "Economy Bolsonaro Burrices",
          data: "03/05/2021",
          curtidas: 100000,
          tipo: "video",
          curtido: true
        },
        {
          texto:
            "Dependendo da situação, não dá para fazer tudo ao mesmo tempo. Poupar não significa poupar muito. Você consegue poupar R$ 10, R$ 20 ou R$ 30. Vá juntando os centavos quando pagar uma compra no débito em vez de em dinheiro, assim você economiza.",
          assunto: "Economizar",
          data: "04/01/2021",
          curtidas: 578,
          autor: "Nath Finanças",
          tipo: "dica",
          curtido: true
        },
        {
          titulo: "Golpe financeiro: como identificar e fugir de todos eles!",
          link: "https://conteudos.mepoupenaweb.com.br/mepoupedegolpes/",
          texto:
            "O golpe tá aí…'Cai quem quer??' NADA DISSO! Quem cai num golpe financeiro é vítima e pode buscar ajuda! Porém, mais fácil do que remediar é prevenir, certo? Por isso, nesta página você vai encontrar TUDO sobre golpes financeiros: quais os mais comuns hoje, como fugir deles e o que fazer caso você ou alguém que você conhece caia em uma dessas armadilhas.",
          imagem:
            "https://d9hhrg4mnvzow.cloudfront.net/conteudos.mepoupenaweb.com.br/mepoupedegolpes/6aad5399-nath-frase_1000000000000000000028.png",
          assunto: "Golpe",
          data: "29/04/2021",
          curtidas: 18000,
          tipo: "blog",
          curtido: false
        },
      ],
    };
  },
  methods: {
    curtir(id, div){
      // if usuario.logado
      var post = this.conteudos[id];

      if(post.curtido) // Descurtir
      {
        post.curtidas--;
        post.curtido = false;
      }
      else // curtir
      {
        post.curtidas++;
        post.curtido = true;
      }

      this.conteudos[id] = post;
    }
  },
  mounted() {
    var div = document.getElementById("direita");

    window.onscroll = function scrollFunction() {
      if (
        document.body.scrollTop > 260 ||
        document.documentElement.scrollTop > 260
         )
        {
          div.style.position = "fixed";
          div.style.left = "65.2%";
          div.style.top = "-15%";
          div.style.width = "350px";
        }
        else  
        {
          div.style.position = "relative";
          div.style.left = null;
          div.style.width = "350px";
          div.style.top = null;
        }
    };
  },
  created() {
    document.title = "Moneyro";
  },
  beforeCreate() {
    if (this.$session.exists()) this.$router.push("usuario");
  },
};
</script>

<style scoped>
.centro {
  display: grid;
  grid-template-columns: 2fr 1fr;
  padding: 10% 10% 10% 15%;
  color: white;
  grid-gap: 10px;
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

#direita{
   width: 350px;
}

.filtros {
  background-color: #303030;
  border-radius: 10px;
  padding: 8% 0 5% 8%;
  margin: 0 0 5% 10px;
  
}

.container {
  display: block;
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
  top: 0;
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
  margin: 0 0 0 10px;
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


