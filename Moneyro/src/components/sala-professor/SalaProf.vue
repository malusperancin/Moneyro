<template>
<div class="pag">
    <MenuProfessor />
    <Perfil />
    <div v-if="turma">
      <div class="cima">
        <div class="infoSala">
          <p class="nomeSala"><b>Sala:</b> {{sala.nome}} </p>
          <p><b>Código da sala:</b> {{sala.codigo}}</p>
        </div>
        <p class="nomeProf"> <b>Professor:</b> {{professor.nome}}</p>
      </div>
      <Comunicado /> 
      <br><br>
      <Atividade />
    </div>
    </div>
  </div>
</template>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
import Perfil from "../shared/perfil/Perfil.vue";
import MenuProfessor from "../shared/menu-professor/MenuProfessor.vue";

export default {
  components: {
    Perfil,
    MenuProfessor
  },
  data() {
    return {
      }
   },
   
  methods: {

  },
  created() {
    document.title = "Sala de Aula";
    
  },
   beforeCreate() {
    
    }
  };

</script>

<style scoped>

.atividade {
  height: 100%;
  width: 80%;
  align-items: center;
}

.comunicado {
  height: 100%;
  width: 80%;
  align-items: center;
}

.conteudo {
  color: rgb(255, 255, 255);
  background: rgb(46, 48, 46);
  border-radius: 5px;
  height: fit-content;
  min-width: 250px;
}

.titulo {
  padding: 20px;
}

.texto {
  padding: 20px;
  white-space: pre-line;
}

.botao:hover {
  opacity: 0.8;
}

/* .topo-atividade {
  background: rgb(37, 33, 33);
  padding: 10px;
 
  justify-content: space-between;
  border-top-left-radius: inherit;
  border-top-right-radius: inherit;
}

/* .topo-atividade {
  background: rgb(37, 33, 33);
  padding: 10px;
  display: flex;
  justify-content: space-between;
  border-top-left-radius: inherit;
  border-top-right-radius: inherit;
} */ 

   
</style>
