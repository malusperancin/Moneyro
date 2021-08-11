<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <div class="centro">
      <div class="inicio">
        <div class="frase">
          <div class="horizontal">
            <small>Bem-vinda(o) de volta,</small>
            <big>{{nome}}</big> 
          </div>
          <div class="cofre" v-if="this.has" >
              <small>Cofre:</small>
              <span>{{(Math.abs(cofre)).toLocaleString('pt-BR', {style: 'currency', currency: 'BRL'})}}</span>
          </div>
        </div>
        <span class="linha"></span>
        <div class="saldo">
          <span class="msg">
          <b>Seu saldo é R$ {{saldo}}</b>
          <br><br>

            {{msg}}
          </span>
          <img v-if="situacao > -1" :src="'../../src/images/status' + situacao + '.png'">          
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
      cor:"",
      cofre:0.0,
      has: false
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
        });
    }
  },
  created() {
    document.title = "Bem-Vindah";
    
    this.$http
        .get("https://localhost:5001/api/usuarios/" + this.$session.get("id"))
        .then(dados => {
          dados = dados.body;

          if( dados.cofre == -1.0)
            this.has = false;
          else
          {
            this.has = true;
            this.cofre = dados.cofre;
          } 


          this.nome = dados.nome;
          this.saldo = Math.floor(dados.saldo*100)/100;
          
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
.msg{
  text-align: center;
  margin:auto;
  padding-right:3%;
  padding-left:6%;
}

img{
  margin:4px;
  height:80%;
  margin:3%;
}

.frase{
  font-size: 3em;
  display: flex;
  justify-content: space-between;
  box-sizing: border-box;
  background: #f5f5f517;
  border-radius: 5px;
  color: whitesmoke;
  flex-wrap: wrap;
}

.horizontal {
  display: flex;
  flex-direction: column;
  padding: 15px 35px;
}

.cofre {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  background: #404040;
  padding: 0 30px 0 40px;
  border-radius: 15px 0 0 15px;
}

.cofre span, .cofre small{
  padding: 0;
  margin: 0;
}

.cofre small {
  padding: 15px 0 0;
}

.cofre span{
  font-size: 1.1em;
  font-weight: 600;
}

small{
  font-size: 0.5em;
}

.inicio {
  /* background: red; */
  display: flex;
  flex-direction: column;
   /*display: inline-flex; */
}

.linha {
  background: transparent;
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
  font-size: 2em;
  margin-top:-10px;
  color: whitesmoke;
  padding: 30px 5px;
}

.saldo img{
  width: 50%;
}
</style>