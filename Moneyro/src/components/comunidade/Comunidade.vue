<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <div class="centro">comunity</div>
  </div>
</template>

<script>
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/float-perfil/Float-Perfil.vue";

export default {
  components: {
    Menu,
    Perfil
  },
  data() {
    return {};
  }
};
</script>

<style scoped>
</style>
