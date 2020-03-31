<template>
  <div class="pag">
    <div id="header">
      <div id="menuIcon" v-on:click="openMenu()"></div>

      <span class="Menubar"></span>

      <div v-for="route in routes">
        <router-link :to="route.path ? route.path : '/'">{{ route.titulo }}</router-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      routes,
      active: false
    };
  },
  methods: {
    openMenu: function() {
      var cab = document.getElementById("header");
      var item = document.getElementById("menuItem");

      if (this.active) {
        cab.style.width = "6%";
        item.style.display = "none";
        this.active = false;
      } else {
        cab.style.width = "20%";
        item.style.display = "block";
        this.active = true;
      }
    }
  }
};
</script>

<style>
#menu {
  background: rgb(153, 105, 105);
}

#menuItem {
  color: white;
  margin-top: 5px;
  padding-left: 10px;
  display: none;
  font-size: 1.5em;
}

.Menubar {
  width: 100%;
  height: 3px;
  align-self: baseline;
  background: #fff;
}

#menuIcon {
  width: 100%;
  height: 105px;
  background: #f5ba30;
}

#menuIcon:hover {
  cursor: pointer;
}

#header {
  width: 6%;
  background-color: #e2aa33;
  position: fixed;
  height: 100%;
  transition: width 0.7s;
  z-index: 5;
}
</style>