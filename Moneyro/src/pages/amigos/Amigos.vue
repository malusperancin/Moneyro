<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <Topo />
    <Mensagem
      :msg="msg"
      v-if="msg.visivel"
      v-on:fechar="msg.visivel = false"
    ></Mensagem>
    <Add v-if="adicionar" v-on:fechar="adicionar= false" v-on:atualizar="getAmigos()"></Add>
    <Compartilhado :id="idAmigo" v-on:fechar="compartilhados = false" v-if="compartilhados"></Compartilhado>
    <div class="centro">
      <div id="busca">
        <input class="filtro" placeholder="Pesquisar" type="search" v-model="filtro" />
        <img
          title="Adicionar um amigo"
          id="imgAdd"
          class="icone"
          src="../../images/adicAmigo.png"
          v-on:click="adicionar = true"
        />
      </div>
      <div id="lista-alunos"  style="color: white">
        <div v-if="!filtraNome[0]">
          <h1 style="color: white">Você não tem nenhum amigo com esse apelido :(</h1>
        </div>
        <div v-if="!amigos">
          <h1 style="color: white">Hummn que pena você ainda não fez nenhum amigo ;-; <br> Clique no porquinho e procure alguém lá!</h1>
        </div>
        <div v-else id="lista-alunos-item" v-for="(amigo, i) of filtraNome" :key="amigo.apelido">
          <Painel :nome="amigo.apelido" :foto="amigo.foto" v-on:deletar="removerAmigo(i)" :id="amigo.idUsuario" v-on:verComp="idAmigo = $event, compartilhados = true"></Painel>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Painel from "./components/Amigo.vue";
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/perfil/Perfil.vue";
import Topo from "../shared/voltar-topo/Voltar-Topo.vue";
import Mensagem from "../shared/mensagem/Mensagem.vue";
import Add from "./components/Adicionar-Amigo.vue";
import Compartilhado from "./components/Compartilhados.vue";

export default {
  components: {
    Menu,
    Painel,
    Perfil,
    Topo,
    Mensagem,
    Add,
    Compartilhado
  },
  data() {
    return {
      filtro: "",
      amigos: [],
      mensagem: false,
      adicionar: false,
      dupla:[],
       msg: {
        visivel: false,
        titulo: "",
        mensagem: "",
        botoes: []
      },
      idAmigo: "",
      compartilhados: false
    };
  },
  computed: {
    filtraNome() {
      if (this.filtro) {
        let exp = new RegExp(this.filtro.trim(), "i");
        return this.amigos.filter(amigo => exp.test(amigo.apelido));
      } else {
        return this.amigos;
      }
    }
  },
  methods:{
    removerAmigo(idAmigo){
        var amigo = this.amigos[idAmigo];
        
        var index = this.amigos.indexOf(amigo);
        this.amigos.splice(index, 1);
         
        this.$http
            .delete("https://localhost:5001/api/amigos/" + amigo.id)
            .then(dados => {
                this.getAmigos();
                this.msg = {
                  titulo: "Sucesso",
                  mensagem: "Seu amigo foi removido com sucesso!",
                  botoes: [{
                    mensagem: "Ok",
                    evento: "fechar"
                  }]. 
                  visivel = true
                };
            })
            .catch(erro => console.log("Erro ao deletar"));
    },
    getAmigo(id, idTabela){
      this.$http
        .get("https://localhost:5001/api/usuarios/" + id)
        .then(dados => {
          this.amigos.push({
            id: idTabela, 
            idUsuario: dados.body.id,
            apelido: dados.body.apelido,
            foto: dados.body.foto,
          });
        }, erro => {
          alert("algo deu errado1");
        });
    },
    getAmigos(){
      this.amigos = [];

      this.$http
      .get("https://localhost:5001/api/amigos/" + this.$session.get("id"))
      .then(dados => {
        for(var i=0; i< dados.body.length; i++)
            if(dados.body[i].idAmigoA == this.$session.get("id"))
              this.getAmigo(dados.body[i].idAmigoB, dados.body[i].id);
            else
              this.getAmigo(dados.body[i].idAmigoA, dados.body[i].id);     
      }, erro => {
      });
    }
  },
  beforeCreate() {
    if (!this.$session.exists()) {
      this.$router.push('/')
    }
  },
  created(){
    document.title = "Amigos";
    this.getAmigos();
  }
};
</script>

<style scoped>
:placeholder{
  color: white;
}

.centro {
  margin-left: 7%;
}

#lista-alunos {
  margin-top: 20px;
  list-style: none;
  width: 100%;
  display: flex;
  grid-gap: 10px;
  flex-direction: row;
  flex-wrap: wrap;
}

#lista-alunos #lista-alunos-item {

}

#busca {
  display: flex;
  display: inline-flex;
  width: 100%;
  margin-bottom: 15px;
  box-sizing: border-box;
}

.filtro {
 border-radius: 5px;
  border: none;
  padding: 7px 14px;
  box-sizing: border-box;
  font-size: 1.2em;
  width: 80%;
  color: rgb(255, 255, 255);
  background: rgba(255, 255, 255, 0.078);
}

.filtro:focus {
  border: 1px solid rgba(5, 0, 0, 0.233);
}

#imgAdd {
  width: 60px;
  margin: auto;
  z-index: 99999999;
}

.icone {
  cursor: pointer;
  padding: 10px;
  color: white;
  min-width: 50px;
  text-align: center;
  background-color: #ecb318;
  border-radius: 87px;
  box-sizing: border-box;
}

.icone:hover {
  background-color: #ecb318bb;
}

::placeholder { /* Chrome, Firefox, Opera, Safari 10.1+ */
  color: red;
  opacity: 1; /* Firefox */
}

::-webkit-input-placeholder {
  color: rgba(0, 0, 0, 0.534);
  padding-left: 1%;
}
</style>