<template>
  <div class="pag">
    <Menu />
    <div class="centro">
      <div>
        <h3 class="pts"> Seus pontos: 10 </h3>
      </div>
      <h1 id="titulo"> Conquistas </h1>
      <div class="conquistas">
        <div class="conquista" v-for="conquista in conquistas"> 
          <img src="../../images/perfil11.png"> 
          <div class="descricao">
            <p><b>{{conquista.nome}}</b></p>
            <p>{{conquista.descricao}}</p>
            <div class="progresso">
              <div class="porcentagem">
                <div class="numero">
                  {{conquista.feito}}/{{conquista.total}}
                </div>
              </div>
              <div :style="'width:' + (conquista.feito/conquista.total*100) + '%'" class="progresso-barra"></div>
            </div>
          </div> 
        </div>
      </div>
      
      <h1> Já Adquiridos </h1>
      <div class="conquistas">
        <div class="conquista" v-for="feito in feitos"> 
          <img src="../../images/perfil10.png"> 
          <div class="descricao">
            <p><b>{{feito.nome}}</b></p>
            <p>{{feito.descricao}}</p>
            <div class="progresso">
              <div class="porcentagem">
                  {{feito.feito}}/{{feito.total}}
                </div>
              <div :style="'width:100%'" class="progresso-barra concluido"></div>
            </div>
          </div> 
        </div>
      </div>

      <h1> Troca de Pontos </h1>
      <div class="conteudo">
        <div class="quadrado">
          <img src="../../images/status4.png">
          <p class="infotroca">10 coins </p>
          <p class="infotroca">30 pontos </p>
          <button class="btncompra">Comprar</button>
        </div>
        <div class="quadrado">
          <img src="../../images/jogo.png">
          <p class="infotroca">Liberar The Game </p>
          <p class="infotroca">5 pontos </p>
          <button class="btncompra">Comprar</button>
        </div>
        <div class="quadrado">
          <img src="../../images/perfil4.png">
          <p class="infotroca"> Perfil Apaixonado </p>
          <p class="infotroca">20 pontos </p>
          <button class="btncompra">Comprar</button>
        </div>
        <div class="quadrado">
          <img src="../../images/perfil5.png">
          <p class="infotroca">Perfil Chiq </p>
          <p class="infotroca">20 pontos </p>
          <button class="btncompra">Comprar</button>
        </div>
        <div class="quadrado">
          <img src="../../images/perfil6.png">
          <p class="infotroca"> Perfil Caipira </p>
          <p class="infotroca">20 pontos </p>
          <button class="btncompra">Comprar</button>
        </div>
        <div class="quadrado">
          <img src="../../images/perfil7.png">
          <p class="infotroca">Perfil Guei </p>
          <p class="infotroca">20 pontos </p>
          <button class="btncompra">Comprar</button>
        </div>
        <div class="quadrado">
          <img src="../../images/perfil9.png">
          <p class="infotroca">Perfil Brabo </p>
          <p class="infotroca">20 pontos </p>
          <button class="btncompra">Comprar</button>
        </div>
        <div class="quadrado">
          <img src="../../images/perfil10.png">
          <p class="infotroca"> Perfil E-grilo </p>
          <p class="infotroca">20 pontos </p>
          <button class="btncompra">Comprar</button>
        </div>
        <div class="quadrado">
          <img src="../../images/perfil11.png">
          <p class="infotroca">Perfil Pepinha </p>
          <p class="infotroca">20 pontos </p>
          <button class="btncompra">Comprar</button>
        </div>
        <div class="quadrado">
          <img src="../../images/perfil8.png">
          <p class="infotroca"> Perfil Estrela </p>
          <p class="infotroca">2 pontos </p>
          <button class="btncompra">Comprar</button>
        </div>
        <div class="quadrado">
          <img src="../../images/perfil12.png">
          <p class="infotroca"> Perfil Brazil </p>
          <p class="infotroca">2 pontos </p>
          <button class="btncompra">Comprar</button>
        </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Menu from "../shared/menu/Menu.vue";

