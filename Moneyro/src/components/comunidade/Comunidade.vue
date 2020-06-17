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
            <Video class="slide" :titulo="video.titulo" :video="video.video" :assunto="assuntos[(video.idAssunto-1)].nome"></Video>
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
              :link="artigo.artigo"
              :assunto="assuntos[(artigo.idAssunto-1)].nome"
              :foto="artigo.foto"
            ></Artigo>
          </div>
        </div>
      </div>
      <div class="geral">
        <div class="titulo">Citações</div>
        <div class="conteudos">
          <div class="lista-citacoes-item" v-for="citacao in citacoes" :key="citacao.texto">
            <Citacao :texto="citacao.dica" :autor="citacao.autor"></Citacao>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/perfil/Perfil.vue";
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
      videos: [],
      artigos: [],
      citacoes: [],
      assuntos:[]
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
  },
  beforeCreate() {
    if (!this.$session.exists()) {
      this.$router.push('/')
    }
  },
  created(){
    document.title = "Comunidade";
    
    this.$http
      .get("https://localhost:5001/api/videos")
      .then(response => {
        this.videos = response.body;
      }, 
      response => {
        alert("cu");
      });
      
    this.$http
      .get("https://localhost:5001/api/artigos")
      .then(response => {
        this.artigos = response.body;
      },response => {
        alert("cu");
      });

    this.$http
      .get("https://localhost:5001/api/tips")
      .then(response => {
        this.citacoes = response.body;
      },response => {
        alert("cu");
      });

      this.$http
      .get("https://localhost:5001/api/assuntos")
      .then(response => {
        this.assuntos = response.body;
      }, 
      response => {
        alert("cu");
      });
  }
};
</script>

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
  align-items: stretch;
  /* white-space:; */
}

.conteudos div {
  display: inline-block;
  margin-top: 6px;
  margin-bottom: 10px;
  align-items: stretch;
}

.conteudos::-webkit-scrollbar {
  width: 5px;
  background: transparent;
}

/* configurando scroll */
/* .conteudos::-webkit-scrollbar-track {
  /* background: rgba(190, 154, 154); 
} */

.conteudos::-webkit-scrollbar-thumb {
  border-radius: 10px;
  background: rgba(87, 86, 86, 0.637);
  /* -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.5); */
}

/* .conteudos::-webkit-scrollbar-button {
  color: white;
  background: red;
} */

.conteudos::-webkit-scrollbar-arrow {
  color: white;
  background: yellowgreen;
}
</style>




