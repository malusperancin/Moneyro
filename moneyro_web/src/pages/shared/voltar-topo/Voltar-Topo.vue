<template>
  <div>
    <button v-on:click="topFunction" id="botao" title="Ir para o topo da pagina">🎈</button>
  </div>
</template>

<script>
export default {
  data() {
    return {};
  },
  methods: {
    topFunction() {
      document.body.scrollTop = 0;
      document.documentElement.scrollTop = 0;
    }
  },
  mounted() {
    var mybutton = document.getElementById("botao");

    window.onscroll = function scrollFunction() {
      if (
        document.body.scrollTop > 20 ||
        document.documentElement.scrollTop > 20
      )
        mybutton.style.display = "block";
      else mybutton.style.display = "none";
    };
  }
};
</script>

<style scoped>
#botao {
  display: none;
  position: fixed;
  bottom: 20px;
  right: 30px;
  z-index: 50;
  font-size: 1.6em;
  border: none;
  outline: none;
  background-color: rgb(142, 142, 238);
  cursor: pointer;
  padding: 12px;
  height: 60px;
  width: 60px;
  border-radius: 87px;
  -webkit-animation: animatezoom 0.3s;
  animation: animatezoom 0.3s;
}

@-webkit-keyframes animatezoom {
  from {
    -webkit-transform: scale(0);
  }
  to {
    -webkit-transform: scale(1);
  }
}

@keyframes animatezoom {
  from {
    transform: scale(0);
  }
  to {
    transform: scale(1);
  }
}

#botao:hover {
  background-color: rgb(245, 65, 101);
}
</style>