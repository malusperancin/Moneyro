<template>
  <div class="pag">
    <Menu v-on:atualizar="getTodos()"/>
    <Perfil />
    <Card v-if="verCard" :id="id" v-on:atualizar="getTodos()"  v-on:mostrarMsg="mostrarMensagem" v-on:fechar="verCard = false" />
     <Mensagem
      :msg="msg"
      v-if="msg.visivel"
      v-on:fechar="msg.visivel = false"
    ></Mensagem>
    <Topo />
    <div class="centro">
      <div name="mostrar" class="filtros">
        <select class="filtro" @change="registro" id="registro">
           <option value="todos">Todos</option>
          <option value="despesa">Despesas</option>
          <option value="receita">Receitas</option>
        </select>
        <select name="ordem" class="filtro" @change="ordem" id="ordem">
          <option value="recentes" selected>Mais Recentes</option>
          <option value="antigos">Mais Antigos</option>
        </select> 
        <input type="search" placeholder="Busque um registro..." id="buscaNome" v-model="filtro"/>
      </div>
      <div id="registros">
        <div class="umDia" v-for="(dia, i) in filtraReg" :key="i">
          <p class="data">Dia {{dia.data}}</p>
          <table cellspacin="0">
            <tr
              v-for="(reg, j) in dia.registros"
              :key="j"
              :class="[{'despesa' : reg.quantia < 0}, {'receita' : reg.quantia > 0}]"
              v-on:click="id = reg.id, verCard=true"
            >
              <td class="tag">
                <img src="src/images/tag.png" alt class="tagImg" />
                {{reg.tag}}
              </td>
              <td class="nome">{{reg.nome}}</td>
              <td class="comp">
                <div class="amigos">
                  <img v-for="(amigo, i) in reg.compartilhamentos" :title="amigo.nome" v-bind:key="i" :src="'src/images/perfil'+ amigo.foto + '.png'" alt />
                </div>
              </td>
              <td class="quantia">
                <img src="src/images/moeda.png" alt class="moedaImg" />
                {{reg.quantia}}
              </td>
            </tr>
          </table>
        </div>
      </div>
      <div>
      </div>
    </div>
  </div>
</template>

<script>
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/perfil/Perfil.vue";
import Card from "../shared/cards/Card.vue";
import Topo from "../shared/voltar-topo/Voltar-Topo.vue";
import Mensagem from "../shared/mensagem/Mensagem.vue";

export default {
  components: {
    Menu,
    Perfil,
    Card,
    Topo,
     Mensagem
  },
  data() {
    return {
      registros: [],
      registrosData: [],
      verCard: false,
      filtro: "",
        msg: {
        visivel: false,
        titulo: "",
        mensagem: "",
        botoes: []
      }
    };
  },
  methods: {
     mostrarMensagem(){
            this.msg.titulo = "Alteração";
            this.msg.mensagem = "Alteração feita com sucesso!";
            this.msg.botoes = [
             {
               mensagem: "Ok",
               evento: "fechar"
             }
            ];
            this.msg.visivel = true;
    },
    formataData(data) {
      data = data.substring(0,10);
      var ano = data.split("-")[0];
      var mes = data.split("-")[1];
      var dia = data.split("-")[2];
      return ("0" + dia).slice(-2) + "/" + ("0" + mes).slice(-2) + "/" + ano;
      // Utilizo o .slice(-2) para garantir o formato com 2 digitos.
    },
    registro(){
      var select = document.getElementById('registro').value;

      if(select == "todos")
        this.getTodos();
      
      if(select == "despesa")
          this.getDespesas();
    
      if(select == "receita")
        this.getReceitas();
    },
    ordem(){
      var select = document.getElementById('ordem').value;

      if(select == "recentes")
        document.getElementById("registros").style = "flex-direction: column";

      if(select == "antigos")
        document.getElementById("registros").style = "flex-direction: column-reverse";      
    },
    organizar(vetor){
      var novos = [];
      var ret = [];
        
      for (var i = 0; i < vetor.length; i++) {
        novos.push({
          id: vetor[i].id,
          nome: vetor[i].nome,
          tag: this.tags[vetor[i].idTag-1].nome,
          quantia: vetor[i].quantia,
          compartilhamentos: vetor[i].compartilhamentos
        });

        if (i + 1 == vetor.length) {
          ret.push({
            data: this.formataData(vetor[i].data),
            registros: novos
          });
          break;
        }

        if (vetor[i].data != vetor[i + 1].data) {
          ret.push({
            data: this.formataData(vetor[i].data),
            registros: novos
          });
          novos = [];
        }
      }

      return ret;
    },
    getDespesas(){
      this.$http
      .get("https://localhost:5001/api/registros/despesas/" + this.$session.get("id") )
      .then(dados => {
        this.registros = dados.body;

        for(var i = 0; i < this.registros.length; i++)
            if(this.registros[i].compartilhamentos != null)
              this.setCompartilhamentos(i, this.registros[i].compartilhamentos);
              
      }, erro => {
        alert("algo deu errado");
      });
    },
    getReceitas(){
      this.$http
      .get("https://localhost:5001/api/registros/receitas/" + this.$session.get("id") )
      .then(dados => {
        this.registros = dados.body;

        for(var i = 0; i < this.registros.length; i++)
          if(this.registros[i].compartilhamentos != null)
            this.setCompartilhamentos(i, this.registros[i].compartilhamentos);
              
      }, erro => {
        alert("algo deu errado");
      });
    },
    getTodos(){
      this.$http
        .get("https://localhost:5001/api/registros/todos/" + this.$session.get("id"))
        .then(dados => {
          this.registros = dados.body;

          for(var i = 0; i < this.registros.length; i++)
            if(this.registros[i].compartilhamentos != null)
              this.setCompartilhamentos(i, this.registros[i].compartilhamentos);
              
        }, erro => {
          alert("algo deu errado");
        });
    },
    setCompartilhamentos(indice, comp){
      var ids = comp.trim().split(/(\s+)/);

      this.registros[indice].compartilhamentos = [];
      
      for(var i = 0; i < ids.length; i++)
        if(ids[i] > 0)
          this.getUsuario(ids[i], indice);
    },
    getUsuario(id, i){
      this.$http
      .get("https://localhost:5001/api/usuarios/" + id)
      .then(dados => { 
        this.registros[i].compartilhamentos.push({
          id: dados.body.id,
          nome: dados.body.nome,
          foto: dados.body.foto
        });
      }, erro => {
        alert("algo deu errado metakkk" + erro.bodyText);
      });
    },
  },
  beforeCreate() {
    if (!this.$session.exists()) {
      this.$router.push('/')
    }
  },
  created(){
    document.title = "Planilhas";

    this.$http
    .get("https://localhost:5001/api/tags")
    .then(dados => {
      this.tags = dados.body;
    }, erro => {
      alert("Erro ao recuperar tags");
    });
  },
  mounted() {
    this.getTodos();
  },
  computed: {
    filtraReg() {
      if (this.filtro) {
        let exp = new RegExp(this.filtro.trim(), "i");
        return this.organizar(this.registros.filter(registro => exp.test(registro.nome)));
      } else {
        return this.organizar(this.registros);
      }
    }
  },
};
</script>

