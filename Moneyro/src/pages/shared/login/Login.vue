<template>
  <div class="modal">
    <form class="modal-conteudo animate width-25" v-on:submit.prevent="logar">
      <div class="cima">
        <p>Login</p>
        <span v-on:click="$emit('fechar')" class="fechar" title="Fechar login">&times;</span>
      </div>
      <div class="corpo">
        <input type="text" name="apelido" placeholder="Apelido" required v-model="apelido" />
        <input type="password" name="senha" placeholder="Senha" required v-model="senha" />

        <button class="btnlogin" type="submit">Login</button>
        <div id="erro">{{erro}}</div>
      </div>
      <div class="baixo">
        <button type="button" v-on:click="$emit('login')" class="btncancelar">Cancelar</button>
        <span class="psw">
          Esqueceu a
          <a href="#">Senha?</a>
        </span>
      </div>
    </form>
  </div>
</template>

<script>

export default {
  data() {
    return {
      apelido: "",
      senha: "",
      erro: ""
    };
  },
  methods: {
    logar() {
      this.$http
          .post("https://localhost:5001/api/usuarios/login", {
            apelido: this.apelido,
            senha: this.senha
          })
          .then(response => {
              if (response.status === 200 && "id" in response.body) {
                this.$session.start();
                this.$session.set("usuario", response.body);
                this.$session.set("id", response.body.id);
                this.$session.set("MA", response.body.modoAnonimo);
                this.$session.set("nome", response.body.nome);
                this.$session.set("foto", response.body.foto);
                this.$session.set("professor", response.body.professor);
                this.$session.set("idSala", response.body.idSala);
                this.$session.set("pontos", response.body.pontos);
                this.$http.headers.common["Authorization"] = "Bearer " + response.body.id;
              
                this.$router.go()
              }
            })
          .catch(err => this.erro = err.body);
    }
  }
};
</script>

<style scoped src="../../../css/modal.css"></style>
<style scoped>
.psw {
  color: black;
}

#erro {
  margin: 5px 0;
  font-weight: 1000;
  color: #f44336;
}

.baixo {
  justify-content: space-between;
}

.baixo span, .baixo button{
  margin: 0;
}

input[type="text"],
input[type="password"] {
  border-radius: 3px;
  width: 100%;
  padding: 8px 14px;
  border: 1px solid #ccc;
  box-sizing: border-box;
  font-size: 20px;
}

.corpo {
  display: flex;
  flex-direction: column;
  grid-gap: 15px;
  color: black;
  padding-top: 40px;
}

.btnlogin {
  background-color: rgb(12, 65, 111);
  font-size: 18px;
  color: white;
  padding: 8px 14px;
  margin: 8px 0 0px;
  border: none;
  cursor: pointer;
  width: 100%;
  border-radius: 3px;
}

.btncancelar {
  background-color: rgba(255, 0, 0, 0.5);
  font-size: 18px;
  color: white;
  padding: 8px 14px;
  border: none;
  cursor: pointer;
  border-radius: 3px;
}

.btnlogin:hover {
  opacity: 0.9;
}

.btncancelar:hover {
  background: red;
}

.cima {
  color: black;
}

.cima p {
  padding: 0 10px;
  font-size: 2em;
  margin: 0;
  font-weight: bold;
}
</style>