<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <Topo />
    <Mensagem
      v-if="mensagem"
      v-on:ok="mensagem = false"
      mensagem="Receita registrada com sucesso!"
      titulo="Toma o titulo"
      sair="oi"
    ></Mensagem>
    <Add v-if="adicionar" v-on:fechar="adicionar= false"></Add>
    <div class="centro">
      <div id="busca">
        <input class="filtro" type="search" placeholder="Pesquisar" v-model="filtro" />
        <img
          title="Adicionar um amigo"
          id="imgAdd"
          class="icone"
          src="../../images/adicAmigo.png"
          v-on:click="adicionar = true"
        />
      </div>
      <div id="lista-alunos">
        <div id="lista-alunos-item" v-for="amigo of filtraNome" :key="amigo.apelido">
          <Painel :nome="amigo.apelido" :foto="amigo.foto" v-on:deletar="removerAmigo(amigo.id)"></Painel>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Painel from "../shared/amigo/Amigo.vue";
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/perfil/Perfil.vue";
import Topo from "../shared/voltar-topo/Voltar-Topo.vue";
import Mensagem from "../shared/mensagem/Mensagem.vue";
import Add from "../shared/adicionar-amigo/Adicionar-Amigo.vue";

export default {
  components: {
    Menu,
    Painel,
    Perfil,
    Topo,
    Mensagem,
    Add
  },
  data() {
    return {
      filtro: "",
      amigos: [],
      mensagem: false,
      adicionar: false,
      dupla:[]
    };
  },
  computed: {
    filtraNome() {
      if (this.filtro) {
        let exp = new RegExp(this.filtro.trim(), "i");
        return this.amigos.filter(amigo => exp.test(amigo.nome));
      } else {
        return this.amigos;
      }
    }
  },
  methods:{
    removerAmigo(idAmigo)
    {
      this.$http
    .get("https://localhost:5001/api/amigos/" + this.$session.get("id"))
    .then(dados => {
        for(var i=0; i< dados.body.length; i++) {
          if(dados.body[i].idAmigoA == this.$session.get("id") && idAmigo == dados.body[i].idAmigoB)
              {
                this.dupla[0] = parseInt(this.$session.get("id"));
                this.dupla[1] = parseInt(idAmigo);
              }
          if(dados.body[i].idAmigoB == this.$session.get("id") && idAmigo == dados.body[i].idAmigoA)
              {
                  this.dupla[0] = parseInt(idAmigo);
                  this.dupla[1] = parseInt(this.$session.get("id"));
              } 
           }
        alert(this.dupla[0] + " e " + this.dupla[1]);
            this.$http
            .post("https://localhost:5001/api/amigos/amg", { Id: 0,
                                                            IdAmigoA: this.dupla[0],
                                                            IdAmigoB: this.dupla[1],
                                                            Aceitou: 0})
            .then(dados => {
                var id = dados.body[0].id;
                this.$http
                .delete("https://localhost:5001/api/amigos/" + id)
                .then(dados => {
                  alert("deu certo");
                },erro => {
                alert("Erro ao deletar");
                });
        }, erro => {
            alert("Erro ao getar");
        });
    }, erro => {
      alert("algo deu errado");
    });
    },
    getAmigo(id)
    {
      this.$http
        .get("https://localhost:5001/api/usuarios/" + id)
        .then(dados => {
          this.amigos.push({
            id: dados.body.id, 
            apelido: dados.body.apelido,
            foto: dados.body.foto,
            });
        }, erro => {
          alert("algo deu errado");
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

    this.$http
    .get("https://localhost:5001/api/amigos/" + this.$session.get("id"))
    .then(dados => {
      for(var i=0; i< dados.body.length; i++)
          if(dados.body[i].idAmigoA == this.$session.get("id"))
              this.getAmigo(dados.body[i].idAmigoB);
          else
              this.getAmigo(dados.body[i].idAmigoA);          
    }, erro => {
      alert("algo deu errado");
    });
  }
};
</script>

<style scoped>
.centro {
  margin-left: 7%;
}

#lista-alunos {
  margin-top: 20px;
  list-style: none;
  width: 100%;
}

#lista-alunos #lista-alunos-item {
  display: inline-block;
  margin: 0.5%;
}

#busca {
  display: -ms-flexbox;
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
  color: rgba(255, 255, 255, 0.7);
  background: rgba(255, 255, 255, 0.078);
}

.filtro:focus {
  border: 1px solid rgba(5, 0, 0, 0.233);
}

#imgAdd {
  width: 60px;
  margin: auto;
}

.icone {
  cursor: pointer;
  padding: 10px;
  color: white;
  min-width: 50px;
  text-align: center;
  background-color: rgba(36, 107, 170, 0.719);
  border-radius: 87px;
  box-sizing: border-box;
}

.icone:hover {
  background-color: rgb(26, 81, 129);
}

::-webkit-input-placeholder {
  color: rgb(47, 49, 51);
  padding-left: 1%;
}
</style>