<template>
  <div id="card">
    <div id="cardContent">
      <span id="close" v-on:click="fechar">&times;</span>
      <div class="tipos">
        <label>Metah</label>
      </div>
      <form>
        <input placeholder="Nome" type="text" id="nome" class="campos" />
        <span class="dinheiro">
          <p class="escrito">Objetivo</p>
          <br />
          <p>R$</p>
          <input
            placeholder="0,00"
            type="number"
            min="0.00"
            max="1000000.00"
            step="10.00"
            class="campos quantia"
          />
        </span>
        <span class="dinheiro">
          <br />
          <p class="escrito">Inicial</p>
          <br />
          <p>R$</p>
          <input
            placeholder="0,00"
            type="number"
            min="0.00"
            max="1000000.00"
            step="10.00"
            class="campos quantia"
          />
        </span>
        <br />
        <p class="escritah">Data limite</p>
        <input placeholder="Data" type="date" id="data" class="campos" />
        <div class="dropdown">
          <div v-on:click="mostrarAmigos" id="btnDrop" class="campos">Compartilhar com... ▾</div>
          <div id="listaAmigos" class="dropdown-content">
            <input type="search" placeholder="Pesquisar" v-model="filtroNome" />
            <div v-for="amigo of filtraNome" :key="amigo.nome" class="amigos">
              <div class="pretty p-default p-curve p-fill">
                <input type="checkbox" :id="amigo.nome" :name="amigo.nome" />
                <div class="state p-primary">
                  <label class="nomeAmigo">{{amigo.nome}}</label>
                </div>
              </div>
            </div>
          </div>
        </div>
      </form>
      <span id="save" v-on:click="save">Salvar</span>
    </div>
  </div>
</template>

<script>
import $ from "jquery";

export default {
  data() {
    return {
      expanded: false,
      frase: "",
      filtroNome: "",
      tags: [
        { tag: "tag1" },
        { tag: "tag2" },
        { tag: "tag3" },
        { tag: "tag4" }
      ],
      amigos: [
        { nome: "jovana" },
        { nome: "maria" },
        { nome: "venizius" },
        { nome: "illy" }
      ]
    };
  },
  methods: {
    mostrarAmigos: function() {
      if (document.getElementById("listaAmigos").style.display == "block")
        document.getElementById("listaAmigos").style.display = "none";
      else {
        document.getElementById("listaAmigos").style.display = "block";
      }
    },
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
    save: function() {},
    fechar: function() {
      this.$emit("fecharMeta");
    },
    mostrarAmigos: function() {
      if (
        document.getElementById("listaAmigos").style.display == "inline-block"
      )
        document.getElementById("listaAmigos").style.display = "none";
      else {
        document.getElementById("listaAmigos").style.display = "inline-block";
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
  mounted() {
    $("#card").fadeIn();
  }
};
</script>

<style scoped>
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

#card {
  position: fixed;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  background: rgba(0, 0, 0, 0.3);
}

#cardContent {
  position: fixed;
  top: 8%;
  left: 39.5%;
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

.tipos input {
  position: absolute !important;
  clip: rect(0, 0, 0, 0);
  height: 1px;
  width: 1px;
  border: 0;
  overflow: hidden;
}

.tipos label {
  background-color: #e4e4e4;
  color: black;
  font-size: 1;
  line-height: 1;
  text-align: center;
  padding: 12px 20px;
  margin-right: -1px;
}

.tipos label:hover {
  cursor: pointer;
}

.tipos input:checked + label {
  background-color: rgba(49, 45, 45, 0.349);
}

.tipos label:first-of-type {
  border-radius: 4px 0 0 4px;
}

.tipos label:last-of-type {
  border-radius: 0 4px 4px 0;
}

.campos {
  border-radius: 5px;
  width: 96%;
  margin-top: 12px;
  border: 0px;
  padding: 7px;
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

#save {
  width: 92.5%;
  border-radius: 25px;
  text-align: center;
  font-weight: bold;
  cursor: pointer;
  background: rgb(0, 255, 0, 0.5);
  font-size: 1.5em;
  position: absolute;
  bottom: 0;
  margin-bottom: 15px;
}

#save:hover {
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
  border-bottom: 1px black solid;
  background-color: white;
  width: 39%;
  text-align: right;
  padding: 0px 0px 0px;
  border-radius: 0;
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
  padding: 5px;
  color: gray;
}
.escritah {
  font-size: 1.218em;
  color: gray;
  margin-left: 5px;
}
</style>
