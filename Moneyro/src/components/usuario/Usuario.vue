<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <div class="centro">
      <div class="inicio">
        <div class="frase">
          <small>Bem-vindah de volta,</small>
          <big>{{nome}}</big> 
        </div>
        <span class="linha"></span>
        <div class="saldo">
          <span class="msg"> 
            Seu saldo é R$ {{saldo}}<br>
            {{msg}}
          </span>
          <img :src="'../../src/images/status' + situacao + '.png'">          
        </div>
      </div>
    </div>
  </div>
</template>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/perfil/Perfil.vue";

export default {
  components: {
    Menu,
    Perfil
  },
  data() {
    return {
      mensagem: false,
      nome: "",
      saldo: 0.0,
      situacao: -1,
      msg:"",
      cor:""
    };
  },
  methods: {
    mudarSituacao(){
      if(this.saldo <= -20)
           this.situacao = 2;

        if(this.saldo <= -200)
          this.situacao = 1;

        if(this.saldo >= 100)
          this.situacao = 4;

        if(this.saldo >= 500)
           this.situacao = 5;
           
        if(this.saldo > -20 && this.saldo <100 )
           this.situacao = 3;

        this.$http
          .get("https://localhost:5001/api/situacoes")
          .then(dados => {
            this.msg = dados.body[(this.situacao-1)].mensagem;
            this.cor = dados.body[(this.situacao-1)].cor;
            
            document.getElementsByClassName("saldo")[0].style.backgroundColor = this.cor;
            //document.getElementsByClassName("gradient-box")[0].background = "linear-gradient(to right, "+this.cor+", "+this.cor+")";
          });
    }
  },
  created() {
    document.title = "Bem-Vindah";
    
    this.$http
        .get("https://localhost:5001/api/usuarios/" + this.$session.get("id"))
        .then(dados => {
          dados = dados.body;
          
          this.nome = dados.nome;
          this.saldo = dados.saldo;
          
          this.mudarSituacao();
        });
  },
   beforeCreate() {
    if (!this.$session.exists()) {
      this.$router.push('/')
    }
  }
};
</script>

<style scoped>
*{
  color: whitesmoke;
}

.msg{
  margin:auto;
}

img{
  margin:4px;
  height:80%;
}

.frase{
  font-size: 3em;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  padding: 15px 20px;
  background: #f5f5f517;
  border-radius: 5px;
}

small{
  font-size: 0.5em;
}

.inicio {
  /* background: red; */
  display: flex;
  flex-direction: column;
}

.linha {
  background: rgba(0, 0, 0, 0.9);
  height: 1px;
  width: 100%;
  margin: 10px 0 10px;
}

.saldo {
  display: inline-flex;
  justify-content: space-around;
  align-items: center;
  background: transparent;
  border-radius: 5px;
  position: relative;
  font-weight: 700;
  font-size: 2em;
}
/* -------------------------- */
/* .gradient-box::before{
  content: '';
  position: absolute;
  top: 0; right: 0; bottom: 0; left: 0;
  z-index: -1;
  margin: border; /* !importanté 
  border-radius: inherit; /* !importanté igualité fraternité liberté
  background: linear-gradient(to right, red, orange);
}

.gradient-box{
    position: relative;
    box-sizing: border-box;
    border: 5px solid white;
    background-clip: padding-box; /* !importanté 
} */
</style>
 /* .gradient-box {
  
  display: flex;
  align-items: center;
  width: 50vw;
  width: 90%;
  margin: auto;
  max-width: 22em;

  position: relative;
  padding: 30% 2em;
  box-sizing: border-box;

  $border: 5px;
  color: #FFF;
  background: #000;
  background-clip: padding-box; /* !importanté 
  border: solid $border transparent; /* !importanté 
  border-radius: 1em;

  &:before {
    content: '';
    position: absolute;
    top: 0; right: 0; bottom: 0; left: 0;
    z-index: -1;
    margin: -$border; /* !importanté 
    border-radius: inherit; /* !importanté 
    background: linear-gradient(to right, red, orange);
  }
} */