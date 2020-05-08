<template>
  <div id="card">
    <div id="cardContent" class="animate">
      <span id="close" v-on:click="$emit('fecharMeta')">&times;</span>
      <div class="tipos">
        <label>
          <img v-if="id" src="src/images/editar.png" width="20" margin="5px" />
          {{ id ? "Editar" : "Metah"}}
        </label>
      </div>
      <form>
        <input placeholder="Nome" type="text" id="nome" class="campos" v-model="nome" />
        <!-- <input
          placeholder="Nome"
          :value="meta ? meta.nome : 'Nome'"
          type="text"
          id="nome"
          class="campos"
          :v-model="nome"
        />-->
        <span class="dinheiro">
          <br />
          <span class="escrito">{{ id ? "Atual" : "Inicial"}}</span>
          <br />
          <span class="rs">R$</span>
          <input
            placeholder="0.00"
            type="number"
            min="0.00"
            :max="objetivo"
            step="10.00"
            class="quantia"
            v-model="atual"
          />
          <!-- <input
            placeholder="0.00"
            type="number"
            min="0.00"
            :max="objetivo"
            step="10.00"
            class="quantia"
            :v-model="atual"
          :value="meta ? meta.atual : ''"  
          />-->
        </span>

        <span class="dinheiro">
          <br />
          <span class="escrito">Objetivo</span>
          <br />
          <span class="rs">R$</span>
          <input
            placeholder="0.00"
            type="number"
            min="0.00"
            max="1000000.00"
            step="10.00"
            class="quantia"
            v-model="objetivo"
          />
          <!-- <input
            placeholder="0.00"
            :value="meta ? meta.objetivo : '0.00'"
            type="number"
            min="0.00"
            max="1000000.00"
            step="10.00"
            class="quantia"
            :v-model="objetivo"
          />-->
        </span>
        <br />
        <p class="escritah">Data limite</p>
        <input type="date" id="data" class="campos" v-model="dataLimite" />
        <!-- <input
          placeholder="Data"
          :value="meta ? meta.data : ''"
          type="date"
          id="data"
          class="campos"
          :v-model="data"
        />-->
        <div class="dropdown">
          <div v-on:click="mostrarAmigos" id="btnDrop" class="campos">Compartilhar com... ▾</div>
          <div id="listaAmigos" class="dropdown-content">
            <input type="search" placeholder="Pesquisar" v-model="filtroNome" />
            <div v-for="amigo of filtraNome" :key="amigo.nome" class="amigos">
              <div class="pretty p-default p-curve p-fill">
                <input type="checkbox" :id="'amigo'+amigo.id" :name="amigo.nome" :value="amigo.id" />
                <div class="state p-primary">
                  <label class="nomeAmigo">{{amigo.nome}}</label>
                </div>
              </div>
            </div>
          </div>
        </div>
      </form>
      <div id="botoes">
        <span id="excluir" v-on:click="excluir" v-if="id">Excluir</span>
        <span id="salvar" v-on:click="salvar">Salvar</span>
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
      filtroNome: "",
      amigos: [],
      nome: "",
      atual: 0.0,
      objetivo: 0.0,
      dataLimite: Date,
      compartilhado: []
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
    salvar: function() {
      if (this.meta.id) {
        //UPDATE TANANA
      } else {
        //INSERT TANANA
      }
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
  mounted() {},
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
      { id: 4, nome: "Venizius" }
    ];
    // this.amigos (id e nome) = get all amigos by id
  }
};
</script>

<style scoped>
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
  padding: 12px 20px;
  margin-right: -1px;
  border-radius: 4px;
}

.tipos img {
  width: 20px;
  margin-right: 5px;
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

.rs {
  font-size: 2.8em;
}
.amigos {
  font-size: 1.25em;
}

#card {
  display: flex;
  justify-content: center;
  /* margin-left: 1000px; */
  align-items: center;
  position: fixed;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  background: rgba(0, 0, 0, 0.3);
  z-index: 9999999;
}

#cardContent {
  border-radius: 5px;
  height: 500px;
  width: 350px;
  background: #fff;
  padding: 15px;
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
  width: 96%;
  margin-bottom: 7px;
  border: 0px;
  padding: 7px 14px;
  color: black;
  font-size: 1.2em;
  background: rgba(0, 0, 0, 0.082);
}

#close {
  float: right;
  width: 40px;
  height: 40px;
  border-radius: 25px;
  background: rgba(255, 0, 0, 0.5);
  text-align: center;
  cursor: pointer;
  font-size: 1.6em;
  font-weight: bold;
}

#botoes {
  display: flex;
  justify-content: space-around;
}

#excluir,
#salvar {
  padding: 4px 35px;
  border-radius: 25px;
  text-align: center;
  font-weight: bold;
  cursor: pointer;
  font-size: 1.5em;
}

#excluir {
  background: rgba(255, 0, 0, 0.5);
}

#salvar {
  background: rgb(0, 255, 0, 0.5);
}

#salvar:hover {
  background: rgb(0, 255, 0);
}

#close:hover {
  background: rgba(255, 0, 0);
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

.quantia {
  border: 0;
  border-bottom: 1px black solid;
  background-color: transparent;
  width: 39%;
  text-align: right;
  margin-right: 5px;
  color: black;
  font-size: 1.2em;
  margin-bottom: 7px;
}

#tag {
  width: 100%;
}

span .quantia,
p {
  font-size: 2.5em;
  display: inline;
  padding-top: 0%;
  margin-left: 0px;
}

span p {
  /* margin-left: 5%; */
  padding-bottom: 2%;
  color: gray;
}

.dinheiro {
  padding: 0px;
  font-size: 0.8em;
}

.escrito {
  padding: 0px;
  font-size: 1.5em;
  margin-top: 5px;
  padding-bottom: -10px;
  color: gray;
}
.escritah {
  font-size: 1.218em;
  color: gray;
  margin-left: 5px;
  padding-bottom: -10px;
  margin-bottom: -10px;
}

.animate {
  -webkit-animation: animatezoom 0.6s;
  animation: animatezoom 0.6s;
}

@-webkit-keyframes animatezoom {
  from {
    -webkit-transform: scale(0);
  }
  to {
    -webkit-transform: scale(1);
  }
}

@keyframes animatezoom {
  from {
    transform: scale(0);
  }
  to {
    transform: scale(1);
  }
}
</style>
