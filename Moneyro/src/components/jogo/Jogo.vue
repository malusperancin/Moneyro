<template>
    <div class="pag">
      <Cabecalho :titulo="'The Game'" />
      <Menu />
      <div class="centro">
        <div class="relativo">
            <canvas id="canvas">

            </canvas>
            <div class="direita">
                <button v-on:click="fullscreen()" title="Tela cheia">
                    <ion-icon name="scan-circle-sharp"></ion-icon>
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
      }

  },
  created() {

  },
   beforeCreate() {
  }
};
</script>

<style scoped>
.centro {
  display: flex;
  flex-direction: column;
  padding: 10% 16%;
}

.relativo {
  position: relative;
}

canvas{
    background-color:gray;
    width:100%;
    /* border:2px solid #000000; */
    height:100%;
}

.direita{
    display: flex;
    justify-content: flex-end;
    position: absolute;
    bottom: 10px;
    right: 0;
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