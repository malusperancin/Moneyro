<template>
  <div id="card">
    <div id="cardContent" class="animate">
      <span id="close" v-on:click="$emit('fecharCard')">&times;</span>
      <div v-if="!this.id" class="tipos">
        <input
          type="radio"
          id="desp"
          name="tipo"
          value="despensa"
          checked
          v-on:click="despesa = true, receita = false"
        />
        <label for="desp">Despesa</label>
        <input
          type="radio"
          id="rend"
          name="tipo"
          value="receita"
          v-on:click="despesa = false, receita = true"
        />
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
            v-model="quantia"
          />
        </span>
        <input placeholder="Nome" type="text" id="nome" class="campos" v-model="nome" />

        <select name="tag" id="tag" class="campos">
          <option value="default">Tag: Nenhuma</option>
          <option v-for="(tag, i) of tags" :key="i" :value="tag.nome">{{ tag.nome }}</option>
        </select>

        <input type="date" id="data" class="campos" v-model="data" />
        <input placeholder="Local" type="text" id="local" class="campos" v-model="local" />

        <div class="dropdown">
          <div v-on:click="mostrarAmigos" id="btnDrop" class="campos">Compartilhar com... ▾</div>
          <div id="listaAmigos">
            <input type="search" placeholder="Pesquisar" v-model="filtroNome" />
            <div v-for="amigo of filtraNome" :key="amigo.nome" class="amigos">
              <div class="pretty p-default p-curve p-fill">
                <input type="checkbox" :id="'amigo'+amigo.id" :name="amigo.nome" />
                <div class="state p-primary">
                  <label class="nomeAmigo">{{amigo.nome}}</label>
                </div>
              </div>
            </div>
          </div>
        </div>
      </form>

      <form id="receita" v-if="receita">
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
            v-model="quantia"
          />
        </span>
        <input placeholder="Nome" type="text" id="nome" class="campos" v-model="nome" />
        <input type="date" id="data" class="campos" v-model="data" />
        <select name="tag" id="tag" class="campos">
          <option value="default">Tag: Nenhuma</option>
          <option
            v-for="(tag, i) of tags"
            :key="i"
            :value="tag.nome"
            :id="'tag'+tag.nome"
          >{{ tag.nome }}</option>
        </select>
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
      despesa: true,
      receita: false,
      filtroNome: "",
      tags: [],
      amigos: [],
      nome: "",
      data: Date,
      tag: "",
      quantia: 0.0,
      compartilhado: [],
      local: ""
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
    salvar() {
      //
    },
    excluir() {
      //DELETE REGISTRO WHERE THIS.ID
    },
    aparecer: function(card) {},
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
      for (var a = 0; a < this.amigos.length; a++) {
        document.getElementById("amigo" + this.amigos[a].id).checked = false;
      }
      for (var i = 0; i < this.compartilhado.length; i++) {
        for (var a = 0; a < this.amigos.length; a++) {
          if (this.compartilhado[i].id == this.amigos[a].id) {
            document.getElementById("amigo" + this.amigos[a].id).checked = true;
          }
        }
      }
    },
    checkarTag: function() {
      var comboTags = document.getElementById("tag");
      if (this.tag) comboTags.value = this.tag;
      // pegar do banco o nome da tag e o id
      else comboTags.value = "default";
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
    this.checkarTag();
  },
  created() {
    if (this.id) {
      // var registro = GET META NO BANCO
      var registro = {
        id: 1,
        nome: "almoço",
        data: "2004-12-02",
        tag: "Alimentação",
        quantia: -85,
        local: "mc donalds",
        compartilhado: [
          { id: 1, nome: "Maria", foto: 6 },
          { id: 2, nome: "Giovanna", foto: 11 }
        ]
      };
      this.nome = registro.nome;
      this.data = registro.data;
      this.tag = registro.tag;
      this.quantia = registro.quantia;
      this.compartilhado = registro.compartilhado;
      this.local = registro.local;
    }

    //GET ALL TAGS
    this.tags = [
      { nome: "Alimentação" },
      { nome: "Lazer" },
      { nome: "tag3" },
      { nome: "tag4" }
    ];

    this.amigos = [
      { id: 1, nome: "Maria" },
      { id: 2, nome: "Giovanna" },
      { id: 3, nome: "Illy" },
      { id: 4, nome: "Venizius" }
    ];
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
  font-size: 1em;
  line-height: 1em;
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

#close:hover {
  background: rgba(255, 0, 0);
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

#excluir:hover {
  background: rgba(255, 0, 0);
}

#card {
  display: flex;
  justify-content: center;
  align-items: center;
  position: fixed;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  background: rgba(0, 0, 0, 0.3);
  z-index: 500;
}

#cardContent {
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