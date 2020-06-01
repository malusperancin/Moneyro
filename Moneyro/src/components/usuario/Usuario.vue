<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <div class="centro">
      <div id="texto">
        <p>Bem-vindo(a) de volta {{usuario.nome}}</p>
        <h1>Seu saldo é R$ {{usuario.saldo}}</h1>
        <h4>
          {{msg}}
          <br />
        </h4>
      </div>
    </div>
  </div>
</template>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/perfil/Perfil.vue";
import Mensagem from "../shared/mensagem/Mensagem.vue";

export default {
  components: {
    Menu,
    Perfil,
    mensagem: Mensagem
  },
  data() {
    return {
      mensagem: false,
      situacao: 0,
      usuario: {
        id: -1,
        nome: "",
        saldo: 0.0
      },
      text: ""
    };
  },
  created() {
    this.$http
      .get("https://localhost:5001/api/usuarios/" + this.$session.get("id"))
      .then(dados => {
        dados = dados.body;
        this.usuario.id = dados.id;
        this.usuario.nome = dados.nome;
        this.usuario.saldo = dados.saldo;
      });

    document.title = "Bem-Vindah"; 

    if(this.usuario.saldo <= -200)
      this.situacao = 1;
      else
        if(this.usuario.saldo <= -100)
          this.situacao = 2;
          else
            if(this.usuario.saldo >= -10 && this.usuario.saldo <=10 )
              this.situacao = 3;
            else
              if(this.usuario.saldo >= 100)
                this.situacao = 4;
                else
                  if(this.usuario.saldo >= 500)
                    this.situacao = 5;
    //document.getElementsByClassName("pag").style.background = "src/images/status" + this.situacao+".png";
    
    this.$http
      .get("https://localhost:5001/api/situacoes/" + this.situacao)
      .then(dados => {
        this.msg = response.body.mensagem;
      }
      );
    
  },
   beforeCreate() {
    if (!this.$session.exists()) {
      this.$router.push('/')
    }
  },
};
</script>

<style scoped>
#texto {
  margin: auto;
  text-align: center;
}
#texto p {
  margin-top: 10%;
  margin-bottom: 50px;
}
</style>