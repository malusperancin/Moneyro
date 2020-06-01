<template>
  <div class="modal">
      <form v-on:submit.prevent="mudarSenha" class="modal-conteudo animate width-30">
          <div class="cima">
              Mude sua senha {{usuario.senha}} {{senha1}} {{senha2}}
              <span class="fechar" v-on:click="$emit('fechar')">&times;</span>
          </div>
          <div class="corpo">
                <input required type="text" class="campos" placeholder="Senha atual" v-model="senha0">
                <input required type="text" class="campos" placeholder="Nova senha" v-model="senha1">
                <input required type="text" class="campos" placeholder="Repita a senha nova" v-model="senha2">   
          </div>
          <div class="baixo">
              {{erro}}
              {{usuario}}
              <button type="submit">Mudar</button>
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
            
            this.$http
            .put("https://localhost:5001/api/usuarios/" + this.$session.get("id"), this.usuario
            )
            .then(response => {
                alert("atualizou");
              this.usuario = response.body;

              var data = new Date(response.body.dataDeNascimento);
              this.dia = data.getDate();
              this.mes = data.getMonth();
              this.ano = data.getFullYear();
              // fazer os emit lá
              this.$emit("senhaAlterada");
            },
                //fazer emite q deu errado
                 alert("NAO atualizou")
            );

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

<style src="../../../css/modal.css"></style>
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

</style>