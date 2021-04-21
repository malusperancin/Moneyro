<template>
  <div id="menu">
    <mensagem
      :msg="msg"
      v-if="msg.visivel"
      v-on:sair="(msg.visivel = false), $session.destroy(), $router.push('/')"
      v-on:fechar="msg.visivel = false"
    ></mensagem>
    <div class="l-navbar" id="navbar" v-bind:class="{expander: ativo}">
      <nav class="nav">
        <div class="nav__brand">
          <img src="../../../images/menu.png" class="nav__toggle" id="nav-toggle" v-on:click="ativo = !ativo"/>
          <a href="#" class="nav__logo">Moneyro</a>
        </div>
        <div class="nav__list">
          <div class="item collapse">
            <img src="../../../images/adicionar.png" alt="a" class="icone" />
            <span class="nav__name">Adicionar</span>
            <ion-icon name="chevron-down-outline" v-bind:class="{rotate: tipos} "class="collapse__link"></ion-icon>
            
            <ul v-bind:class="" class="collapse__menu">
              <a href="#" class="collapse__sublink">Despesa</a>
              <a href="#" class="collapse__sublink">Receita</a>
            </ul>
          </div>
          <a v-bind:class="{active: this.$route.path == '/planilhas'}" class="item" v-on:click="$router.push('planilhas')">
            <img src="../../../images/planilha.png" alt="a" class="icone" />
            <span class="nav__name">Planilhas</span>
          </a>
          <a v-bind:class="{active: this.$route.path == '/relatorios'}" class="item" v-on:click="$router.push('relatorios')">
            <img src="../../../images/relatorios.png" class="icone" />
            <span class="nav__name">Relatorios</span>
          </a>
          <a v-bind:class="{active: this.$route.path == '/amigos'}" class="item" v-on:click="$router.push('amigos')">
            <img src="../../../images/amigos.png" alt="a" class="icone" />
            <span class="nav__name">Amigos</span>
          </a>
          <a v-bind:class="{active: this.$route.path == '/metas'}" class="item" v-on:click="$router.push('metas')">
            <img src="../../../images/metas.png" alt="a" class="icone" />
            <span class="nav__name">Metas</span>
          </a>
          <a v-bind:class="{active: this.$route.path == '/compras'}" class="item" v-on:click="$router.push('compras')">
            <img src="../../../images/compras.png" alt="a" class="icone" />
            <span class="nav__name">Loja</span>
          </a>
          <a v-bind:class="{active: this.$route.path == '/pontos'}" class="item" v-on:click="$router.push('pontos')">
            <img src="../../../images/pontos.png" alt="a" class="icone" />
            <span class="nav__name">Pontos</span>
          </a>
          <a v-bind:class="{active: this.$route.path == '/salaDeAula'}" class="item" v-on:click="$router.push('salaDeAula')">
            <img src="../../../images/aula.png" alt="a" class="icone" />
            <span class="nav__name">Sala de Aula</span>
          </a>
          <a v-bind:class="{active: this.$route.path == '/configuracoes'}" class="item" v-on:click="$router.push('configuracoes')">
            <img src="../../../images/configuracao.png" class="icone" />
            <span class="nav__name">Configurções</span>
          </a>
        </div>
        <a href="#" class="item" v-on:click="sair()">
          <img src="../../../images/sair.png" alt="a" class="icone" />
          <span v-bind:class="" class="nav__name">Sair</span>
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

<script src="https://unpkg.com/ionicons@5.1.2/dist/ionicons.js"></script>
<script>
import Card from "../cards/Card.vue";
import Meta from "../cards/Meta.vue";
import Mensagem from "../mensagem/Mensagem.vue";

//adicionar
const linkCollapse = document.getElementsByClassName('collapse__link')
var i;

for(i=0;i<linkCollapse.length;i++){
  linkCollapse[i].addEventListener('click', function(){
    const collapseMenu = this.nextElementSibling
    collapseMenu.classList.toggle('showCollapse')

    const rotate = collapseMenu.previousElementSibling
    rotate.classList.toggle('rotate')
  })
}

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
    },
  },
};
</script>

<style scoped>
/*===== BASE =====*/
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
  width: 97px;
  height: 100vh;
  background-color: #0c406f;
  color: #fff;
  padding: 1.5rem 1.25rem 2rem;
  transition: 0.5s;
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
  margin-bottom: 0.5rem;
  padding: 0.75em;
}

.nav__toggle {
  font-size: 1.25rem;
  cursor: pointer;
}

.nav__logo {
  color: #fff;
  font-size: 1.2rem;
  font-weight: 600;
}

.item {
  display: grid;
  grid-template-columns: max-content max-content;
  align-items: center;
  column-gap: 0.75rem;
  padding: 0.75rem;
  color: #fff;
  border-radius: 0.5rem;
  margin-bottom: 0.1rem;
  transition: 0.3s;
  cursor: pointer;
}

.item:hover {
  background-color: #0b5394;
}

.icone {
  font-size: 1.25rem;
}

.nav__name {
  display: none;
  font-size: 0.875rem;
}

/*Expander menu*/
.expander {
  width: calc(97px + 9.25rem);
}

/*Active links menu*/
.active {
  background-color: #0b5394;
}

/*===== COLLAPSE =====*/
.collapse {
  grid-template-columns: 20px max-content 1fr;
}

.collapse__link {
  justify-self: flex-end;
  transition: 0.5s;
}

.collapse__menu {
  display: none;
  padding: 0.75rem 2.25rem;
}

.collapse__sublink {
  color: #b6cefc;
  font-size: 0.875rem;
}

.collapse__sublink:hover {
  color: #fff;
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
  width: 25px;
}
</style>