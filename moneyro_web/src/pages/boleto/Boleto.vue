<template>
  <div class="pagBoleto">
    <cabecalho :titulo="'Boleto'"></cabecalho>
    <Mensagem
      :msg="msg"
      v-if="msg.visivel"
      v-on:home="msg.visivel = false, $router.push('/')"
      v-on:fechar="msg.visivel = false"
    ></Mensagem>
    <div id="formBoleto">
      <form v-on:submit.prevent="gerar()" id="formBol">
        <input
          type="email"
          class="campos"
          id="email"
          placeholder="Email"
          maxlength="70"
          v-model="usuario.email"
          required
        />
        
        <input
          type="text"
          class="campos"
          id="cep"
          placeholder="CEP"
          pattern="[0-9]{5}-[0-9]{3}"
          maxlength="70"
          v-model="this.$route.query.cep"
          required
        />

        <div id="cidadeEstado">
          <input
            type="text"
            class="campos"
            id="Cidade"
            placeholder="Cidade"
            v-model="usuario.cidade"
            maxlength="30"
            required
          />

          <select required v-model="usuario.estado">
              <option :value="item" v-for="(item, i) in siglas" :key="i">{{item}}</option>
            </select>
        </div>
        
        <input
          type="text"
          class="campos"
          id="bairro"
          placeholder="Bairro"
          maxlength="70"
          required
          v-model="informacoes.bairro"
        />
        <br />

        <input
          type="text"
          class="campos"
          id="rua"
          placeholder="Rua/Avenida"
          maxlength="70"
          v-model="informacoes.logradouro"
          required
        />
        <br />

         <input
          type="text"
          class="campos"
          id="numero"
          placeholder="Número"
          maxlength="20"
          required
        />
        <input
          type="text"
          class="campos"
          id="complemento"
          placeholder="Complemento (opcional)"
          maxlength="15"             
        />
        <br />

        <br />
        <br />


        <div class="button">
          <button type="submit" class="botoes">Gerar boleto</button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Header from "../shared/cabecalho/Cabecalho.vue";
import Mensagem from "../shared/mensagem/Mensagem.vue";

export default {
  components: {
    cabecalho: Header,
    Mensagem
  },
  data() {
    return {
      informacoes: {
        logradouro: "",
        bairro: ""
      },
      siglas: [],
      msg: {
        visivel: false,
        titulo: "",
        mensagem: "",
        botoes: []
      },
     usuario: {
        id: 0,
        nome: "",
        apelido: "",
        email: "",
        celular: "",
        dataDeNascimento: "",
        foto: 1,
        senha: "",
        cidade: "",
        estado: "",
        modoAnonimo: false,
        notificacoes: false,
        saldo: 0.0,
        professor: false,
        pontos: 0,
        idSala:1,
        cofre: 0.0
      },
    };
  },
  methods: {
    gerar(){
      var carrinho = this.$route.query.carrinho;

      if(carrinho.find(p => p.id == 2)) {
        this.usuario.professor = true;
        this.usuario.idSala = 1;
        this.$session.set("professor", 1);


      this.$http.get("https://localhost:5001/api/usuarios/cmp-prof/" + this.usuario.id)
      .then(
        response => {
          this.msg = {
            visivel: true,
            titulo: "COMPRA REALIZADA COM SUCESSO!",
            mensagem: "Enviamos o boleto ao seu email!",
            botoes: [{
              mensagem: "OK",
              evento: "home"
            }]
          };
        },
        erro => {
          this.msg = {
            visivel: true,
            titulo: "Opa neném",
            mensagem: erro,
            botoes: [{
              mensagem: "Tentar Novamente",
              evento: "fechar"
            }]
          };
        },         
          );
          this.getUsuario();
        }

        if(carrinho.find(p => p.id == 1)) {
        this.usuario.cofre = 0.0;
        this.$session.set("cofre", 0.0);
        alert("entou");

        this.$http.put("https://localhost:5001/api/usuarios/" + this.usuario.id, this.usuario)
      .then(
          response => {
            this.msg = {
            visivel: true,
            titulo: "COMPRA REALIZADA COM SUCESSO!",
            mensagem: "Enviamos o boleto ao seu email!",
            botoes: [{
              mensagem: "OK",
              evento: "home"
            }]
          };
          },
          erro => {
            this.msg = {
              titulo: "Opa neném",
              mensagem: "Algo deu errado ao comprar o cofre",
              botoes: [
              {
               mensagem: "Tentar Novamente",
               evento: "fechar"
              }]
            };
            
            this.getUsuario();
          }
        );

        }


    },
    getUsuario(){
      this.$http
            .get("https://localhost:5001/api/usuarios/" + this.$session.get("id"))
            .then(response => {
              this.usuario = response.body;

              var data = new Date(response.body.dataDeNascimento);

              this.dia = data.getDate();
              this.mes = data.getMonth()+1;
              this.ano = data.getFullYear();
            });
    },
  },
  created() {
    this.getUsuario();

    this.$http
      .get("https://servicodados.ibge.gov.br/api/v1/localidades/estados")
      .then(response => {
        for (var i = 0; i < response.body.length; i++)
          this.siglas.push(response.body[i].sigla);
      });

    var cep = this.$route.query.cep.replace("-", "");

    this.$http
    .get("https://viacep.com.br/ws/" + cep + "/json/")
    .then(response => {
      this.informacoes = response.body;
    });

    document.title = "Boleto";
  }
};
</script>

<style scoped>

.pagBoleto {
  background-color: rgb(11, 83, 148);
}

#cidadeEstado {
  display: flex;
}

.labels {
  color: white;
}

select {
  background-color: whitesmoke;
  border-radius: 5px;
  border: 1px solid gray;
  margin: 5px 0 5px 0;
  padding: 8px 15px;
  float: right;
  font-size: 1em;
}

.campos {
  font-size: 1.2em;
  background-color: whitesmoke;
  border-radius: 5px;
  border: 1px solid gray;
  width: 100%;
  margin: 5px 0px 5px 0px;
  padding: 8px 15px;
  box-sizing: border-box;
}

.botoes {
  font-size: 20px;
  background-color: rgba(0, 0, 0, 0.2);
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
  border-radius: 3px;
}

#formBol {
  font-size: 1.1em;
  text-align: start;
  background: rgb(0, 0, 0, 0.2);
  border-radius: 10px;
  width: 35vw;
  padding: 3em;
}

#formBoleto {
  padding: 12% 0px 5%;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>