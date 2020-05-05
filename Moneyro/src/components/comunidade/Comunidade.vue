<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <div class="centro">
      <div class="geral carousel" id="demo">
        <div class="titulo">
          Vídeos
          <div class="busca">
            <div>
              <img src="https://image.flaticon.com/icons/svg/483/483356.svg" alt width="20" />
            </div>
            <input type="text" name="busca" placeholder="Buscar" v-model="buscaVideo" />
          </div>
        </div>
        <div class="conteudos">
          <div class="lista-videos-item" v-for="(video, i) of filtraVideo" :key="i">
            <Video class="slide" :titulo="video.titulo" :link="video.link" :assunto="video.assunto"></Video>
          </div>
        </div>
      </div>
      <div class="geral">
        <div class="titulo">
          Artigos
          <div class="busca">
            <div>
              <img src="https://image.flaticon.com/icons/svg/483/483356.svg" alt width="20" />
            </div>
            <input type="text" name="busca" placeholder="Buscar" v-model="buscaArtigo" />
          </div>
        </div>
        <div class="conteudos">
          <div class="lista-artigos-item" v-for="(artigo,i) of filtraArtigo" :key="i">
            <Artigo
              :titulo="artigo.titulo"
              :link="artigo.link"
              :assunto="artigo.assunto"
              :foto="artigo.foto"
            ></Artigo>
          </div>
        </div>
      </div>
      <div class="geral">
        <div class="titulo">Citações</div>
        <div class="conteudos">
          <div class="lista-citacoes-item" v-for="citacao in citacoes" :key="citacao.texto">
            <Citacao :texto="citacao.texto" :autor="citacao.autor"></Citacao>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/float-perfil/Float-Perfil.vue";
import Video from "../shared/conteudos/Video.vue";
import Citacao from "../shared/conteudos/Citacao.vue";
import Artigo from "../shared/conteudos/Artigo.vue";

export default {
  components: {
    Menu,
    Perfil,
    Video,
    Citacao,
    Artigo
  },
  data() {
    return {
      buscaVideo: "",
      buscaArtigo: "",
      videos: [
        {
          assunto: "Noticia semanal",
          link: "https://www.youtube.com/embed/NP45AmnSRUs?rel=0", // &modestbranding=1&autohide=0&showinfo=0&controls=0
          titulo: "ESQUENTANDO A JANTA DO MARIDÃO IRRRAAÁÁ"
        },
        {
          assunto: "Top 10",
          link: "https://www.youtube.com/embed/kBJgtvhMXx4?rel=0",
          titulo: "TOP 10 TORNEIRAS"
        },
        {
          assunto: "Aviso Importante",
          link: "https://www.youtube.com/embed/qDH7-XPX9aE?rel=0",
          titulo: "LAMBE MEU CU CHEIO DE MERDA"
        }
      ],
      artigos: [
        {
          assunto: "Trabalho",
          link:
            "http://noticiasenegocios.com.br/2020/03/o-trabalho-remoto-durante-a-pandemia-do-coronavirus/",
          titulo: "O trabalho remoto durante a pandemia do coronavírus",
          foto:
            "https://s2.glbimg.com/3whx-uMjWYJlmwse4fLBLc3Bo_Y=/640x424/i.glbimg.com/og/ig/infoglobo/f/original/2020/03/29/gret.jpg"
        },
        {
          assunto: "Noticia semanal",
          link:
            "https://g1.globo.com/politica/noticia/2020/04/29/apos-decisao-de-moraes-bolsonaro-torna-sem-efeito-nomeacao-de-ramagem-para-direcao-da-pf.ghtml",
          titulo:
            "Após decisão de Moraes, governo desiste de nomear Ramagem e procura outro diretor para a PF",
          foto:
            "https://thumbs.dreamstime.com/z/not%C3%ADcia-extra-34903764.jpg"
        }
      ],
      citacoes: [
        {
          texto: "lambe meu cu cheio de merda",
          autor: "Web Diva Tula Luana"
        },
        {
          texto: "Da bom dia pra sua mãe, aquela cachorra",
          autor: "Vizinho"
        },
        {
          texto:
            "Se o mundo existe, gracas a deus, por que existe? por que, gracas a deus, nos fizemos o mundo gracas a deus porque deus fez o mundo mas eu falei uma palavra certo se nao nao existimono.. mos se nao existiamos nós, o que ia acontecer?",
          autor: "Ines Brasil"
        },
        {
          texto: "Gi, Sumaré só tem velho igual Valinhos?",
          autor: "Vinicius irmão da jovanna"
        },
        {
          texto:
            "Nah, em sumaré todo mundo é jovem pq não chegam na velhice, eles morrem baleado.",
          autor: "Jovana"
        }
      ]
    };
  },
  computed: {
    filtraVideo() {
      if (this.buscaVideo) {
        let exp = new RegExp(this.buscaVideo.trim(), "i");
        return this.videos.filter(video => exp.test(video.assunto));
      } else {
        return this.videos;
      }
    },
    filtraArtigo() {
      if (this.buscaArtigo) {
        let exp = new RegExp(this.buscaArtigo.trim(), "i");
        return this.artigos.filter(art => exp.test(art.assunto));
      } else {
        return this.artigos;
      }
    }
  }
};
</script>
<!--
<script src="../../PureJSCarousel-master/purejscarousel.js">
var carouselDefault = new PureJSCarousel({
  carousel: "#demo",
  slide: ".slide"
});