<style scoped>
#registros{
  display: flex;
  flex-direction: column;
  padding: 30px 0;
}

.amigos {
  display: flex;
  width: 100%;
  justify-content: flex-end;
}

.amigos div {
  margin-left: -15px;
  margin-bottom: 0;
  display: flex;
}

.amigos img {
  border: 3px solid rgb(236, 228, 228);
  width: 30px;
  margin-left: -10px;
  border-radius: 87px;
  margin-bottom: -5px;
}

.umDia{
  /* background: rgba(255, 255, 255, 0.1);
  border-radius: 5px; */
  margin: 5px 0;
  padding: 5px 10px;
}

.umDia table {
  width: 100%;
  box-sizing: border-box;
  border-collapse: separate;
  border-spacing: 0px 10px;
}

.umDia td {
  padding: 5px 15px;
  font-size: 1.25em;
  color: rgb(216, 201, 201);
}

tr {
  text-align: start;
}

.data {
  margin: 0;
  font-size: 1.4em;
  color: rgba(255, 255, 255, 0.8);
}

.despesa:hover {
  background-color: rgb(184, 31, 31);
  cursor: pointer;
  transform: scale(1.01);
}

.receita:hover {
  background-color: rgb(19, 134, 19);
  cursor: pointer;
  transform: scale(1.01);
}

.despesa {
  background-color: rgba(170, 36, 36, 0.8);
  transition: transform 0.5s;
}

.receita {
  background-color: rgba(19, 129, 19, 0.8);
  transition: transform 0.5s;
}

.tag {
  width: 25%;
}

.nome {
  width: 30%;
}

.comp {
  width: 25%;
}

.quantia {
  width: 20%;
}

.filtros{
  display: flex;
  justify-content: space-between;
}

.reverso{
  flex-direction: column-reverse;
}

.normal{
  flex-direction: column;
}

#buscaNome {
  border-radius: 5px;
  border: none;
  padding: 7px 14px;
  box-sizing: border-box;
  font-size: 1.2em;
  width: 40%;
  color: rgba(255, 255, 255, 0.7);
  background: rgba(255, 255, 255, 0.078);
}

/*#buscaNome:focus {
   cor pra qndo clicar 
}*/

.filtro {
  border-radius: 5px;
  border: 0px;
  padding: 7px 14px;
  color: black;
  font-size: 1.2em;
  background: rgba(255, 255, 255, 0.411);
}

.moedaImg {
  width: 25px;
  float: left;
  margin: 3px;
}

.tagImg {
  width: 25px;
  float: left;
  margin: 3px;
}
</style>