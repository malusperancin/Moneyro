<template>
  <div class="pag">
    <Menu />
    <Cabecalho/>
    <div class="centro"> 
      <div class="feed">
        <div class="postagem" v-for="postagem in conteudos">
          <div v-if="postagem.tipo == 'noticia'">
            <p class="titulo">{{postagem.titulo}}</p>
            <p class="texto">{{postagem.texto}}</p>
            <img class="imagem" :src="postagem.imagem">
            <div class="rodape">
              <span>
                <div class="assunto">{{postagem.assunto}}</div>
                <div class="data">{{postagem.data}}</div>
              </span>
              <div class="curtidas">{{postagem.curtidas}} <img src="../../images/fav.svg"> </div>
            </div>
          </div>
          <div v-if="postagem.tipo == 'artigo'">
            <p class="titulo">{{postagem.titulo}}</p>
            <p class="texto">{{postagem.texto}}</p>
            <img :src="postagem.imagem">
            <div class="rodape">
              <div>
                <div class="assunto">{{postagem.assunto}}</div>
                <div class="curtidas">{{postagem.curtidas}}</div>
              </div>
              <div class="data">{{postagem.data}}</div>
            </div>
          </div>
          <div v-if="postagem.tipo == 'video'">
            <p class="titulo">{{postagem.titulo}}</p>
            <p class="texto">{{postagem.texto}}</p>
            <img :src="postagem.imagem">
            <div class="rodape">
              <div class="assunto">{{postagem.assunto}}</div>
              <div class="curtidas">{{postagem.curtidas}}</div>
              <div class="data">{{postagem.data}}</div>
            </div>
          </div>
          <div v-if="postagem.tipo == 'dica'">
            <p class="titulo">{{postagem.titulo}}</p>
            <p class="texto">{{postagem.texto}}</p>
            <img :src="postagem.imagem">
            <div class="rodape">
              <div class="assunto">{{postagem.assunto}}</div>
              <div class="curtidas">{{postagem.curtidas}}</div>
              <div class="data">{{postagem.data}}</div>
            </div>
          </div>
        </div>
      </div>
      <div>
      <div class="filtros">
        <label class="container">Notícias
          <input type="radio" checked="checked" name="radio">
          <span class="checkmark"></span>
        </label>
        <label class="container">Vídeos
          <input type="radio" name="radio">
          <span class="checkmark"></span>
        </label>
        <label class="container">Artigos
          <input type="radio" name="radio">
          <span class="checkmark"></span>
        </label>
        <label class="container">Dicas
          <input type="radio" name="radio">
          <span class="checkmark"></span>
        </label>
        </div>
        <div class="alta">
          <p class="titulo">Em alta</p> 
          <div class="enumeracao" v-for="(alta, i) in altas">
            <span class="numeros">{{i+1}}</span>
            <p class="tit">{{alta.titulo}}</p>


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
    Cabecalho
  },
  data() {
    return {
      login: false,
      altas: [
        {
          titulo: "Homem invade escola e mata crianças e funcionárias em Santa Catarina"
        },
        {
          titulo: "Paulo Gustavo"
        },
        {
          titulo: "Cloroquina"
        },
        {
          titulo: "São Paulo: as últimas notícias sobre a pandemia"
        },
        {
          titulo: "Colômbia vive semana de protestos; ao menos 19 manifestantes foram mortos e centenas ficaram feridos"
        },
        {
          titulo: "Bolsonaro queria que Anvisa mudasse bula da cloroquina, diz Mandetta em CPI da Covid-19"
        },
      ],
      conteudos: [
        {
          titulo: "Rafael Portugal diz que irá colocar Gil novamente no 'BBB' 21 e Boninho se pronuncia",
          link:"https://kogut.oglobo.globo.com/noticias-da-tv/noticia/2021/05/rafael-portugal-diz-que-ira-colocar-gil-novamente-na-casa-e-boninho-se-pronuncia.html",
          texto: "Portugal postou uma foto com a frase: “Vou colocar o Gil na casa de novo. Não quero nem saber!”. Na legenda, ele escreveu: “Tá resolvido”. Nos comentários, o diretor do programa escreveu: 'Bora, concordo'.",
          imagem: "https://s2.glbimg.com/Ixaj3VTK0so1XmtEdOM0lqZpE0w=/640x424/top/i.glbimg.com/og/ig/infoglobo/f/original/2021/05/04/image-1_3.jpg",
          assunto: "BBB",
          data: "04/05/2021",
          curtidas: 5,
          tipo: "noticia"
        },
        {
          titulo: "Guedes: país teve desempenho 'bastante razoável' na pandemia",
          link:"https://noticias.uol.com.br/ultimas-noticias/ansa/2021/05/04/papa-cobra-regulamentacao-do-mercado-financeiro.htm",
          texto: "O ministro da Economia, Paulo Guedes, argumentou nesta terça-feira (4) que o Brasil",
          imagem: "https://img.r7.com/images/paulo-guedes-audiencia-publica-comissoes-camara-04052021122850483?dimensions=771x420",
          assunto: "Economy",
          data: "04/05/2021",
          curtidas: 5,
          tipo: "noticia"
        },
        {
          titulo: "Papa cobra regulamentação do mercado financeiro",
          link: "https://kogut.oglobo.globo.com/noticias-da-tv/noticia/2021/05/rafael-portugal-diz-que-ira-colocar-gil-novamente-na-casa-e-boninho-se-pronuncia.html",
          texto: "VATICANO, 4 MAI (ANSA) - O Vaticano divulgou nesta terça-feira (4) uma mensagem em que o papa Francisco defende a regulamentação da especulação financeira no mundo e pede a construção de uma 'economia inclusiva e sustentável'",
          imagem: "https://ibcdn.canaltech.com.br/tSVFGtIt8j4M5Kx3Ay8PLS_5b0U=/512x288/smart/i11063.jpeg",
          assunto: "Economy Religion",
          data: "04/05/2021",
          curtidas: 5,
          tipo: "noticia"
        },
        {
          titulo: "PAULO GUEDES QUER TAXAR OS LIVROS! TE CONTAMOS TUDO AQUI!",
          link: "https://www.youtube.com/watch?v=t5eapLCabOU",
          texto: "Na semana passada, Receita Federal, disse em um documento que os livros podem perder a isenção tributária porque no Brasil, quem lê é a população mais rica, que recebe mais de 10 salários mínimos.",
          assunto: "Economy Bolsonaro Burrices",
          data: "03/05/2021",
          curtidas: 100000,
          tipo: "video"
        },
        {
          titulo: "",
          link: "",
          texto: "Dependendo da situação, não dá para fazer tudo ao mesmo tempo. Poupar não significa poupar muito. Você consegue poupar R$ 10, R$ 20 ou R$ 30. Vá juntando os centavos quando pagar uma compra no débito em vez de em dinheiro, assim você economiza.",
          assunto: "economizar",
          data: "04/01/2021",
          curtidas:578 ,
          tipo: "dica"
        },
        {
          titulo: "Golpe financeiro: como identificar e fugir de todos eles!",
          link: "https://conteudos.mepoupenaweb.com.br/mepoupedegolpes/",
          texto: "O golpe tá aí…'Cai quem quer??' NADA DISSO! Quem cai num golpe financeiro é vítima e pode buscar ajuda! Porém, mais fácil do que remediar é prevenir, certo? Por isso, nesta página você vai encontrar TUDO sobre golpes financeiros: quais os mais comuns hoje, como fugir deles e o que fazer caso você ou alguém que você conhece caia em uma dessas armadilhas.",
          imagem: "https://d9hhrg4mnvzow.cloudfront.net/conteudos.mepoupenaweb.com.br/mepoupedegolpes/6aad5399-nath-frase_1000000000000000000028.png",
          assunto: "Golpe",
          data: "29/04/2021",
          curtidas:18000 ,
          tipo: "blog"
        }
      ]
    };
  },
  methods: {},
  created(){
    document.title = "Moneyro";
  },
  beforeCreate() {
    if(this.$session.exists())
      this.$router.push("usuario");
  },
};
</script>

