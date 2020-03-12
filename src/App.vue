<template>
  <div class="corpo">
    <nav id="menu">
      <div id="menuIcon">
        <img
          src="https://cdn4.iconfinder.com/data/icons/basic-interface-overcolor/512/menu-512.png"
          alt
          width="50"
          id="imgMenuIcon"
          v-on:click="openMenu"
        />
      </div>
      <ul>
        <li v-for="route in routes">
          <router-link :to="route.path ? route.path : '/'">{{route.titulo}}</router-link>
        </li>
      </ul>
    </nav>
    <router-view></router-view>
  </div>
</template>

<script>
import { routes } from "./routes";

export default {
  data() {
    return {
      routes
    };
  },
  methods: {
    openMenu: function(event) {
      var menu = document.getElementById("menu");
      menu.animate();
    }
  }
};
</script>

<style>
#imgMenuIcon {
  margin: auto;
  cursor: pointer;
}

#menuIcon {
  width: 100%;
  padding-left: 50%;
  padding-right: 50%;
}

#menu {
  float: left;
}

.pag {
  background-color: #b8b3b3a9;
}

.corpo {
  background-color: #e2144a;
  height: 100px;
}

#menu {
  margin: 0;
  height: 500px;
  background-color: rgb(107, 132, 179);
  width: fit-content;
}

#menu ul {
  padding: 0px;
  margin: 0px;
  background-color: #ededed;
  list-style: none;
}

#menu ul li {
  display: inline;
}

#menu ul li a {
  padding: 2px 10px;
  display: inline-block;

  /* visual do link */
  background-color: #ededed;
  color: #333;
  text-decoration: none;
  border-bottom: 3px solid #ededed;
}

#menu ul li a:hover {
  background-color: #d6d6d6;
  color: #6d6d6d;
  border-bottom: 3px solid #ea0000;
}
</style>
