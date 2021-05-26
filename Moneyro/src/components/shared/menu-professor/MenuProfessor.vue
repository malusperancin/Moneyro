<template>
  <div id="menu">
    <Mensagem
      :msg="msg"
      v-if="msg.visivel" 
      v-on:sair="msg.visivel = false, $router.push('usuario')"
      v-on:cancelar="msg.visivel = false"/>
    <div class="l-navbar" id="navbar" v-bind:class="{expander: ativo}">
      <nav class="nav">
        <div>
          <div class="nav__brand">
            <ion-icon name="menu-outline" class="nav__toggle" id="nav-toggle" v-on:click="ativo = !ativo, tipos = false"></ion-icon>
            <a class="nav__logo">Turmas</a>
          </div>

          <div class="nav__list" v-for="(sala, i) in salas">
            <a v-for="" title="sala" v-bind:class="{active: $route.path == '/salaprofessor/'+sala.codigo}" 
            class="nav__link" v-on:click="$router.push('professor/'+sala.codigo), $emit('abrirSala')">
              <img src="../../../images/aula.png" alt="a" class="nav__icon" />
              <span class="nav__name">{{sala.nome}}</span>
            </a>
          </div>

        </div>
        <a title="Sair" class="nav__link" v-on:click="sair()">
          <img src="../../../images/sairapp.png" alt="a" class="nav__icon" />
          <span v-bind:class="" class="nav__name">Sair da Sala de Aula</span>
        </a>
      </nav>
    </div>
  </div>
</template>

<script>
import Mensagem from "../mensagem/Mensagem.vue";

export default {
  props: ["sa"],
  components: {
      Mensagem,
  },
  data() {
    return {
      salas: [],
      ativo: false,
      tipos: false,
      msg: {
        visivel: false,
        titulo: "",
        mensagem: "",
        botoes: [],
      },
    };
  },
  methods: {
    sair() {
      this.msg = {
        visivel: true,
        titulo: "Sair da sala de aula",
        mensagem: "Você realmente deseja sair da sala de aula?",
        botoes: [
          {
            mensagem: "Sair da Sala",
            evento: "sair",
          },
          {
            mensagem: "Cancelar",
            evento: "cancelar",
          }]
      };
    },
    salaDeAula()
    {
    }
  },
  created() {
    this.$http
      .get("https://localhost:5001/api/salas/professor/"+this.$session.get('id'))
      .then(response => {
        this.salas = response.body;
        }, erro =>{
          alert("deu ruim");
          console.log(erro);
      });
  }
};
</script>

<style scoped>
*,
     ::before,
     ::after {
        box-sizing: border-box;
    }
    
    h1 {
        margin: 0;
    }
    
    ul {
        margin: 0;
        padding: 0;
        list-style: none;
    }
    
    a {
        text-decoration: none;
    }
    /*===== l NAV =====*/
    
    .l-navbar {
        position: fixed;
        top: 0;
        left: 0;
        width: 96px;
        height: 100vh;
        background-color: hsl(208, 80%, 24%);
        color: hsl(0, 0%, 100%);
        padding: 0.8rem 1.5rem 2rem;
        transition: .5s;
        z-index: 100;
    }
    /*===== NAV =====*/
    
    .nav {
        height: 100%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        overflow: hidden;
    }
    
    .nav__brand {
        display: grid;
        grid-template-columns: max-content max-content;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1rem;
    }
    
    .nav__toggle {
        font-size: 1.75rem;
        padding: .75rem;
        cursor: pointer;
    }
    
    .nav__logo {
      font-size: 1.75em;
        color: hsl(0, 0%, 100%);
        font-weight: 600;
    }
    
    .nav__link {
        display: grid;
        grid-template-columns: max-content max-content;
        align-items: center;
        column-gap: 1rem;
        padding: .75rem;
        color: hsl(0, 0%, 100%);
        border-radius: .5rem;
        margin-bottom: 0.25rem;
        transition: .3s;
        cursor: pointer;
    }
    
    .nav__link:hover {
        background-color: hsl(208, 86%, 31%);
    }
    
    .nav__icon {
        font-size: 1.25rem;
    }
    
    .nav__name {
        font-size: 1rem;
    }
    /*Expander menu*/
    
    .expander {
        width: calc(97px + 9.25rem);
    }
    /*Add padding body*/
    
    .body-pd {
        padding: 2rem 0 0 16rem;
    }
    /*Active links menu*/
    
    .active {
        background-color: hsl(208, 76%, 36%);
    }
    /*===== COLLAPSE =====*/
    
    .collapse {
        grid-template-columns: 20px max-content 1fr;
    }
    
    .collapse__link {
        justify-self: flex-end;
        transition: .5s;
    }
    
    .collapse__menu {
        display: none;
        padding: .75rem 2.25rem;
    }
    
    .collapse__sublink {
        color: hsl(0, 0%, 100%);
        font-size: 1rem;
    }
    
    .collapse__sublink:hover {
        color: hsl(237, 36%, 70%);
    }

    ion-icon {
      visibility: visible; 
    }
    /*Show collapse*/
    
    .showCollapse {
        display: block;
    }
    /*Rotate icon*/
    
    .rotate {
        transform: rotate(180deg);
    }

    img {
      width: 1.25em;
    }
</style>