export default {
  components: {
    Menu
  },
  data() {
    return {
      conquistas: [
        {
          nome: "Ai como eu to organizadah",
          descricao: "Faça 15 registros",
          feito: 5,
          total: 15,
        },
        {
          nome: "Entrando na linha",
          descricao: "Faça 30 registros",
          feito: 5,
          total: 30,
        },
        {
          nome: "Ai como eu to organizadah",
          descricao: "Faça 15 registros",
          feito: 3,
          total: 15,
        },
        {
          nome: "Popularidade a mil",
          descricao: "Tenha 10 amigos",
          feito: 8,
          total: 10
        },
        {
          nome: "Rumo ao desejado",
          descricao: "Complete 5 metas",
          feito: 2,
          total: 5
        },
        {
          nome: "Mestre milho o nariah",
          descricao: "Conquiste a fortuna de 1 milhão de reais",
          feito: 125000,
          total: 1000000
        }
      ],
    feitos: [
        {
          nome: "Rumo ao desejado",
          descricao: "Complete 5 metas",
          feito: 5,
          total: 5
        },
        {
          nome: "Mestre milho o nariah",
          descricao: "Conquiste a fortuna de 1 milhão de reais",
          feito: 10,
          total: 10
        }
      ],
    };
  },
  methods: {
    
  },
  created() {
    document.title = "Pontos";
    
  },
   beforeCreate() {
    if (!this.$session.exists()) {
      this.$router.push('/')
    }
  }
};
</script>

<style scoped>
/*
.pag{
  padding: 15px 10vw;
  color: white;
}
*/
.pts{
  float:right;
  margin:0;
}

.conquistas {
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-gap: 10px;
}

.conquista {
  background-color: #303030;
  display: flex;
  flex-direction:row;
  box-sizing: boder-box;
  padding: 1%;
  padding-bottom:1.5%;
  border-radius: 5px;
}

.conquista p {
  padding: 0;
  margin: 0;
}

.conquista img {
  width: 60px;
  height: 60px; 
  margin: 8px 5px 5px 6px;
  border-radius:5px;
}

.descricao {
  flex: 1;
  padding: 0px 10px;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
}

.progresso {
  margin-top:1%;
  position: relative;
  overflow: hidden;
  height: 18px;
  border-radius: 5px;
  background: #202020;
}

.progresso-barra {
  position: absolute;
  top: 0;
  left: 0;
  height: 25px;
  background-color: rgba(241, 174, 30, 0.863);
  border-radius: 2px;
}

.porcentagem {
  position: absolute;
  top: -15%;
  left: 45%; 
  display: flex;
  z-index:9;
  color: #ffffff96
}

.numero {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100px;
  background: red;
}

.coroa::selection {
  user-select: none;
}

.coroa {
  transform: rotate(45deg);
  font-size: 45px;
  position: absolute;
  top: -35px;
  right: -35px;
}

.centro {
  display: flex;
  flex-direction: column;
  justify-content: stretch;
  color: white;
}

.conteudo {
  display: flex;
  overflow-x: scroll;
  justify-content: space-between;
  background-color: #303030;
  padding: 2%;
  border-radius: 20px;
}
    
.retangulo img{
  width: 100%;
  border-radius: 20px;
}

#titulo{
    margin-top:0;
}


/*------------TROCA DE PONTOS---------------*/

.quadrado img {
    width: 170px;
    border-radius: 20px;
    border-right: 4px solid #00000050;
    border-bottom: 4px solid #00000050;
}

.quadrado{
    cursor: pointer;
    position: relative;
    width:fit-content;
    margin:2%;
    text-align:center;
}

.infotroca{
    margin: 5px;
    font-size: 1.3em;
}

.btncompra{
    border: 0;
    border-radius: 5px;
    font-size: 1.2em;
    border: none;
    width: 90%;
    color: white;
    background-color: rgba(241, 174, 30, 0.863);
    border-radius: 13px;
    cursor: pointer;
    font-weight: 600;
    padding: 7px;
    text-align: center;
    margin: 3% auto;
}

/* scroll */

.conteudo::-webkit-scrollbar {
  width: 5px;
  background: transparent;
}

.conteudo::-webkit-scrollbar-thumb {
  border-radius: 10px;
  background: rgba(87, 86, 86, 0.637);
}

.conteudo::-webkit-scrollbar-arrow {
  color: white;
  background: yellowgreen;
}
</style>