<template>
  <div class="pag">
    <Menu v-on:atualizar="getRegistros()"/>
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
          <select name="ordem" class="filtro" v-model="filtro_tag" id="tag">
            <option value="" selected>Todos</option>
            <option v-for="tag in tags" :key="tag.id" :value="tag.nome">{{tag.nome}}</option>
          </select> 
        </div>
        <input type="search" placeholder="Busque um registro..." id="buscaNome" v-model="pesquisa"/>
      </div>
      <div id="registros">
        <div v-if="!registros.carregado">
          <div class="placeholder">
            <div class="dia"></div>
            <div class="registro"></div>
            <div class="registro"></div>
            <div class="registro"></div>
            <div class="dia"></div>
            <div class="registro"></div>
            <div class="registro"></div>
            <div class="registro"></div>
            <div class="registro"></div>
            <div class="registro"></div>
          </div>
        </div>
        <div v-else>
          <div v-if="!filtraReg[0]">
            <h1 style="color: white">Minha nossa mas não tem nada aqui! <br> Faça alguns registros e eles ficarão paradinhos te esperando...</h1>
          </div>
          <div v-else class="umDia" v-for="(dia, i) in filtraReg" :key="i">
            <p class="data">{{ formataData(dia.data)}}</p>
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
      registros: {
        carregado: false,
        dados: []
      },
      meses: [
        "Janeiro",
        "Fevereiro",
        "Março",
        "Abril",
        "Maio",
        "Junho",
        "Julho",
        "Agosto",
        "Setembro",
        "Outubro",
        "Novembro",
        "Dezembro"
      ],
      tags: [],
      id: 0,
      verCard: false,
      filtro: "todos",
      filtro_tag: "",
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
      this.$http.delete("https://localhost:5001/api/compartilhadoRegistros/"+this.id+"/"+this.$session.get('id'))
                .then(() => {this.registros.dados = this.registros.dados.filter(r => r.id != this.id)});
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
      return data[2] + " de " + this.meses[parseInt(data[1])-1] + " de " + data[0];
    },
    ordem()
    {
      var select = document.getElementById('ordem').value;

      if(select == "recentes")
        document.getElementById("registros").style = "flex-direction: column";

      if(select == "antigos")
        document.getElementById("registros").style = "flex-direction: column-reverse";      
    },
    getRegistros()
    {
      this.verCard = false;

      this.$http
        .get("https://localhost:5001/api/registros/todos/" + this.$session.get("id"))
        .then(dados => {
          this.registros.carregado = true;
          this.registros.dados = dados.body;
          
          for(let [i, registro] of this.registros.dados.entries())
          {
            this.setCompartilhamentos(i, registro);
              
            if(registro.idUsuario != this.$session.get("id"))
              this.getUsuario(i, registro.idUsuario);

            registro.quantia = Math.floor(registro.quantia*100)/100;
            registro.tag = this.tags.filter(t => t.id == registro.idTag)[0];
          }
        })
        .catch(erro => {
          this.registros.carregado = false;
          alert("algo deu errado3");
        });
    },
    setCompartilhamentos(index, registro)
    {
      this.$http
          .get("https://localhost:5001/api/compartilhadoRegistros/"+registro.id)
          .then(dados => {
            this.registros.dados[index].compartilhamentos = dados.body;
            this.$forceUpdate();
          })
          .catch(erro => console.log("Erro:" + erro.text));
    },
    getUsuario(i, id) 
    {
      this.$http
          .get("https://localhost:5001/api/usuarios/" + id)
          .then(dados => { 
            this.registros.dados[i].compartilhamentos.push({
              id: dados.body.id,
              nome: dados.body.nome,
              foto: dados.body.foto
            });
            this.$forceUpdate();
          })
          .catch(erro => console.log("Erro: " + erro.text));
    },
    organizar(vetor)
    {
      if(vetor == null)
        return [];

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
  beforeCreate() 
  {
    if (!this.$session.exists())
      this.$router.push('/')
  },
  created()
  {
    document.title = "Planilhas";

    this.$http
    .get("https://localhost:5001/api/tags")
    .then(dados => {
      this.tags = dados.body;
      this.getRegistros();
    })
    .catch(erro => {
      console.log("Erro ao recuperar tags: " + erro.bodyText);
    });
  },
  mounted() {
    var divs = document.getElementsByClassName("placeholder")[0].children;
    for(let i = 0; i < divs.length; i++)
      divs[i].style.animationDelay = i*150+'ms';
  },
  computed: 
  {
    filtraReg() {
      var ret = this.registros.dados;

      if(this.filtro == "despesa")
        ret = ret.filter(r => r.quantia < 0);

      if(this.filtro == "receita")
        ret = ret.filter(r => r.quantia > 0);

      if(this.filtro_tag)
        ret = ret.filter(r => r.tag.nome == this.filtro_tag);

      if(this.pesquisa)
        ret = ret.filter(r => r.nome.toLowerCase().includes(this.pesquisa.toLowerCase()));
    
      return this.organizar(ret);
    }
  },
};
</script>

<style scoped>
@keyframes pulse {
  50% {
    background: rgba(128, 128, 128, 0.4);
  }
}

.placeholder div {
  animation: pulse 3.5s ease-in-out infinite;
}

.placeholder .dia{
  height: 30px;
  width: 250px;
  background: rgba(128, 128, 128, 0.2);
  border-radius: 5px;
  margin: 15px 0;
}

.dia:first-child{
  width: 250px;
}

.dia:nth-child(1){
  width: 300px !important;
}

.placeholder .registro {
  width: 100%;
  height: 40px;
  background: rgba(128, 128, 128, 0.2);
  margin-bottom: 5px;
}

.placeholder .registro:nth-child(2), .registro:nth-child(6) {
  border-radius: 5px 5px 0 0;
}

.placeholder .registro:nth-child(4), .registro:nth-child(10) {
  border-radius: 0 0 5px 5px;
}

@media only screen and (max-width: 1000px) {
  .filtros {
    flex-wrap: wrap !important;
  }
  .filtros div {
    width: 100%;
  }
  .filtros select {
    width: 50% !important;
  }
  #buscaNome {
    width: 100% !important;
    margin-top: 10px !important;
  }
}

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
  grid-gap: 10px;
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
  grid-gap: 10px;
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