<style scoped>
.centro{
  display: grid;
  grid-template-columns: 2fr 1fr;
  padding-top: 10%;
  color: white;
  grid-gap: 100px;
}

/* ---------- FEED ----------- */

p {
  padding: 0;
  margin: 0;
}

.feed {
}

.postagem {
  background: #303030;
  padding: 50px 40px;
  margin-bottom: 35px;
  border-radius: 10px;
  font-size: 1.2em;
  font-weight: 400;
  line-height: 32px;
  display: flex;
  flex-direction: column;
  width: 100%;
}

.texto {
  margin-bottom: 15px;
}

.imagem {
  flex: 1;
  width: 100%;
}

.rodape {
  display: flex;
  margin-top: 10px;
  font-size: 1.25em;
  justify-content: space-between;
}

.rodape span {
  display: flex;
}

.rodape span div {
  margin: 0 10px 0 0;
}

.assunto {
}

.curtidas {
  display: flex;
  margin: 0 10px;
  font-size: 1.8em;
  background: gray;
  justify-content: space-between;
  align-items: center;
  padding: 8px 12px;
  border-radius: 5px;
  cursor: pointer;
}

.datas {
  
}

.titulo{
  font-size: 1.5em;
  line-height: 32px;
  margin-bottom: 1%;
}


/*------- FILTRO DE RADIO BUTTONS ------*/
.filtros{
  background-color: #303030;
  border-radius: 10px;
  padding: 5% 0 5% 5%;
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
.alta{
  background-color: #303030;
  border-radius: 10px;
  padding: 5% 5% 5% 8%;
  margin: 0 0 0 10px;
}

.enumeracao{
  display:flex;
  position:relative;
  margin:0 0 4% -5%;
  background-color:rgba(255, 255, 255, 0.078);
  border-radius: 10px;
  min-height: 35px;
  padding: 4px 6px 4px 0;
}
.tit{
  margin: 0 0 0 15%;
}
.numeros{
  background-color:hsl(208, 80%, 24%);
  margin:3px 0 0 10px;
  border-radius:50%;
  width:9%;
  position:absolute;
  text-align:center;
  font-size:1.2em;
}
</style>


