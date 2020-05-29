<template>
  <div class="modal">
    <div class="modal-conteudo animate" v-on:click="teste">
      <div class="cima">
        <div class="tipos">
          <label>{{ id ? "Edição" : "Metah"}}</label>
        </div>
        <span class="fechar" v-on:click="$emit('fecharMeta')">&times;</span>
      </div>
      <div class="corpo">
        <form>
          <input placeholder="Nome" type="text" id="nome" class="campos" v-model="nome" />

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
                  step="10.00"
                  class="campos"
                  v-model="objetivo"
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
                  min="0.00"
                  :max="objetivo"
                  step="10.00"
                  class="campos"
                  v-model="atual"
                />
              </div>
            </div>
          </div>

          <span class="escrito">Data limite</span>
          <input type="date" id="data" class="campos" v-model="dataLimite" />

          <div class="dropdown">
            <div v-on:click="mostrarAmigos" id="btnDrop" class="campos">Compartilhar com... ▾</div>
            <div id="listaAmigos" class="dropdown-content">
              <input type="search" placeholder="Pesquisar" v-model="filtroNome" />
              <div v-for="amigo of filtraNome" :key="amigo.nome" class="amigos">
                <div class="pretty p-default p-curve p-fill checks">
                  <input
                    type="checkbox"
                    :id="'amigo'+amigo.id"
                    :name="amigo.nome"
                    :value="amigo.id"
                    v-on:click="addToList(id)"
                  />
                  <div class="state p-primary">
                    <label class="nomeAmigo">{{amigo.nome}}</label>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
      <div class="baixo">
        <span class="excluir" v-on:click="excluir" v-if="id">Excluir</span>
        <span class="salvar" v-on:click="salvar">Salvar</span>
      </div>
    </div>
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
      nome: "",
      atual: 0,
      objetivo: 0,
      dataLimite: Date,
      compartilhado: [],
      listCheckedOptions: []
    };
  },
  methods: {
    showCheckboxes: function() {
      var checkboxes = document.getElementById("checkboxes");
      if (!expanded) {
        checkboxes.style.display = "block";
        this.expanded = true;
      } else {
        checkboxes.style.display = "none";
        this.expanded = false;
      }
    },

    checkAmg: function(id) {
      if (this.amigos >= 5) {
        document.getElementById(id).checked = false;
        alert("no");
      }
    },
    salvar: function() {
      if (this.meta.id) {
        //UPDATE TANANA
      } else {
        //INSERT TANANA
      }
    },
    teste(event) {
      // alert(event.target.tagName);
    },
    excluir: function() {
      // DELETAR A META COM O META.ID
    },
    mostrarAmigos: function() {
      if (
        document.getElementById("listaAmigos").style.display == "inline-block"
      )
        document.getElementById("listaAmigos").style.display = "none";
      else {
        document.getElementById("listaAmigos").style.display = "inline-block";
      }

      if (this.id) this.checkarAmigos();
    },
    checkarAmigos: function() {
      for (var a = 0; a < this.amigos.length; a++)
        document.getElementById("amigo" + this.amigos[a].id).checked = false;

      for (var i = 0; i < this.compartilhado.length; i++) {
        for (var a = 0; a < this.amigos.length; a++) {
          if (this.compartilhado[i].id == this.amigos[a].id) {
            document.getElementById("amigo" + this.amigos[a].id).checked = true;
          }
        }
      }
    },
    addToList: function(id) {
      var checkObj = document.getElementById(id);
      if (checkObj.checked) this.qtdAmigos++;
      else this.qtdAmigos--;
      checkAmg(id);
      // this.qtdAmigos++;
      // if (this.qtdAmigos == 5) {
      //   alert("no puedes continuar");
      //   for (var i = 0; i < document.getElementByClass("amigos").length; i++)
      //     document.getElementByClass("checks").item(i).disabled = true;
      // }
    }
  },
  computed: {
    filtraNome() {
      if (this.filtroNome) {
        let exp = new RegExp(this.filtroNome.trim(), "i");
        return this.amigos.filter(amigo => exp.test(amigo.nome));
      } else {
        return this.amigos;
      }
    }
  },
  created() {
    if (this.id) {
      // var meta = GET META NO BANCO
      var meta = {
        id: 1,
        atual: "1",
        objetivo: "3",
        nome: "Open de Caldicana😎😎",
        dataLimite: "2020-05-01",
        compartilhado: [
          { id: 1, nome: "Maria", foto: 6 },
          { id: 2, nome: "Giovanna", foto: 11 }
        ]
      };
      this.nome = meta.nome;
      this.atual = meta.atual;
      this.objetivo = meta.objetivo;
      this.dataLimite = meta.dataLimite;
      this.compartilhado = meta.compartilhado;
    }

    this.amigos = [
      { id: 1, nome: "Maria" },
      { id: 2, nome: "Giovanna" },
      { id: 3, nome: "Illy" },
      { id: 4, nome: "Venizius" },
      { id: 5, nome: "Enzo" },
      { id: 6, nome: "Rodrigo" },
      { id: 7, nome: "Queen" },
      { id: 8, nome: "Rossi" }
    ];
    // this.amigos (id e nome) = get all amigos by id
  }
};
</script>

<style src="../../../css/modal.css"></style>
<style scoped>
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
  width: fit-content;
  cursor: pointer;
  display: inline-block;
}

#listaAmigos {
  margin-top: 10px;
  padding: 15px;
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

form {
  padding: 10px;
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
