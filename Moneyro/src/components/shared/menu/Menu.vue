<template>
  <div id="menu" @mouseenter="ativo = true" @mouseleave="ativo = false">
    <mensagem
    :msg="msg"
    v-if="msg.visivel"
    v-on:sair="msg.visivel = false, $session.destroy(), $router.push('/')"
    v-on:fechar="msg.visivel = false"
    ></mensagem>
    <nav id="menu">
      <div id="btnAdd" @click="tiposM = !tiposM"></div>
      <div class="item" v-on:click="$router.push('planilhas')">
         <div class="icones">
          <img src="../../../images/planilha.png" alt="a" />
        </div>
        <div class="titulos">Planilhas</div>
      </div>
      <div class="item" v-on:click="$router.push('relatorios')">
         <div class="icones">
          <img src="../../../images/relatorios.png" alt="a" />
        </div>
        <div class="titulos">Relatórios</div>
      </div>
      <div class="item" v-on:click="$router.push('amigos')">
         <div class="icones">
          <img src="../../../images/amigos.png" alt="a" />
        </div>
        <div class="titulos">Amigos</div>
      </div>
      <div class="item" v-on:click="$router.push('metas')">
         <div class="icones">
          <img src="../../../images/metas.png" alt="a" />
        </div>
        <div class="titulos">Metas</div>
      </div>
      <div class="item" v-on:click="$router.push('pontos')">
         <div class="icones">
          <img src="../../../images/pontos.png" alt="a" />
        </div>
        <div class="titulos">Pontos</div>
      </div>
      <div class="item" v-on:click="$router.push('salaDeAula')">
         <div class="icones">
          <img src="../../../images/aula.png" alt="a" />
        </div>
        <div class="titulos">Sala de Aula</div>
      </div>
      <div class="item" v-on:click="$router.push('compras')">
         <div class="icones">
          <img src="../../../images/compras.png" alt="a" />
        </div>
        <div class="titulos">Compras</div>
      </div>
      <div class="item" v-on:click="$router.push('configurações')">
         <div class="icones">
          <img src="../../../images/configuracao.png" alt="a" />
        </div>
        <div class="titulos">Configuracões</div>
      </div>
      <div class="item" v-on:click="$router.push('configurações')">
         <div class="icones">
          <img src="../../../images/sair.png" alt="a" />
        </div>
        <div class="titulos">Sair</div>
      </div>
    </nav>
    <registro v-on:fechar="verCard = false" v-on:atualizar="$emit('atualizar')" v-if="verCard"></registro>
    <meta-registro v-on:fechar="verMeta = false" v-on:atualizar="$emit('atualizar')" v-if="verMeta"></meta-registro>
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
    mensagem: Mensagem
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
        botoes: []
      }
    };
    
  },
  methods: {
    sair(){
      this.msg.titulo = "Sair da sessão";
      this.msg.mensagem =
        "Você realmente deseja sair?";

      this.msg.botoes = [
        {
          mensagem: "Sair",
          evento: "sair"
        },
        {
          mensagem: "Cancelar",
          evento: "fechar"
        }
      ];
      this.msg.visivel = true;     
    }
  }
};
</script>

<style scoped>
nav {
  height: 100%;
  background-color: rgb(11, 83, 148);
  box-sizing: border-box;
  width: fit-content;
  height: 100%;
  z-index: 5;
  position: fixed;
  box-shadow: 5px 0px 5px #00000040;
}

.item {
  display: flex;
  background: rgba(0, 0, 0, 0.200);
  margin: 5px;
  padding: 4px;
  justify-content: space-between;
  border-radius: 8px;
  color: white;
}

.item:hover {
  background: rgba(0, 0, 0, 0.5);
}

/* tr td:nth-child(2) {
} */

.icones {
  padding: 3px;
  display: flex;
}

.icones img {
  width: 35px;
}

.titulos {
  width: 100%;
}

/* tr td:nth-child(2) {
} */

.titulos:hover,
#opcoesCard td:hover {
  background-color: #0c406f;
}

</style>