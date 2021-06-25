<template>
  <div class="modal">
    <form v-on:submit.prevent class="modal-conteudo animate width-25">
      <div class="cima">
        <div class="tipos">
          <label>{{ id ? "Edição" : "Metah"}}</label>
        </div>
        <span class="fechar" v-on:click="$emit('fechar')">&times;</span>
      </div>
      <div class="corpo">
        <input placeholder="Nome" type="text" id="nome" maxlength="20" class="campos" v-model="meta.nome" />

        <div class="quantia">
          <div class="dinheiro">
            <span class="escrito">Objetivo</span>
              <div class="campo">
                <big>R$</big>
                <input
                  placeholder="0.00"
                  type="number"
                  min="0.00"
                  max="1000000.00"
                  class="campos"
                  v-model="meta.objetivo"
                />
              </div>
          </div>
          <div class="dinheiro">
            <span class="escrito">{{ id ? "Atual" : "Inicial"}}</span>
            <div class="campo">
              <big>R$</big>
              <input
                placeholder="0.00"
                type="number"
                min="1.00"
                :max="meta.objetivo"
                class="campos"
                v-model="meta.atual"
              />
            </div>
          </div>
        </div>

        <!-- </div> -->
        <span class="escrito">Data limite</span>
        <input type="date" id="data" class="campos" v-model="meta.dataLimite" />
        <div class="dropdown">
          <div v-on:click="abrirCompartilhar()" id="btnDrop" class="campos">Compartilhar com... ▾</div>
          <div id="listaAmigos">
            <input type="search" placeholder="Pesquisar" v-model="filtroNome" />
            <div v-for="(amigo, i) of filtraNome" :key="i" class="amigos">
              <div class="pretty p-default p-curve p-fill">
                <input v-on:click="incluirAmg(amigo.id)" type="checkbox" :id="'amigo'+amigo.id" class="amigo" :name="amigo.nome" :value="amigo.id"/>
                <div class="state p-primary">
                  <label class="nomeAmigo">{{amigo.apelido}}</label>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="baixo">
        <button class="excluir" v-on:click="excluir" v-if="id">Excluir</button>
        <button class="salvar" v-if="id" v-on:click="atualizar">Salvar</button>
        <button class="salvar" v-else v-on:click="adicionar">Salvar</button>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  props: ["id"],
  data() {
    return {
      expanded: false,
      qtdAmigos: 0,
      filtroNome: "",
      amigos: [],
      meta: {
        id:0,
        idUsuario: this.$session.get("id"),
        nome: "",
        objetivo: null,
        atual: null,
        dataLimite: Date,
        compartilhamentos: []
      },
    };
  },
  methods: {
    abrirCompartilhar(){
      if(this.meta.idUsuario == this.$session.get("id"))
      this.expanded = !this.expanded
      else{
       this.$emit('msgNaoAbrir');
      }
    },
    adicionar() {
        var ret = "";

        if(this.meta.compartilhamentos[0])
        {
          this.enviarNotificacoes(this.meta.compartilhamentos);

          this.meta.compartilhamentos.map(c => {
            ret += " "+c;
          })

          ret+=" ";
        }
        else
          ret = null;

        this.meta.compartilhamentos = ret;
          
        this.meta.objetivo= parseFloat(this.meta.objetivo);
        this.meta.atual= parseFloat(this.meta.atual);
        
        this.$http
        .post("https://localhost:5001/api/metas", this.meta)
        .then(dados=> {
          if(this.$router.currentRoute.path != "/metas")
            this.$router.push("metas");

          this.$emit('atualizar');
          this.$emit('fechar');  
          this.$emit('mostrarMsg');
        }, erro => {
          alert("Erro ao adicionar meta");
        });
    },
    atualizar(){
      var ret = "";

      if(this.meta.compartilhamentos[0])
      {
        this.meta.compartilhamentos.map(c => {
          ret += " "+c;
        })

        ret+=" ";
      }
      else
        ret = null;

      this.meta.compartilhamentos = ret;

      this.meta.objetivo= parseFloat(this.meta.objetivo);
      this.meta.atual= parseFloat(this.meta.atual);
      
      this.$http
      .put("https://localhost:5001/api/metas/" + this.meta.id, this.meta)
      .then(dados=> {
        this.$emit('atualizar');
        this.$emit('mostrarMsg');
        this.$emit('fechar');
      }, erro => {
        alert("Alterar deu errado");
      });
    },
    excluir() {
      this.$http
        .delete("https://localhost:5001/api/metas/" + this.meta.id)
        .then(dados=> {
          this.$emit('deletou');
          this.$emit('atualizar');
          this.$emit('fechar');
        }, erro => {
          alert("Erro ao deletar meta");
        });
    },
    checkarAmigos: function() {
      for (var i = 0; i < this.meta.compartilhamentos.length; i++)
        for (var a = 0; a < this.amigos.length; a++) 
          if (this.meta.compartilhamentos[i] == this.amigos[a].id) 
            document.getElementById("amigo" + this.amigos[a].id).checked = true;
    }, 
    incluirAmg: function(id) {
      var checkObj = document.getElementById("amigo"+id);
      
      if (this.meta.compartilhamentos.length >= 5 && checkObj.checked)
      {
        checkObj.checked = false;
        alert("máximo 5 pessoas!");
        return;
      }

      if (checkObj.checked)
        this.meta.compartilhamentos.push(id);
      else
        this.meta.compartilhamentos = this.meta.compartilhamentos.filter(a => a!=id);
    },
    getAmigo(id){
      this.$http
        .get("https://localhost:5001/api/usuarios/" + id)
        .then(dados => {
          this.amigos.push({
            id: dados.body.id, 
            apelido: dados.body.apelido});
        }, erro => {
          console.log("Erro ao recuperar amigo: " + erro.body);
        });
    },
    enviarNotificacoes(amigos){
      for(var i = 0; i < amigos.length; i++)
        this.$http
        .post("https://localhost:5001/api/notificacoes", {
          idOrigem: this.$session.get("id"),
          idDestino: amigos[i],
          mensagem: this.$session.get("nome") + " adicionou voce à meta: " + this.meta.nome + ". ",
          visualizada: 0,
          data: new Date(),
        })
        .then(dados => {
            alert("enviou no registro");
        }).catch( erro => {
          alert("Erro ao enviar as notificações: " + erro.bodyText);
        });
    }
  },
  computed: {
    filtraNome() {
      if (this.filtroNome) {
        let exp = new RegExp(this.filtroNome.trim(), "i");
        return this.amigos.filter(amigo => exp.test(amigo.apelido));
      } else {
        return this.amigos;
      }
    }
  },
  created() {
    if (this.id) {
      this.$http
      .get("https://localhost:5001/api/metas/" + this.id)
      .then(dados => {
        this.meta = dados.body;
        this.meta.dataLimite = this.meta.dataLimite.substring(0, 10);
        
        if(this.meta.compartilhamentos)
          this.meta.compartilhamentos = this.meta.compartilhamentos.trim().split(" ").map(Number);  
        else
          this.meta.compartilhamentos = [];
      }, erro => {
        alert("algo deu errado metakk");
      });
    }

    this.$http
    .get("https://localhost:5001/api/tags")
    .then(dados => {
      this.tags = dados.body;
    }, erro => {
      alert("algo deu errado");
    });
    
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

    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();
    today = yyyy + '-' + mm + '-' + dd;

    if(!this.id)
      this.meta.dataLimite = today;
  },
  watch: {
    expanded(){
      var checkboxes = document.getElementById("listaAmigos");
      
      if (this.expanded) 
      {
        this.checkarAmigos();
        checkboxes.style.display = "block";
      }
      else
        checkboxes.style.display = "none";
    }
  },
};
</script>

