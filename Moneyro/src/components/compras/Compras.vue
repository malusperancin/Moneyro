<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <div class="centro">

      <div class="cofre">
          
        <div class="quadrado">
          <div class="titulo">
            <p> Cofre inteligente </p>
          </div>
             <img src="../../images/cofre.png">
            <ul>
                <li>Um cofre muito do bonito</li>
                <li>Conta seu dinheirinho</li>
                <li>Baratinho</li>
                <li>Ligacao com o app</li>
                <li>Nao sei mais</li>
            </ul>
            <button class="botao" v-on:click="comprar('aluno')">Comprar</button>
        </div>
      </div>

      <div class="quadrado">
        <div class="titulo">
          <p> Area do Professor </p>
        </div>
          <img src="../../images/porcoprofessor.png">
            <ul>
              <li>Area para dar aulas</li>
              <li>Muito lefal</li>
              <li>Baratinho</li>
              <li>Ligacao com o app</li>
              <li>Nao sei mais</li>
            </ul>
            <button class="botao" v-on:click="comprar('professor')">Comprar</button>
        </div>
      </div>
    </div>

</template>
    <style scoped>

    .quadrado{
      font-size: 3em;
      display: flex;
      flex-direction: column;
      box-sizing: border-box;
      padding: 15px 20px;
      background: #f5f5f517;
      border-radius: 20px;
      color: whitesmoke;
      margin: 20px;
    }
    
    .titulo{
      font-weight: 700;
      font-size: 80%;
      width:100%;
      margin:0;
      text-align: center;
    }

    p{
      margin:5px 5px 20px; 
      padding:0
    }

    .botao {
      font-size: 0.8em;
      border: none;
      width: 70%;
      color: white;
      background-color: rgba(241, 174, 30, 0.863);
      border-radius: 13px;
      cursor: pointer;
      font-weight: 1000;
      padding: 5px;
      text-align: center;
      margin: auto;
    }

    .centro {
      /*background: red; */
      display: flex;
      flex-direction:inherit;
      margin: auto;
      /* display: inline-flex; */
    }
    
    img {
      width: 300px;
      border-radius: 20px;
      margin: auto;
    }

    li {
      font-size: 50%;
    }
    </style>

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
    comprar(){
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
