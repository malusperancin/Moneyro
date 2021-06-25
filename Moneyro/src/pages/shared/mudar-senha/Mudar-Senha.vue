<template>
  <div class="modal">
      <form class="modal-conteudo animate width-30">
          <div class="cima">
                <big>
                   <b>Altere sua senha</b>
                </big>
              <span class="fechar" v-on:click="$emit('fechar')">&times;</span>
          </div>
          <div class="corpo">
                <input required type="password" max="20" class="campos" placeholder="Senha atual" v-model="senha0" >
                <input required type="password" max="20" class="campos" placeholder="Nova senha" v-model="senha1" >
                <input required type="password" max="20" class="campos" placeholder="Repita a senha nova" v-model="senha2" >   
          </div>
          <div class="baixo">
              {{erro}}
              <span v-on:click="mudarSenha" class="botao">Mudar</span>
          </div>
      </form>
  </div>
</template>

<script>
export default {
    data(){
        return{
            erro: "",
            senha0: "",
            senha1: "",
            senha2: "",
            usuario:{
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
                saldo: 0.0
            }
        }
    },
    methods: {
        mudarSenha(){
            if(this.senha1 != this.senha2)
            {
                this.erro = "As senhas novas não conhecidem!";
                return;
            }

            if(this.usuario.senha != this.senha0)
            {
                this.erro = "Senha atual incorreta";
                return;
            }

            this.usuario.senha = this.senha2;
            
            this.$http
            .put("https://localhost:5001/api/usuarios/1", this.usuario)
            .then(
                response => {
                    this.$emit("sucesso");
                },response => {
                    this.$emit("erro");
                });
            }
        },
    created(){
        this.$http
            .get("https://localhost:5001/api/usuarios/" + this.$session.get("id"))
            .then(response => {
              this.usuario = response.body;
            });
    }
}
</script>

<style scoped src="../../../css/modal.css"></style>
<style scoped>
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

.botao{
    background-color: rgba(11, 84, 148, 0.829);
  font-size: 18px;
  color: white;
  padding: 8px 14px;
  border: none;
  cursor: pointer;
  border-radius: 3px;
}

</style>