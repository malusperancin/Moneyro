<template>
  <div class="corpo">
    <div id="header">
      <div id="menuIcon" v-on:click="openMenu()"></div>

      <span class="Menubar"></span>

      <div id="menuItem">
        <p>ITEM</p>
      </div>

      <div id="menuItem">
        <p>ITEM</p>
      </div>

      <div id="menuItem">
        <p>ITEM</p>
      </div>
    </div>

    <div id="body">
      <div id="subMenu">
        <ul>
          <li v-for="route in routes">
            <router-link :to="route.path ? route.path : '/'">{{ route.titulo }}</router-link>
          </li>
          <li>|</li>
        </ul>
      </div>

      <span class="Bodybar"></span>
      <router-view></router-view>
      <footer>BLABLABLADIREITOSBLABLABLA</footer>
    </div>
  </div>
</template>

 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
var active = false;

//     $("#menuIcon").click(function() {
//         var cab = $("#header");
//         var menu = $("#menuIcon");
//         var btn = $('.btn');

//         if (active) {
//             cab.css("width", "6%");
//             btn.toggleClass('active');
//             btn.toggleClass('not-active');
//             $(".menuItem").fadeOut(250);
//             active = false;

//         } else {
//             cab.css("width", "20%");
//             btn.toggleClass('active');
//             btn.toggleClass('not-active');
//             $(".menuItem").fadeIn(1000);
//             active = true;
//         }
//     });

//     $("#addCard").click(function() {
//         var card = `<span class="card">
//                     <div class="cardContent">
//                         <div class="cardHeader">Nome</div>
//                         <div class="cardDesc">Descrição breve sobre lorem ipsun iderum itemiro adapare dorime</div>
//                     </div>
//                 </span>`;
//         $("#deskTop").append(card);
//     });

//     $("#openCard").click(function() {
//         $("#blackBack").css("display", "none");
//         $(".card").css("background", "#fff");
//     })
// });

// var open = false;

// $(document.body).on('click', ".card", function() {
//     $(this).css("background", "inherit");
//     $("#blackBack").css("display", "block");
// });

import { routes } from "./routes";

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
* {
  margin: 0;
  padding: 0;
  transition: all 0.3s;
  font-family: "Baloo Chettan 2", cursive;
}

#menu {
  background: rgb(153, 105, 105);
}

footer {
  width: 100%;
  bottom: 0;
  left: 0;
  background-color: #275a91;
  text-align: center;
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

.Bodybar {
  width: 100%;
  height: 3px;
  background: white;
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

#body {
  background-color: #3d79b8;
  padding: 20px;
  margin-left: 6%;
  height: 100%;
  position: flex;
}

#subMenu {
  font-size: 1.5em;
  width: 100%;
  height: 70px;
  text-align: end;
  padding-top: 15px;
}

#subMenu ul li {
  display: inline;
  margin: 5px;
  color: white;
}

#subMenu ul {
  list-style: none;
}

#subMenu ul li a:hover {
  color: rgb(235, 199, 199);
}

#subMenu ul li a {
  display: inline-block;
  color: white;
  text-decoration: none;
}
</style>
