<template>
  <div class="pag">
    <Mensagem
      :msg="msg"
      v-if="msg.visivel" 
      v-on:sair="msg.visivel = false, $router.push({ path: `/usuario` })"
      v-on:cancelar="msg.visivel = false"
      v-on:excluir="excluir(sala.id)"/>
    <MenuProfessor v-on:getPostagens="getPostagensById($event)" :salas="salas"/>
    <div class="centro">
      <NovoComunicado :sala="sala" :postagens="postagens" v-if="novoComunicado" v-on:fechar="novoComunicado = false"/> 
      <NovaAtividade v-if="novaAtividade" v-on:fechar="novaAtividade = false"/>
      <Perfil/>
      <div class="corpo">
        <div v-if="sala.id">
          <div class="cima">
            <div class="infoSala">
              <p class="nomeSala"><b>Sala:</b> {{sala.nome}} </p>
              <p><strong>Código da sala:</strong> {{sala.codigo}}</p>
              <div class="remover">
                <img v-on:click="msgExluir()" class="imgRemover" src="../../images/remAmigo.png">
              </div>
            </div>
          </div>
          <span class="postagens" v-if="postagens[0]" v-bind:key="i" v-for="(post, i) in postagens">
            <div>
              <Comunicado v-if="post.tipo == 'comunicado'" :comunicado="post" :professor="$session.get('nome')"/> 
            </div>
            <div>
              <Atividade v-if="post.tipo == 'atividade'" :atividade="post" :professor="$session.get('nome')"/>
            </div>
          </span>
          <span class="aviso" v-else> 
            <p class="texto"> Sala vazia.</p>
            <img class="transparente" src="../../images/salavazia.png">
          </span>
          <div class="adicionar">
            <div class="opcoes" v-bind:class="{aberto: clicou}">
              <span v-on:click="novoComunicado = true" class="opcao" title="Adicionar Comunicado"> <img src="../../images/comunicado.png" alt="a"/></span>
              <span v-on:click="novaAtividade = true" class="opcao" title="Adicionar Atividade"> <img src="../../images/atividade.png" alt="a"/></span>
            </div>  
            <div id="botao" v-on:click="clicou = !clicou" title="Adicionar">➕</div>
          </div>
        </div>
        <div v-else class="centro">
          <p class="texto"> Clique em uma sala no menu!</p>
          <img class="transparente" src="../../images/cliquenasala.png">
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
import Mensagem from "../shared/mensagem/Mensagem.vue";

export default {
  components: {
    Perfil,
    MenuProfessor,
    Comunicado,
    Atividade,
    NovoComunicado,
    NovaAtividade,
    Mensagem
  },
  data() {
    return {
      novoComunicado: false,
      novaAtividade: false,
      clicou: false,
      salas: [],
      sala: {},
      postagens:[],
      msg: {
        visivel: false,
        titulo: "",
        mensagem: "",
        botoes: [],
      },
    }
   },
  methods: {
    getPostagensById(sala)
    {
      this.sala = sala;
      
      this.$http
      .get("https://localhost:5001/api/postagens/"+sala.id)
      .then(response => {
        this.postagens = response.body;
        }, erro =>{
          console.log(erro);
      });
    },
    getPostagensByCodigo(codigo)
    {
      this.$http
      .get("https://localhost:5001/api/postagens/codigo/"+codigo)
      .then(response => {
        this.postagens = response.body;
        console.log(this.postagens);
        }, erro =>{
          console.log(erro);
      });
    },
    excluir(id){
      this.$http
      .delete("https://localhost:5001/api/salas/"+id)
      .then(
        response => {
          this.$router.push({ path: `/salaprofessor` });
          window.location.reload(true);
        }, 
        erro =>{
          console.log(erro);
      });
    },
    msgExluir(){
      this.msg = {
        visivel: true,
        titulo: "Excluir sala",
        mensagem: "Deseja mesmo excluir essa sala de forma definitiva?",
        botoes: [
          {
            mensagem: "Cancelar",
            evento: "cancelar",
          },
          {
            mensagem: "Sim",
            evento: "excluir",
          }
        ],
      }
    }
  },
  created() {
    document.title = "Sala de Aula";
    var codigo = this.$route.params.codigoSala;
    
    this.$http
      .get("https://localhost:5001/api/salas/professor/"+this.$session.get('id'))
      .then(response => {
        this.salas = response.body;

        if (codigo)
        {
          for(var i = 0; i < this.salas.length; i++)
            if(this.salas[i].codigo == codigo)
              this.sala = this.salas[i];
      
          this.getPostagensByCodigo(codigo);
        }
      }, erro =>{
          console.log(erro);
      });

  },
  beforeCreate() {
    
    }
  };

</script>

<style scoped>
.postagens div {
  margin-bottom: 15px;
}

.transparente{
 opacity:0.7
}

.remover {
  display: flex;
  justify-content: flex-end;
}

.imgRemover{
  width:10%;
  background: hsl(208, 86%, 31%);
  padding: 10px;
  border-radius: 5px;
}

.imgRemover:hover{
  background: hsl(208, 86%, 25%);
}

.texto{
  font-size: 1.5em;
}

.aviso{
  text-align: center;
  font-size: 1em;
}

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
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  font-size: 1.5em;
}
</style>
