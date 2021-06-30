<template>
  <div class="pag">
    <Menu v-on:atualizar="getRegistros()"/>
    <Perfil />
    <Card v-if="verCard" :id="id" v-on:atualizar="getRegistros()"  v-on:mostrarMsg="mostrarMensagem" v-on:fechar="verCard = false" />
     <Mensagem
      :msg="msg"
      v-if="msg.visivel"
      v-on:fechar="msg.visivel = false"
      v-on:sair="sairRegistro(), msg.visivel = false"
    ></Mensagem>
    <Topo />
    <div class="centro">
      <div name="mostrar" class="filtros">
        <div>
          <select class="filtro" v-model="filtro" id="registro">
            <option value="todos">Todos</option>
            <option value="despesa">Despesas</option>
            <option value="receita">Receitas</option>
          </select>
          <select name="ordem" class="filtro" @change="ordem" id="ordem">
            <option value="recentes" selected>Mais Recentes</option>
            <option value="antigos">Mais Antigos</option>
          </select> 
        </div>
        <input type="search" placeholder="Busque um registro..." id="buscaNome" v-model="pesquisa"/>
      </div>
      <div id="registros">
        <div v-if="!filtraReg[0]">
          <h1 style="color: white">Minha nossa mas não tem nada aqui! <br> Faça alguns registros e eles ficarão paradinhos te esperando...</h1>
        </div>
        <div v-else class="umDia" v-for="(dia, i) in filtraReg" :key="i">
          <p class="data">Dia {{formataData(dia.data)}}</p>
          <table cellspacin="0">
            <tr
              v-for="(reg, j) in dia.registros"
              :key="j"
              :class="[{'despesa' : reg.quantia < 0}, {'receita' : reg.quantia > 0}]"
              v-on:click="abrirRegistro(reg)"
            >
              <td class="tag">
                <img src="src/images/tag.png" alt class="tagImg" />
                {{reg.tag.nome}}
              </td>
              <td class="nome">{{reg.nome}}</td>
              <td class="compart">
                <div class="amigos">
                  <img v-for="(amigo, i) in reg.compartilhamentos" :title="amigo.nome" v-bind:key="i" :src="'src/images/perfil'+ amigo.foto + '.png'" alt />
                </div>
              </td>
              <td class="quantia">
                <img src="src/images/moeda.png" class="moedaImg" />
                &nbsp; {{(Math.abs(reg.quantia)).toLocaleString('pt-BR', {style: 'currency', currency: 'BRL'})}}
              </td>
              <td class="sair">
                <div v-if="reg.idUsuario != $session.get('id')">
                  <ion-icon  name="log-out-outline" class="nav_icon" title="Sair" v-pre></ion-icon>
                </div>
              </td>
            </tr>
          </table>
        </div>
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
      id: 0,
      verCard: false,
      filtro: "todos",
      pesquisa: "",
      msg: {},
    };
  },
  methods: {
    abrirRegistro(registro)
    {
      this.id = registro.id;

      if(registro.idUsuario == this.$session.get('id'))
        this.verCard = true;
      else
        this.msg = {
          visivel: true,
          titulo: "Atenção!",
          mensagem: "Você deseja sair dessa despesa?",
          botoes: [{
            mensagem: "Cancelar",
            evento: "fechar"
          },
          {
            mensagem: "Sim",
            evento: "sair"
          }]
        };
    },
    sairRegistro() 
    {
      this.$http.delete("https://localhost:5001/api/compartilhadoRegistros/"+this.id+"/"+this.$session.get('id'));
      this.registros = this.registros.filter(r => r.id != this.id);
    },
    mostrarMensagem(){
      this.msg = {
        visivel: true,
        titulo: "Alteração",
        mensagem: "Alteração feita com sucesso!",
        botoes: [{
          mensagem: "Ok",
          evento: "fechar"
        }]
      };
    },
    formataData(data) {
      data = data.split("T")[0].split("-");
      return data[2] +"/"+ data[1] +"/"+ data[0];
    },
    ordem(){
      var select = document.getElementById('ordem').value;

      if(select == "recentes")
        document.getElementById("registros").style = "flex-direction: column";

      if(select == "antigos")
        document.getElementById("registros").style = "flex-direction: column-reverse";      
    },
    getRegistros(){
      this.verCard = false;
      this.$http
        .get("https://localhost:5001/api/registros/todos/" + this.$session.get("id"))
        .then(dados => {
          this.registros = dados.body;
          
          for(let [i, registro] of this.registros.entries())
          {
            this.setCompartilhamentos(i, registro);
              
            if(registro.idUsuario != this.$session.get("id"))
              this.getUsuario(i, registro.idUsuario);

            registro.quantia = Math.floor(registro.quantia*100)/100;
            registro.tag = this.tags.filter(t => t.id == registro.idTag)[0];
          }
        })
        .catch( erro => alert("algo deu errado"));
    },
    setCompartilhamentos(index, registro){
      this.$http
          .get("https://localhost:5001/api/compartilhadoRegistros/"+registro.id)
          .then(dados => {
            this.registros[index].compartilhamentos = [];
            
            for(let i = 0; i < dados.body.length; i++)
              this.registros[index].compartilhamentos.push({
                id: dados.body[i][0],
                nome: dados.body[i][2],
                foto: dados.body[i][1]
              });

            this.$forceUpdate();
          })
          .catch(erro => console.log("Erro:" + erro.bodyText));
    },
    getUsuario(i, id) {
      this.$http
          .get("https://localhost:5001/api/usuarios/" + id)
          .then(dados => { 
            this.registros[i].compartilhamentos.push({
              id: dados.body.id,
              nome: dados.body.nome,
              foto: dados.body.foto
            });
            this.$forceUpdate();
          })
          .catch(erro => console.log("Erro: " + erro.bodyText));
    },
    organizar(vetor){
      var ret = [];

      for(let i = 0; i < vetor.length; i++)
      {
        var data = vetor[i].data;
        var registros = [];

        for(;vetor[i] != undefined && vetor[i].data == data; i++)
          registros.push(vetor[i]);

        i--;

        ret.push({
          data: data,
          registros: registros
        });
      }

      return ret;
    },
  },
  beforeCreate() {
    if (!this.$session.exists())
      this.$router.push('/')
  },
  created(){
    document.title = "Planilhas";

    this.$http
    .get("https://localhost:5001/api/tags")
    .then(dados => {
      this.tags = dados.body;
      this.getRegistros();
    }, erro => {
      alert("Erro ao recuperar tags");
    });
  },
  computed: {
    filtraReg() {
      if(this.pesquisa)
        return this.organizar(this.registros.filter(r => r.nome.toLowerCase().includes(this.pesquisa.toLowerCase())));

      if(this.filtro == "todos")
        return this.organizar(this.registros);
        
      if(this.filtro == "despesa")
        return this.organizar(this.registros.filter(r => r.quantia < 0));

      if(this.filtro == "receita")
        return this.organizar(this.registros.filter(r => r.quantia > 0));
    }
  },
};
</script>

