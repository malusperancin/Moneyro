<template>
  <div class="pag">
    <Mensagem
      :msg="msg"
      v-if="msg.visivel" 
      v-on:sair="msg.visivel = false, $router.push({ path: `/usuario` })"
      v-on:cancelar="msg.visivel = false"
      v-on:excluir="excluirSala(sala.id)"
      v-on:excluirPostagem="excluirPostagem(), msg.visivel = false"/>
    <MenuProfessor v-on:getPostagens="getPostagensByCodigo($event)" :sala="sala"/>
    <TabelaAlunos :atividade="ativ.id" v-if="verTabela" v-on:fechar="verTabela = false"/>
    <div class="centro">
      <NovoComunicado :sala="sala" :postagens="postagens" v-if="novoComunicado" v-on:fechar="fecharModal($event)"/> 
      <NovaAtividade :sala="sala" :postagens="postagens" v-if="novaAtividade" v-on:fechar="fecharModal($event)"/>
      <Perfil/>
      <div class="corpo">
        <div class="sala" v-if="sala.id">
          <div class="cima">
            <div class="infoSala">
              <p class="nomeSala"><b>Sala:</b> {{sala.nome}} </p>
              <p><strong>Código da sala:</strong> {{sala.codigo}}</p>
            </div>
            <div class="remover">
              <img alt="" v-on:click="msgExluir()" class="imgRemover" src="../../images/remAmigo.png">
            </div>
          </div>
          <div v-if="postagens[0] != null">
            <div class="postagens" v-bind:key="i" v-for="(post, i) in postagens">
              <Comunicado v-on:excluir="msg = $event, qualExcluir = i" v-if="post.tipo == 'comunicado'" :comunicado="post" :professor="prof"/> 
              <Atividade v-on:excluir="msg = $event, qualExcluir = i" v-if="post.tipo == 'atividade'" v-on:tabela="verTabela = true, ativ = post" :atividade="post" :professor="prof"/>
            </div>
          </div>
          <div class="sala_vazia" v-else> 
            <p class="texto"> Sala vazia</p>
            <img alt="" class="transparente" src="../../images/salavazia.png">
          </div>
          <div class="adicionar">
            <div class="opcoes" v-bind:class="{aberto: clicou}">
              <span v-on:click="novoComunicado = true" class="opcao" title="Adicionar Comunicado"> <ion-icon name="chatbubble" v-pre></ion-icon></span>
              <span v-on:click="novaAtividade = true" class="opcao" title="Adicionar Atividade"> <ion-icon name="checkmark-circle" v-pre></ion-icon></span>
            </div>  
            <div id="botao" v-on:click="clicou = !clicou" title="Adicionar"><ion-icon name="add" v-pre></ion-icon></div>
          </div>
        </div>
        <div v-else class="nao_sala" >
          <p class="texto"> Clique em uma sala no menu!</p>
          <img alt="" class="transparente" src="../../images/cliquenasala.png">
        </div>
      </div>
    </div>
  </div>
</template>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
import Perfil from "../shared/perfil/Perfil.vue";
import MenuProfessor from "./components/menuProfessor/MenuProfessor.vue";
import Comunicado from "../shared/comunicado/Comunicado.vue";
import Atividade from "../shared/atividade/Atividade.vue";
import NovoComunicado from "../shared/comunicado/NovoComunicado.vue";
import NovaAtividade from "../shared/atividade/NovaAtividade.vue";
import TabelaAlunos from "./components/TabelaAlunos.vue";
import Mensagem from "../shared/mensagem/Mensagem.vue";

export default {
  components: {
    Perfil,
    MenuProfessor,
    Comunicado,
    Atividade,
    NovoComunicado,
    NovaAtividade,
    TabelaAlunos,
    Mensagem
  },
  data() {
    return {
      novoComunicado: false,
      novaAtividade: false,
      verTabela: false,
      clicou: false,
      ativ:[],
      qualExcluir: -1,
      sala: {},
      msg: {
        visivel: false,
        titulo: "",
        mensagem: "",
        botoes: [],
      },
      prof:{
        id: 0,
        nome: this.$session.get('nome'), 
        foto: this.$session.get('foto')
      },
      postagens:[]
    }
   },
  methods: {
    fecharModal(evento){
      this.novoComunicado = false;
      this.novaAtividade = false;
      
      if(evento)
        this.postagens.unshift(evento);
    },
    getPostagensByCodigo(sala){
      this.sala = sala;
      this.prof.id = this.sala.idProfessor;

      this.$http
      .get("https://localhost:5001/api/postagens/codigo/"+sala.codigo)
      .then(response => {
        this.postagens = response.body;
        }, erro =>{
          console.log(erro);
      });
    },
    excluirSala(id){
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
    msgExluir(tipo){
      this.msg = {
        visivel: true,
        titulo: "Excluir",
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
    },
    excluirPostagem() {
       this.$http
            .delete("https://localhost:5001/api/postagens/"+this.postagens[this.qualExcluir].id)
            .then(
                response => {
                    this.postagens.splice(this.qualExcluir, 1);
                }, 
                erro =>{
                    console.log(erro);
            });
    },
  },
  created() {
    document.title = "Sala de Aula";

    this.getPostagensByCodigo(this.sala);
  },
  beforeCreate() {
    if (!this.$session.exists() || this.$session.get('MA') || !this.$session.get('professor'))
      this.$router.push('/')
    }
};

</script>

<style scoped>
.sala {
  display: flex;
  flex-direction: column;
}

.sala_vazia {
  display: flex;
  flex-direction: column-reverse;
  color: rgba(255, 255, 255, 0.604);
  justify-content: center;
  align-items: center;
  padding-top: 100px;
}

.nao_sala {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  padding: 100px 50px;
}

.postagens div {
  margin-bottom: 15px;
}

.transparente{
 opacity:0.7
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
  padding-bottom: 3px;
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
  justify-content: center;
  align-items: center;
  margin: 0 auto 8px auto;
  color: white;
  font-size: 1.5em;
  transition: all 0.2s !important;
}

.opcao:hover {
  background:rgb(8, 70, 153);
  cursor: pointer;
  width: 55px;
  height: 55px;
}

#botao:hover {
  background-color:  rgb(228,180,78);
}

#botao {
  display: block;
  bottom: 20px;
  right: 30px;
  z-index: 50;
  font-size: 3em;
  color: white;
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
  padding: 25px 24vw;
}

.cima{
  padding: 0 0px 15px 0;
  display: grid;
  grid-template-columns: 1fr 1fr;
}

.infoSala {
  display: grid;
  grid-template-rows: 1fr 1fr;
  font-size: 1.5em;
}

.remover {
  display: flex;
  justify-content: flex-end;
}

.imgRemover{
  width: 35px;
  height: 35px;
  background: hsl(208, 86%, 31%);
  padding: 10px;
  border-radius: 5px;
}

.imgRemover:hover{
  background: hsl(208, 86%, 25%);
}

</style>
