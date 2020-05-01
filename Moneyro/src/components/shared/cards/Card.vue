<template>
  <div id="card">
    <div id="cardContent" class="animate">
      <span id="close" v-on:click="$emit('fecharCard')">&times;</span>
      <div class="tipos">
        <input
          type="radio"
          id="desp"
          name="tipo"
          value="despensa"
          checked
          v-on:click="aparecer('despesa')"
        />
        <label for="desp">Despesa</label>
        <input type="radio" id="rend" name="tipo" value="renda" v-on:click="aparecer('receita')" />
        <label for="rend">Receita</label>
      </div>
      <form id="despesa" v-if="despesa">
        <span>
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
        <input placeholder="Nome" type="text" id="nome" class="campos" />

        <select name="tag" id="tag" class="campos">
          <option>Tag</option>
          <option v-for="tag of tags" :key="tag.nome" :value="tag.nome">@{{ tag.nome }}</option>-->
        </select>

        <input placeholder="Data" type="date" id="data" class="campos" />
        <input placeholder="Local" type="text" id="local" class="campos" />

        <div class="dropdown">
          <div v-on:click="mostrarAmigos" id="btnDrop" class="campos">Compartilhar com... ▾</div>
          <div id="listaAmigos">
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

      <form id="receita" v-if="renda">
        <span>
          <p>R$</p>
          <input
            placeholder="0,00"
            type="number"
            min="0.00"
            max="1000000.00"
            step="10.00"
            class="campos quantia"
            formaction="0.00"
          />
        </span>
        <input placeholder="Nome" type="text" id="nome" class="campos" />
        <input placeholder="Data" type="date" id="data" class="campos" />
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
      despesa: true,
      renda: false,
      filtroNome: "",
      tags: [
        { nome: "tag1" },
        { nome: "tag2" },
        { nome: "tag3" },
        { nome: "tag4" }
      ],
      amigos: [
        { nome: "Jovana" },
        { nome: "Maria" },
        { nome: "Venizius" },
        { nome: "Illy" }
      ]
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
    save: function() {
      alert(1);
    },
    aparecer: function(card) {
      this.despesa = false;
      this.renda = false;
      if (card == "despesa") this.despesa = true;
      else this.renda = true;
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

// this.$set(this.someObject, "b", 2);
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
  width: 100%;
  margin-top: 12px;
  border: 0px;
  padding: 7px 14px;
  box-sizing: border-box;
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
  height: 530px;
  width: 350px;
  background: #fff;
  padding: 15px;
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
  display: inline-block;
}

span p {
  margin-left: 19%;
  padding-bottom: 2%;
  color: gray;
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