<style scoped src="../../../css/modal.css"></style>
<style scoped>
big{
  color: black;
}

.quantia {
  font-size: 1em;
  padding: 0 0 15px;
  display: flex;
}

.quantia input {
  border-bottom: 1px black solid;
  text-align: right;
  padding: 0px 0px 0px;
  border-radius: 0;
  background: inherit;
}

.dinheiro {
  margin: 0px 5px;
  width: 100%;
  background: rgba(0, 0, 0, 0.08);
  padding: 8px;
  border-radius: 5px;
}

.dinheiro .campo {
  font-size: 1.3em;
  display: flex;
}

.tipos {
  display: flex;
  overflow: hidden;
}

.tipos label {
  background-color: #e4e4e4;
  color: black;
  font-size: 1em;
  line-height: 1em;
  text-align: center;
  padding: 14px 20px;
  margin-right: -1px;
  border-radius: 4px;
}

#btnDrop {
  font-size: 1.2em;
  background: rgba(0, 0, 0, 0.082);
  cursor: pointer;
  width: fit-content;
}

#listaAmigos {
  padding: 10px;
  border-radius: 5px;
  z-index: 1;
  background-color: #f6f6f6;
  min-width: 230px;
  max-height: 200px;
  overflow: auto;
  display: none;
  position: absolute;
}

#listaAmigos a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  margin-top: 5px;
  border-radius: 5px;
}

.dropdown a:hover {
  background-color: #ddd;
}

#listaAmigos input[type="search"] {
  box-sizing: border-box;
  font-size: 1.1em;
  padding: 5px 10px;
  margin-bottom: 5px;
  width: 100%;
  background: inherit;
  background-position: 14px 12px;
  border-radius: 5px;
  border: 1px solid rgba(128, 128, 128, 0.2);
}

#listaAmigos input[type="search"]:focus {
  background: rgb(255, 255, 255);
  outline: none;
}

.amigos {
  font-size: 1.25em;
}

.tipos {
  display: flex;
  overflow: hidden;
}

.campos {
  border-radius: 5px;
  width: 100%;
  margin-bottom: 10px;
  border: 0px;
  padding: 7px 14px;
  box-sizing: border-box;
  color: black;
  font-size: 1.2em;
  background: rgba(0, 0, 0, 0.08);
}

/* css do select cm checkbox */
.selectBox {
  position: relative;
}

.selectBox select {
  width: 100%;
  font-weight: bold;
}

.overSelect {
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
}

#checkboxes {
  display: none;
  border: 1px #dadada solid;
}

#checkboxes label {
  display: block;
}

#checkboxes label:hover {
  background-color: #1e90ff;
}

#tag {
  width: 100%;
}

.escrito {
  padding: 0px;
  font-size: 1.3em;
  margin-top: 5px;
  color: gray;
}
</style>
