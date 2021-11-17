<template>
    <div class="pag">
      <Cabecalho :titulo="'The Game'" />
      <Menu />
      <div class="centro">
        <div class="relativo">
          <iframe id="canvas" src="https://i.simmer.io/@giovannaPavani/eba" style="width:960px;height:600px;border:0"></iframe>
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
import Unity from 'vue-unity-webgl';

export default {
  components: {
    Cabecalho,
    Unity,
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
  },
  mounted() {

  },
   beforeCreate() {
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
  position: relative;
}

canvas{
    background-color:#1E529F;
    z-index: -1;
    margin: auto;
}

.direita{
    display: flex;
    justify-content: flex-end;
     position: absolute;
    bottom: 10px;
    right: 0;
    border-radius: 25px;
    z-index:9999;
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