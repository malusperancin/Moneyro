<template>
  <div id="menu">
    <mensagem
      :msg="msg"
      v-if="msg.visivel"
      v-on:sair="(msg.visivel = false), $session.destroy(), $router.go()"
      v-on:fechar="msg.visivel = false"
    ></mensagem>
    <div class="l-navbar" id="navbar" v-bind:class="{expander: ativo}">
      <nav class="nav">
        <div class="nav__brand">
          <ion-icon name="menu-outline" class="nav__toggle" id="nav-toggle" v-on:click="ativo = !ativo, tipos = false"></ion-icon>
          <a v-if="this.$route.path != '/'" class="nav__logo" v-on:click="$router.push('/')">Moneyro</a>
        </div>
        <div class="nav__list">
          <div class="nav__link collapse">
            <img src="../../../images/adicionar.png" alt="a" class="nav__icon" v-on:click="tipos = !tipos, ativo = true" />
            <span class="nav__name">Adicionar</span>
            <ion-icon name="chevron-down-outline" class="collapse__link" v-bind:class="{rotate: tipos}" v-on:click="tipos = !tipos, ativo = true"></ion-icon>
            
            <ul class="collapse__menu" v-bind:class="{showCollapse: tipos}">
              <a href="#" class="collapse__sublink" v-on:click="verCard = true">Registro</a>
              <a href="#" class="collapse__sublink" v-on:click="verMeta = true">Meta</a>
            </ul>
          </div>
          <a title="Planilhas" v-bind:class="{active: this.$route.path == '/planilhas'}" class="nav__link" v-on:click="$router.push('planilhas')">
            <img src="../../../images/planilha.png" alt="a" class="nav__icon" />
            <span class="nav__name">Planilhas</span>
          </a>
          <a title="Relatórios" v-bind:class="{active: this.$route.path == '/relatorios'}" class="nav__link" v-on:click="$router.push('relatorios')">
            <img src="../../../images/relatorios.png" class="nav__icon" />
            <span class="nav__name">Relatórios</span>
          </a>
          <a title="Amigos" v-bind:class="{active: this.$route.path == '/amigos'}" class="nav__link" v-if="!$session.get('MA')" v-on:click="$router.push('amigos')">
            <img src="../../../images/amigos.png" alt="a" class="nav__icon" />
            <span class="nav__name">Amigos</span>
          </a>
          <a title="Metas" v-bind:class="{active: this.$route.path == '/metas'}" class="nav__link" v-on:click="$router.push('metas')">
            <img src="../../../images/metas.png" alt="a" class="nav__icon" />
            <span class="nav__name">Metas</span>
          </a>
          <a title="Loja" v-bind:class="{active: this.$route.path == '/compras'}" class="nav__link" v-on:click="$router.push('compras')">
            <img src="../../../images/compras.png" alt="a" class="nav__icon" />
            <span class="nav__name">Loja</span>
          </a>
          <a title="Pontos" v-bind:class="{active: this.$route.path == '/pontos'}" class="nav__link" v-on:click="$router.push('pontos')">
            <img src="../../../images/pontos.png" alt="a" class="nav__icon" />
            <span class="nav__name">Pontos</span>
          </a>
          <a title="Sala de Aula" v-if="this.$session.get('professor')" v-bind:class="{active: this.$route.path == '/salaprofessor'}" class="nav__link" v-on:click="$router.push('salaprofessor')">
            <img src="../../../images/aula.png" alt="a" class="nav__icon" />
            <span class="nav__name">Sala de Aula</span>
          </a>
            <a title="Sala de Aula"  v-if="!$session.get('MA') && !this.$session.get('professor')"  v-bind:class="{active: this.$route.path == '/salaaluno'}" class="nav__link" v-on:click="$router.push('salaaluno')">
            <img src="../../../images/aula.png" alt="a" class="nav__icon" />
            <span class="nav__name">Sala de Aula</span>
          </a>
          <a title="Atividades" v-bind:class="{active: this.$route.path == '/atividades'}" class="nav__link" v-on:click="$router.push('atividades')">
            <img src="../../../images/atividade.png" alt="a" class="nav__icon" />
            <span class="nav__name">Atividades</span>
          </a>
          <a title="Configurações" v-bind:class="{active: this.$route.path == '/configuracoes'}" class="nav__link" v-on:click="$router.push('configuracoes')">
            <img src="../../../images/configuracao.png" class="nav__icon" />
            <span class="nav__name">Configurações</span>
          </a>
        </div>
        <a title="Sair" class="nav__link" v-on:click="sair()" v-if="this.$route.path != '/'">
          <img src="../../../images/sair.png" alt="a" class="nav__icon" />
          <span class="nav__name">Sair</span>
        </a>
      </nav>
    </div>
    <registro
      v-on:fechar="verCard = false"
      v-on:atualizar="$emit('atualizar')"
      v-if="verCard"
    ></registro>
    <meta-registro
      v-on:fechar="verMeta = false"
      v-on:atualizar="$emit('atualizar')"
      v-if="verMeta"
    ></meta-registro>
  </div>
</template>

<script>
import Card from "../cards/Card.vue";
import Meta from "../cards/Meta.vue";
import Mensagem from "../mensagem/Mensagem.vue";

export default {
  components: {
    registro: Card,
    "meta-registro": Meta,
    mensagem: Mensagem,
  },
  data() {
    return {
      ativo: false,
      tipos: false,
      verCard: false,
      verMeta: false,
      tiposM: false,
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
        titulo: "Sair da sessão",
        mensagem: "Você realmente deseja sair?",
        botoes: [
          {
            mensagem: "Sair",
            evento: "sair",
          },
          {
            mensagem: "Cancelar",
            evento: "fechar",
          }]
      };
    }
  },
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
        z-index: 9999;
    }
    /*===== NAV =====*/
    
    .nav {
      height: 100%;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      overflow: hidden;
      direction: rtl;
    }

    .nav__list {
      overflow-y: scroll;
      overflow-x: hidden;
      flex: 1;
    }

    /* width */
    .nav__list::-webkit-scrollbar {
      width: 2px;
    }

    .nav__list::-webkit-scrollbar-track {
      background: #0000000;
    }

    /* Handle */
    .nav__list::-webkit-scrollbar-thumb {
      background: rgb(150,150,150);
    }

    /* Handle on hover */
    .nav__list::-webkit-scrollbar-thumb:hover {
      background: #555;
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
        padding: .75rem .60rem .75rem .75rem;
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
        width: 100px;
        text-align: left;
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