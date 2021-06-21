<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <Mensagem
      :msg="msg"
      v-if="msg.visivel" 
      v-on:ok="msg.visivel = false"
    <div class="centro">
      <div v-if="sala.id">
        <div class="cima">
          <div class="infoSala">
            <p class="nomeSala"><b>Sala:</b> {{sala.nome}} </p>
            <p><b>Código da sala:</b> {{sala.codigo}}</p>
          </div>
          <p class="nomeProf"> <b>Professor:</b> {{sala.professor}}</p>
        </div>
        <div class="lista" v-if="postagens[0] != null">
          <div v-for="(post, i) in postagens" v-bind:key="i">
            <Comunicado v-if="post.tipo == 'comunicado'" :comunicado="post" :professor="prof"/> 
            <div v-on:click="redirecionar(post)">
              <Atividade v-if="post.tipo == 'atividade'" :atividade="post" :professor="prof"/>
            </div>
          </div>
        </div>
        <div class="sala_vazia" v-else> 
            <p class="texto"> Sala vazia</p>
            <img alt="" class="transparente" src="../../images/salavazia.png">
        </div>
      </div>
      <div v-else class="inicio">
        <div class="quadrado">
          <p class="p-else">Ingresse em uma sala!</p>
          <img src="../../images/turma.png">
          <div class="cod-sala">
            <input
              type="text"
              id="email"
              placeholder="Código da sala"
              v-model="sala.codigo"
              maxlength=""
              required
            >
            <button class="botao-entrar" v-on:click="entrarSala(sala.codigo)">Entrar</button>
          </div>
        </div>
        <div class="quadrado">
          <p class="p-else">Se torne professor!</p>
          <img src="../../images/tornarprof.png">
          <button class="botao" v-on:click="$router.push('compras')">Tornar-se</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
import Perfil from "../shared/perfil/Perfil.vue";
import Menu from "../shared/menu/Menu.vue";
import Comunicado from "../shared/comunicado/Comunicado.vue";
import Atividade from "../shared/atividade/Atividade.vue";
import Mensagem from "../shared/mensagem/Mensagem.vue";

export default {
  components: {
    Perfil,
    Menu,
    Comunicado,
    Atividade,
    Mensagem
  },
  data(){
    return {
      sala: {},
      postagens: [],
      msg: {
        visivel: false,
        titulo: "",
        mensagem: "",
        botoes: [],
      },
      prof:{
        nome:'',
        foto:''
      },
      session: "",
   };
  },
  methods: {
    redirecionar(atividade)
    {
      if(atividade.idAtividade != 4)
        this.$router.push({ path: 'quiz', query: { codigo: atividade.idAtividade} });
      else
        this.$router.push('/jogo');
    },
    entrarSala(cod) {
      this.$http
          .put("https://localhost:5001/api/usuarios/sala/" + cod, this.$session.get("usuario"))
          .then(
            dados => {
              this.sala = dados.body;
              this.getPostagens(this.sala.id);
              this.$session.set("idSala", this.sala.id);
              this.msg = {
                visivel: true,
                titulo: "Sucesso!",
                mensagem: "Você ingressou na sala: "+this.sala.nome,
                botoes: [
                  {
                    mensagem: "Legal",
                    evento: "ok",
                  }]
              }
          },
            erro => {
              this.msg = {
                visivel: true,
                titulo: "Erro",
                mensagem: erro,
                botoes: [
                  {
                    mensagem: "Voltar",
                    evento: "ok",
                  }]
            }
          }
        );
    },
    getPostagens(idSala) {
      this.$http
        .get("https://localhost:5001/api/postagens/"+idSala) 
        .then(
          dados => {
            this.postagens = dados.body.reverse();
          }
        ); 
    }
  },
  beforeCreate() {
    if (!this.$session.exists()) {
      this.$router.push('/')
    }
    
    if(this.$session.get("idSala") > 1) {
      this.$http
        .get("https://localhost:5001/api/salas/id/"+this.$session.get("idSala")) 
        .then(
          dados => {
            this.sala = dados.body;
            this.prof = {
              id: this.sala.idProfessor,
              foto: "",
              nome:  this.sala.professor
            };

            this.$http
            .get("https://localhost:5001/api/usuarios/" + this.prof.id)
            .then(  
              response => {
                this.prof.foto = response.body.foto;
              }, 
              response => {
                console.log("Erro ao pergar foto prof");
              });

            this.getPostagens(this.sala.id);
          }
        );  
    }
  },
  created() {
    document.title = "Sala de Aula";
  },
};
</script>

<style scoped>
.sala_vazia {
  display: flex;
  flex-direction: column-reverse;
  color: rgba(255, 255, 255, 0.604);
  justify-content: center;
  align-items: center;
  padding-top: 100px;
}

.centro{
  padding: 25px 15vw;
}

.inicio {
  display: flex;
  flex-direction:inherit;
  justify-content: center;
  align-items:center;
}

.quadrado{
  font-size: 3em;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  padding: 20px;
  background: #f5f5f517;
  border-radius: 20px;
  color: whitesmoke;
  margin-right:5%;
}

/*  */

img {
  width: 270px;
  border-radius: 20px;
  margin: auto;
}

input{
  border-radius: 10px;
  font-size:0.4em;
  text-align: center;
  border:transparent;
}

p {
  margin: 0;
  color:white;
  padding: 3px;
}

.p-else{
  font-size:0.6em;
  text-align: center;
  margin-bottom:3%;
}

.cod-sala{
  display: flex;
  flex-direction: row;
  height:15%;
  margin-top: 5%;
}

.cod-sala input{
  width:80%;
  margin-left: 5%;
}

button{
  font-size: 0.5em;
  border: none;
  color: white;
  background-color: rgba(241, 174, 30, 0.863);
  border-radius: 13px;
  cursor: pointer;
  font-weight: 1000;
  text-align: center;
  width:60%;
}

.botao {
  padding: 5px;
  margin: 5% auto 0; 
}

.cod-sala button{
  margin-left: 3%; 
}

.cima{
  width:80%;
  font-size:1.5em;
  margin-bottom:1%;
}

.infoSala {
  display: flex;
  justify-content: space-between;
}

.texto {
  margin-left: 2.3%;
  margin-bottom: 1%;
  margin-top:1%;
  color: darkgray;
}

.lista {
  display: flex;
  grid-gap: 15px;
  flex-direction: column;
  width: 80%;
}

</style>