var carouselDefault = new PureJSCarousel({
  // CSS selector for carousel wrapper
  carousel: "#carousel-default",

  // CSS selector for carousel items
  slide: ".slide",

  // CSS selectors for next / prev navigation
  btnNext: document.createElement("button"),
  btnPrev: document.createElement("button"),

  // slides the items one by one
  oneByOne: false,

  // animation speed
  speed: 1000,

  // activate slide
  activeIndex: 0,

  // animation delay
  delay: 0,

  // easing effect
  effect: "linear",

  // autopaly options
  autoplay: false,
  autoplayDelay: 1000,
  autoplayStartDelay: 1000,
  autoplayDirection: "next",

  // infinite looping
  infinite: false
});
var carouselDefault = new PureJSCarousel({
  carousel: "#carousel-default",
  slide: ".slide"
});

// Go to next slide
carouselDefault.goToNext();

// Go to previous slide
carouselDefault.goToPrev();

// Go to specific slide
carouselDefault.goToNext(slideIndex);

// Disable carousel controls
carouselDefault.disableControl();

// Enable carousel controls
carouselDefault.enableControl();

// Destroy the carousel
carouselDefault.destroy();

// Enable autoplay
carouselDefault.startAutoplay(autoplayDirection);

// Stop autoplay
carouselDefault.stopAutoplay();
</script>
-->
<style scoped>
.geral {
  padding: 20px;
}

.titulo {
  border-radius: 15px;
  padding: 0px 20px;
  font-size: 2em;
  margin: 5;
  background-image: linear-gradient(to right, #0b5394, rgba(133, 95, 95, 0));
  display: flex;
}

::placeholder {
  color: black;
}

.busca {
  display: flex;
  margin-left: 30px;
}

.busca:hover > input {
  width: 100%;
  background-color: rgba(62, 62, 112, 0.322);
}

input:focus {
  width: 100% !important;
  background-color: rgba(62, 62, 112, 0.322);
}

.busca input {
  margin-left: 15px;
  background-color: inherit;
  border: none;
  padding: 4px 12px;
  font-size: 0.8em;
  color: black;
  width: 0;
}

.conteudos {
  overflow: auto;
  display: flex;
  /* white-space:; */
}

.conteudos div {
  display: inline-block;
  margin-top: 6px;
  margin-bottom: 10px;
}

.conteudos::-webkit-scrollbar {
  width: 10px;
  background: transparent;
}

/* configurando scroll */
.conteudos::-webkit-scrollbar-track {
  /* background: rgba(190, 154, 154); */
}

.conteudos::-webkit-scrollbar-thumb {
  border-radius: 10px;
  background: rgba(87, 86, 86, 0.637);
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.5);
}

/* .conteudos::-webkit-scrollbar-button {
  color: white;
  background: red;
} */

.conteudos::-webkit-scrollbar-arrow {
  color: white;
  background: yellowgreen;
}

/* .pure-js-carousel {
  overflow: hidden;
}

.pure-js-carousel-list:before,
.pure-js-carousel-list:after {
  content: "";
  display: table;
}

.pure-js-carousel-list:after {
  clear: both;
}

.pure-js-carousel-slide {
  float: left;
}

.pure-js-carousel-btn {
  background: transparent;
  border: 0;
  box-shadow: none;
  cursor: pointer;
  height: 20px;
  margin-top: -35px;
  position: absolute;
  top: 50%;
  width: 20px;
}

.pure-js-carousel-btn-next {
  border-bottom: 3px solid #f00;
  border-right: 3px solid #f00;
  right: 5px;
  -moz-transform: rotate(315deg);
  -webkit-transform: rotate(315deg);
  transform: rotate(315deg);
}

.pure-js-carousel-btn-prev {
  border-bottom: 3px solid #f00;
  border-left: 3px solid #f00;
  left: 5px;
  -moz-transform: rotate(45deg);
  -webkit-transform: rotate(45deg);
  transform: rotate(45deg);
}

.pure-js-carousel-dots {
  float: left;
  margin-top: 15px;
  text-align: center;
  width: 100%;
}

.pure-js-carousel-dot {
  display: inline-block;
  margin: 0 5px;
}

.pure-js-carousel-dot-btn {
  background: green;
  border-radius: 50%;
  height: 20px;
  width: 20px;
}

.active .pure-js-carousel-dot-btn {
  background: blue;
} */
</style>