<style scoped>
.nav_icon{
  font-size: 30px;
}

.sair {
  width: 4%;
}

.sair div{
  display: flex;
  align-items: center;
}

#registros{
  display: flex;
  flex-direction: column;
  padding: 30px 0;
}

.amigos {
  display: flex;
  width: 100%;
  justify-content: flex-end;
  align-items: center;
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
}

.umDia{
  /* background: rgba(255, 255, 255, 0.1);
  border-radius: 5px; */
  margin: 5px 0;
  padding: 5px 0;
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
  display: flex;
  align-items: center;
  margin: 10px 0;
  position: relative;
}

tr:first-child { border-top-left-radius: 10px; }
tr:first-child { border-top-right-radius: 10px; }
tr:last-child { border-bottom-left-radius: 10px; }
tr:last-child { border-bottom-right-radius: 10px; }

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
  display: flex;
}

.receita {
  background-color: rgba(19, 129, 19, 0.8);
  transition: transform 0.5s;
  display: flex;
}

.tag {
  width: 25%;
  display: flex;
}

.nome {
  flex: 1
}

.compart {
  flex: 1;
}

.quantia {
  width: 15%;
}

.filtros {
  display: flex;
  justify-content: space-between;
}

.filtros div{
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
  color: rgba(255, 255, 255, 0.7);
  background: rgba(255, 255, 255, 0.078);
}

/*#buscaNome:focus {
   cor pra qndo clicar 
}*/

.filtro {
  margin: 0 5px 0 0;
  border-radius: 5px;
  border: 0px;
  padding: 7px 14px;
  color: black;
  font-size: 1.2em;
  background: rgba(255, 255, 255, 0.267);
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