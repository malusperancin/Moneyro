<template>
  <div class="modal">
    <form v-on:submit.prevent class="modal-conteudo animate width-25">
      <div class="cima">
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
            v-on:click="despesa = false, receita = true, registro.lugar = null"
          />
          <label for="rend">Receita</label>
        </div>
        <div class="tipos" v-else>
          <input type="radio" />
          <label id="edit">Edição</label>
        </div>
        <span class="fechar" v-on:click="$emit('fechar')">&times;</span>
      </div>
      <div class="corpo">
          <div class="quantia">
            <big>R$</big>
            <input
              placeholder="0,00" 
              type="number"
              min="1"
              max="1000000"
              step="any"
              class="campos"
              v-model="registro.quantia"
              required
            />
          </div>

          <input required placeholder="Nome" type="text" id="nome" class="campos" v-model="registro.nome" />

          <input required type="date" id="data" class="campos" v-model="registro.data" />

          <input
            v-if="despesa"
            placeholder="Local"
            type="text"
            id="local"
            class="campos"
            v-model="registro.lugar"
          />

          <select name="tag" id="tag" class="campos" v-model="registro.idTag">
            <option class="tag" value="default">Tag</option>
            <option class="tag" v-for="tag of tags" :key="tag.id" :value="tag.id">{{ tag.nome }}</option>
          </select>

          <div class="dropdown" v-if="despesa">
            <div v-on:click="expanded = !expanded" id="btnDrop" class="campos">Compartilhar com... ▾</div>
            <div id="listaAmigos">
              <input type="search" placeholder="Pesquisar" v-model="filtroNome" />
              <div v-for="(amigo, i) of filtraNome" :key="i" class="amigos">
                <div class="pretty p-default p-curve p-fill">
                  <input type="checkbox"  v-on:click="incluirAmg(amigo.id)" :id="'amigo'+amigo.id" class="amigo" :name="amigo.nome" :value="amigo.id"/>
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
  props: {
    id: Number
  },
  data() {
    return {
      expanded: false,
      despesa: true,
      receita: false,
      filtroNome: "",
      tags: [],
      amigos: [],
      registro: {
        idUsuario: this.$session.get("id"),
        idTag: "default",
        nome: "",
        lugar: null,
        data: Date,
        quantia: null,
        compartilhamentos:[]
      },
      qtdAmigos: 0
    };
  },
  methods: {
    adicionar() {
      if(this.registro.quantia == null)
      {
        this.$emit('tiraZero');   
        return;
      }

      if(this.despesa)
        this.registro.quantia = -(this.registro.quantia);

      var ret = "";

      if(this.registro.compartilhamentos)
      {
        this.registro.compartilhamentos.map(c => {
          ret += " "+c;
        })

        ret+=" ";
      }
      else
        ret = null;

      this.registro.compartilhamentos = ret;
      this.registro.quantia = parseFloat(this.registro.quantia);

      this.$http
      .post("https://localhost:5001/api/registros", this.registro)
      .then(dados=> {
        if(this.$router.currentRoute.path != "/planilhas")
          this.$router.push("planilhas");

          this.$emit('atualizar');
          this.$emit('fechar');   
      }, erro => {
        console.log("Erro ao adicionar registro: " + erro.bodyText);
      });

      this.registro.quantia = Math.abs(this.registro.quantia);
    },
    atualizar(){
      if(this.despesa)
        this.registro.quantia = -(this.registro.quantia);
      
      var ret = "";

      if(this.registro.compartilhamentos[0])
      {
        this.registro.compartilhamentos.map(c => {
          ret += " "+c;
        })

        ret+=" ";
      }
      else
        ret = null;

      this.registro.compartilhamentos = ret;
      this.registro.quantia = parseFloat(this.registro.quantia);

      this.$http
      .put("https://localhost:5001/api/registros/" + this.registro.id, this.registro)
      .then(dados => {
          this.$emit('atualizar');
          this.$emit('fechar');
          this.$emit('mostrarMsg');
      }, erro => {
        console.log("Erro ao atualizar registro: " + erro.body);
      });

      this.registro.quantia = Math.abs(this.registro.quantia);
    },
    excluir(){
      this.$http
      .delete("https://localhost:5001/api/registros/" + this.registro.id)
      .then(dados => {
        this.$emit('atualizar');
        this.$emit('fechar');
      }, erro => {
        console.log("Erro ao remover registro: " + erro.body);
      });
    },
    checkarAmigos() {
      for (var i = 0; i < this.registro.compartilhamentos.length; i++)
        for (var a = 0; a < this.amigos.length; a++) 
          if (this.registro.compartilhamentos[i] == this.amigos[a].id) 
            document.getElementById("amigo" + this.amigos[a].id).checked = true;
    },
    incluirAmg(id) {
      var checkObj = document.getElementById("amigo"+id);
      
      if (this.registro.compartilhamentos.length >= 5 && checkObj.checked)
      {
        checkObj.checked = false;
        alert("máximo 5 pessoas!");
        return;
      }

      if (checkObj.checked)
        this.registro.compartilhamentos.push(id);
      else
        this.registro.compartilhamentos = this.registro.compartilhamentos.filter(a => a!=id);
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
      .get("https://localhost:5001/api/registros/" + this.id)
      .then(dados => {
        this.registro = dados.body;

        this.registro.data = new Date(this.registro.data).toJSON().substring(0,10);

        if(this.registro.compartilhamentos)
          this.registro.compartilhamentos = this.registro.compartilhamentos.trim().split(" ").map(Number);
        else
          this.registro.compartilhamentos = []

        // for (var i = 0; i < this.registro.compartilhamentos.length; i++)
        //   this.getAmigo(this.registro.compartilhamentos[i]);

        if(this.registro.quantia > 0)
        {
          this.receita = true;
          this.despesa = false
        }
        
        this.registro.quantia = Math.abs(this.registro.quantia);
      }, erro => {
        console.log("Erro ao recuperar registro: " + erro.body);
      });
    }

    this.$http
    .get("https://localhost:5001/api/amigos/" + this.$session.get("id"))
    .then(dados => {
      for(var i=0; i< dados.body.length; i++)
        if(dados.body[i].idAmigoA == this.$session.get("id"))
              this.getAmigo(dados.body[i].idAmigoB);
          else
              this.getAmigo(dados.body[i].idAmigoA);          
    }, erro => {
      console.log("Erro ao recuperar amigos: " + erro.body);
    });

    this.$http
    .get("https://localhost:5001/api/tags")
    .then(dados => {
      this.tags = dados.body;
    }, erro => {
      console.log("Erro ao recuperar tags: " + erro.bodyText);
    });
    
    if(!this.id)
      this.registro.data = new Date().toJSON().substring(0,10);
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

// this.$set(this.someObject, "b", 2);
</script>

<style scoped src="../../../css/modal.css"></style>
<style scoped>
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
  padding: 14px 20px;
  margin-right: -1px;
}

.tipos label:hover {
  cursor: pointer;
}

.tipos input:checked + label {
  background-color: rgba(49, 45, 45, 0.349);
}

#edit {
  border-radius: 4px;
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
  margin-bottom: 10px;
  border: 0px;
  padding: 7px 14px;
  box-sizing: border-box;
  color: black;
  font-size: 1.2em;
  background: rgba(0, 0, 0, 0.08);
}

.quantia {
  font-size: 2em;
  display: flex;
  justify-content: center;
  align-items: baseline;
  padding: 0 0 15px;
}

.quantia input {
  border-bottom: 1px black solid;
  text-align: right;
  padding: 0px 0px 0px;
  border-radius: 0;
  background: inherit;
  width: 50%;
}

#tag {
  width: 100%;
}
</style>