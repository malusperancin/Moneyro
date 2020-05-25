<template>
  <div class="modal">
    <form class="modal-content animate" v-on:submit.prevent="logar">
      <div class="imgcontainer">
        <span v-on:click="$emit('fechar')" class="close" title="Close Modal">&times;</span>
      </div>
      <div class="container">
        <label for="uname">
          <b>Apelido</b>
        </label>
        <input type="text" name="nomeusuario" required v-model="apelido" />

        <label for="psw">
          <b>Senha</b>
        </label>
        <input type="password" name="senha" required v-model="senha" />

        <button id="btnlogin" type="submit">
          <router-link style="color: white">Login</router-link>
        </button>
        <div id="erro">{{erro}}</div>
      </div>

      <div class="container" style="background-color:#f1f1f1">
        <button type="button" v-on:click="$emit('fechar')" id="btncancelar">Cancelar</button>
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
    logar: function() {
      this.$http
        .post(
          "https://localhost:5001/api/usuarios/login/" +
            this.apelido +
            "/" +
            this.senha
        )
        .then(
          function(response) {
            if (response.status === 200 && "token" in response.body) {
              this.$session.start();
              this.$session.set("jwt", response.body.token);
              this.$session.set("id", 2);
              Vue.http.headers.common["Authorization"] =
                "Bearer " + response.body.token;
              this.$router.push("/usuario");
            }
          },
          function(err) {
            this.erro = err.bodyText;
          }
        );
    }
  }
};
</script>

<style scoped>
a {
  color: white;
}

#erro {
  font-weight: 1000;
  color: #f44336;
}

input[type="text"],
input[type="password"] {
  border-radius: 3px;
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
}

#btnlogin {
  background-color: rgb(12, 65, 111);
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
  border-radius: 3px;
}

#btnlogin:hover {
  opacity: 0.9;
}

#btncancelar:hover {
  opacity: 0.9;
}

#btncancelar {
  width: auto;
  padding: 10px 18px;
  background-color: #f44336;
  color: white;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  border-radius: 3px;
}

.imgcontainer {
  text-align: center;
  margin: 24px 0 12px 0;
  position: relative;
}

.container {
  padding: 16px;
}

span.psw {
  float: right;
  padding-top: 16px;
}

.modal {
  position: absolute;
  top: 0;
  left: 0;
  display: block;
  position: fixed;
  z-index: 999;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.3);
}

.modal-content {
  background-color: #fefefe;
  margin: 8% auto 10% auto;
  border: 1px solid #888;
  width: 35%;
}

.close {
  position: absolute;
  right: 25px;
  top: 0;
  color: #000;
  font-size: 35px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: red;
  cursor: pointer;
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

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
  span.psw {
    display: block;
    float: none;
  }
  .cancelbtn {
    width: 100%;
  }
}
</style>