<template>
  <div class="pag">
    <MenuProfessor :abrirSala="getSala()"/>
    <div class="centro">
      <NovoComunicado v-if="novoComunicado" v-on:fechar="novoComunicado = false"/> 
      <NovaAtividade v-if="novaAtividade" v-on:fechar="novaAtividade = false"/>
      <Perfil />
      <div class="corpo">
        <div class="cima">
          <div class="infoSala">
            <p class="nomeSala"><b>Sala:</b> {{sala.nome}} </p>
            <p><b>Código da sala:</b> {{sala.codigo}}</p>
          </div>
        </div>
        <Comunicado /> 
        <br>
        <Atividade />
        <div class="adicionar">
          <div class="opcoes" v-bind:class="{aberto: clicou}">
            <span v-on:click="novoComunicado = true" class="opcao" title="Adicionar Comunicado"> <img src="../../images/comunicado.png" alt="a"/></span>
            <span v-on:click="novaAtividade = true" class="opcao" title="Adicionar Atividade"> <img src="../../images/atividade.png" alt="a"/></span>
          </div>  
          <div id="botao" v-on:click="clicou = !clicou" title="Adicionar">➕</div>
        </div>
      </div>
    </div>
  </div>
</template>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
import Perfil from "../shared/perfil/Perfil.vue";
import MenuProfessor from "../shared/menu-professor/MenuProfessor.vue";
import Comunicado from "../shared/comunicado/Comunicado.vue";
import Atividade from "../shared/atividade/Atividade.vue";
import NovoComunicado from "../shared/comunicado/NovoComunicado.vue";
import NovaAtividade from "../shared/atividade/NovaAtividade.vue";
export default {
  components: {
    Perfil,
    MenuProfessor,
    Comunicado,
    Atividade,
    NovoComunicado,
    NovaAtividade
  },
  data() {
    return {
      novoComunicado: false,
      novaAtividade: false,
      clicou: false,
      codigoSala: "",
      sala:{
        nome: 'alo',
        codigo: 0
      },
      professor:{
        nome:'josé'
      }
    }
   },
  methods: {
    getSala()
    {
      alert(codigo);
    }
  },
  created() {
    document.title = "Sala de Aula";
    
  },
   beforeCreate() {
    
    }
  };

</script>

<style scoped>
.corpo {
  display: flex;
  flex-direction: column;
}

.aberto {
  padding-bottom: 10px;
  display: flex !important;
}

.adicionar {
  position: fixed;
  bottom: 30px;
  right: 30px;
}

.opcoes {
  flex-direction: column;
  align-items: center;
  display: none;
}

.opcao {
  border-radius: 50px;
  background:hsl(208, 86%, 31%);
  display: flex;
  width: 50px;
  height: 50px;
  margin-bottom: 8px;
  justify-content: center;
  align-items: center;
  margin: 0 auto 8px auto;
}

.opcao:hover {
  background:rgb(8, 70, 153);
}

.opcao img{
  width: 30px;
  height: 30px;
}
#botao:hover {
  background-color:  rgb(228,180,78);
}
#botao {
  display: block;
  bottom: 20px;
  right: 30px;
  z-index: 50;
  font-size: 1.15em;
  background-color:  rgba(241, 174, 30, 0.863);
  cursor: pointer;
  padding: 12px;
  height: 45px;
  width: 45px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 87px;
  -webkit-animation: animatezoom 0.3s;
  animation: animatezoom 0.3s;
}

p {
  margin: 0;
  color:white;
  padding: 3px;
}

.centro{
  padding: 25px 16vw;
}

.cima{
  padding: 0 0px 15px 0;
  width: 80%;
}

.infoSala {
  display: flex;
  font-size: 1.5em;
  justify-content: space-between;
}
</style>
