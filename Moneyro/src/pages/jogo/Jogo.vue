<template>
    <div class="pag">
      <Cabecalho :titulo="'The Game'" />
      <Menu />
      <div class="centro">
        <div class="relativo">
            <canvas id="canvas" width="1000" height="550">
              Seu browser não tem suporte para o Canvas.
            </canvas>
            <div class="direita">
                <button v-on:click="fullscreen()" title="Tela cheia">
                    <ion-icon name="scan-circle-sharp" v-pre></ion-icon>
                </button>
            </div>
        </div>
      </div>
    </div>
</template>

<script>
import Cabecalho from '../shared/cabecalho/Cabecalho.vue';
import Menu from '../shared/menu/Menu.vue';
export default {
  components: {
    Cabecalho,
    Menu
  },
  data() {
    return {
      vueCanvas: null
    };
  },
  methods: {
      fullscreen(){
          var elem = document.getElementById("canvas");
        if (elem.requestFullscreen) {
            elem.requestFullscreen();
        } else if (elem.webkitRequestFullscreen) { /* Safari */
            elem.webkitRequestFullscreen();
        } else if (elem.msRequestFullscreen) { /* IE11 */
            elem.msRequestFullscreen();
        }
      },
    iniciaJogo() {
CanvasRenderingContext2D.prototype.roundRect = function (x, y, width, height, radius, fill, stroke) {
    var cornerRadius = { upperLeft: 0, upperRight: 0, lowerLeft: 0, lowerRight: 0 };
    if (typeof stroke == "undefined") {
        stroke = true;
    }
    if (typeof radius === "object") {
        for (var side in radius) {
            cornerRadius[side] = radius[side];
        }
    }

    this.beginPath();
    this.moveTo(x + cornerRadius.upperLeft, y);
    this.lineTo(x + width - cornerRadius.upperRight, y);
    this.quadraticCurveTo(x + width, y, x + width, y + cornerRadius.upperRight);
    this.lineTo(x + width, y + height - cornerRadius.lowerRight);
    this.quadraticCurveTo(x + width, y + height, x + width - cornerRadius.lowerRight, y + height);
    this.lineTo(x + cornerRadius.lowerLeft, y + height);
    this.quadraticCurveTo(x, y + height, x, y + height - cornerRadius.lowerLeft);
    this.lineTo(x, y + cornerRadius.upperLeft);
    this.quadraticCurveTo(x, y, x + cornerRadius.upperLeft, y);
    this.closePath();
    if (stroke) {
        this.stroke();
    }
    if (fill) {
        this.fill();
    }
} 
      
        var imgTitulo = new Image();
        imgTitulo.src = "../src/images/jogo/titulo.png";

        this.vueCanvas.beginPath();
        this.vueCanvas.drawImage(imgTitulo, 63, 10, 880, 110);
        this.vueCanvas.closePath();
   
        this.vueCanvas.beginPath();
        this.vueCanvas.fillStyle='orange';
        this.vueCanvas.font = " italic bold 40px Staatliches";
        this.vueCanvas.fillText("Record: 100", 140, 135);
        this.vueCanvas.closePath();
 
        this.vueCanvas.beginPath();
        this.vueCanvas.roundRect(400, 240, 185, 50, {upperLeft:10,upperRight:10, lowerLeft: 10, lowerRight: 10}, true, false);
        this.vueCanvas.fillStyle='black';
        this.vueCanvas.font = " bold 35px Staatliches";
        this.vueCanvas.fillText("Jogar", 450, 278);
        this.vueCanvas.closePath();
        
        this.vueCanvas.beginPath();
        this.vueCanvas.fillStyle='orange';
        this.vueCanvas.roundRect(400, 300, 185, 50, {upperLeft:10,upperRight:10, lowerLeft: 10, lowerRight: 10}, true, false);
        this.vueCanvas.fillStyle='black';
        this.vueCanvas.font = " bold 35px Staatliches";
        this.vueCanvas.fillText("Ajuda", 450, 338);
        this.vueCanvas.closePath();

        this.vueCanvas.beginPath();
        this.vueCanvas.moveTo(35, 500);
        this.vueCanvas.lineTo(955, 500);
        this.vueCanvas.stroke();
        this.vueCanvas.closePath();

        this.vueCanvas.beginPath();
        this.vueCanvas.arc(35, 500, 12, 0, 2*Math.PI, true);
        this.vueCanvas.fill();
        this.vueCanvas.closePath();

        this.vueCanvas.beginPath();
        this.vueCanvas.arc(235, 500, 12, 0, 2*Math.PI, true);
        this.vueCanvas.fill();
        this.vueCanvas.closePath();

        this.vueCanvas.beginPath();
        this.vueCanvas.arc(435, 500, 12, 0, 2*Math.PI, true);
        this.vueCanvas.fill();
        this.vueCanvas.closePath();

        this.vueCanvas.beginPath();
        this.vueCanvas.arc(635, 500, 12, 0, 2*Math.PI, true);
        this.vueCanvas.fill();
        this.vueCanvas.closePath();

        this.vueCanvas.beginPath();
        this.vueCanvas.arc(835, 500, 12, 0, 2*Math.PI, true);
        this.vueCanvas.fill();
        this.vueCanvas.closePath();


        this.vueCanvas.fillStyle='#1E529F';

        this.vueCanvas.beginPath();
        this.vueCanvas.arc(35, 500, 9, 0, 2*Math.PI, true);
        this.vueCanvas.fill();
        this.vueCanvas.closePath();

        this.vueCanvas.beginPath();
        this.vueCanvas.arc(235, 500, 9, 0, 2*Math.PI, true);
        this.vueCanvas.fill();
        this.vueCanvas.closePath();

        this.vueCanvas.beginPath();
        this.vueCanvas.arc(435, 500, 9, 0, 2*Math.PI, true);
        this.vueCanvas.fill();
        this.vueCanvas.closePath();

        this.vueCanvas.beginPath();
        this.vueCanvas.arc(635, 500, 9, 0, 2*Math.PI, true);
        this.vueCanvas.fill();
        this.vueCanvas.closePath();

        this.vueCanvas.beginPath();
        this.vueCanvas.arc(835, 500, 9, 0, 2*Math.PI, true);
        this.vueCanvas.fill();
        this.vueCanvas.closePath();

        this.vueCanvas.fillStyle='black';

        this.vueCanvas.beginPath();
        this.vueCanvas.moveTo(945,515);
        this.vueCanvas.lineTo(945,485);
        this.vueCanvas.lineTo(970,500);
        this.vueCanvas.fill();
        this.vueCanvas.closePath();

    },

    
    desenha(){/*
      //exemplo quadrado
      ctx.beginPath();
      ctx.rect(20,20,150,50);
      ctx.stroke();
      // exemplo circulo
      ctx.arc(70,18,15,0,Math.PI * 2);
      ctx.stroke();*/
    },
  },
    mounted() {

  },
   beforeCreate() {
  },
  mounted(){
      var canvas = document.getElementById("canvas");
      var ctx = canvas.getContext("2d");    
      this.vueCanvas = ctx;
      this.iniciaJogo();
  }
};
</script>

<style scoped>

@import url('https://fonts.googleapis.com/css2?family=Staatliches&display=swap');

.centro {
  display: flex;
  flex-direction: column;
  padding: 10% 16%;
}

.relativo {
  position: fixed;
}

canvas{
    background-color:#1E529F;
    z-index: -1;
    margin: auto;
}

.direita{
    display: flex;
    position: absolute;
    bottom: 15px;
    right: 10px;
    border-radius: 25px;
}

button{
    background:transparent;
    border:0px;
    padding:0;
    border-radius:50%;
    width: 30px;
    height:30px;
    justify-content: center;
    align-items: center;
    display: flex;
}

button:hover{
  background:#10101050
}

button img{
  width: 30px;
}

ion-icon {
    font-size: 8em;
    margin: 0;
    color: white;
}
</style>