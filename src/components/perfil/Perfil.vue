<template>
  <div class="pag">
    <div id="deskTop">
      <span id="addCard" v-on:click="addCard()">
        <div class="cardContent">
          <p>Adicionar card</p>
        </div>
      </span>
      <span class="card" v-on:click="openCard(this)">
        <div class="cardContent">
          <div class="cardHeader">Nome</div>
          <div class="cardDesc">Descrição breve sobre lorem ipsun iderum itemiro adapare dorime</div>
        </div>
      </span>
    </div>
    <span id="blackBack">
      <div id="opennedCard">
        <span id="close" v-on:click="fecharCard('close')"></span>
        <span id="save" v-on:click="fecharCard('save')"></span>
        <form>
          <div class="tipos">
            <input type="radio" id="disp" name="tipo" value="dispensa" checked />
            <label for="disp">Dispesa</label>
            <input type="radio" id="rend" name="tipo" value="renda" />
            <label for="rend">Renda</label>
          </div>
          <input placeholder="Nome" type="text" id="nome" />
        </form>
      </div>
    </span>
  </div>
</template>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
import $ from "jquery";

export default {
  methods: {
    addCard: function() {
      $("#blackBack").css("display", "block");
    },
    openCard: function(span) {
      $("#blackBack").css("display", "block");
    },
    fecharCard: function(param) {
      $("#blackBack").css("display", "none");

      if (param == "save") {
        var card = `<span class="card" v-on:click="addCard(this)">
                          <div class="cardContent">
                              <div class="cardHeader">Nome</div>
                              <div class="cardDesc">Descrição breve sobre lorem ipsun iderum itemiro adapare dorime</div>
                          </div>
                      </span>`;
      }

      $("#deskTop").append(card);
    }
  }
};
</script>

<style>
.tipos {
  display: flex;
  overflow: hidden;
}

.tipos input {
  position: absolute !important;
  clip: rect(0, 0, 0, 0);
  height: 1px;
  width: 1px;
  border: 0;
  overflow: hidden;
}

.tipos label {
  background-color: #e4e4e4;
  color: black;
  font-size: 1;
  line-height: 1;
  text-align: center;
  padding: 12px 20px;
  margin-right: -1px;
}

.tipos label:hover {
  cursor: pointer;
}

.tipos input:checked + label {
  background-color: #68525859;
  box-shadow: none;
}

.tipos label:first-of-type {
  border-radius: 4px 0 0 4px;
}

.tipos label:last-of-type {
  border-radius: 0 4px 4px 0;
}

#nome {
  border-radius: 5px;
  width: 96%;
  margin-top: 10px;
  border: 0px;
  padding: 7px;
  color: black;
  font-size: 1.5em;
  background: rgba(0, 0, 0, 0.082);
}

#deskTop {
  margin: 15px;
  background: rgba(54, 56, 51, 0.233);
  border-radius: 5px;
  display: inline-block;
  width: 97.5%;
}

#close,
#save {
  background: rgba(255, 0, 0, 0.5);
  height: 20px;
  width: 35px;
  float: right;
  border-radius: 25px;
  text-align: center;
  font-size: 1.4em;
  font-weight: bold;
  cursor: pointer;
}

#save {
  background: rgb(0, 255, 0, 0.5);
  font-size: 1.5em;
  margin-right: 10px;
}

#save:hover {
  background: rgb(0, 255, 0);
}

#close:hover {
  background: rgba(255, 0, 0);
}

.card {
  width: 200px;
  height: 200px;
  border-radius: 5px;
  margin: 15px;
  background: #fff;
  transition: all 0.2s;
  cursor: pointer;
}

#addCard p {
  margin: 2px 16px;
  transition: all 0s;
}

#addCard:hover {
  font-weight: bold;
}

#addCard {
  display: block;
  margin-top: -25px;
  padding: 5px;
  width: 210px;
  height: 50px;
  background: rgb(59, 106, 153);
  color: white;
  cursor: pointer;
  font-size: 1.75em;
  transition: all 0s;
}

.card {
  display: inline-block;
}

.cardDesc {
  margin: 10px;
}

.cardHeader {
  position: static;
  margin: 10px;
  text-align: start;
  font-weight: bold;
  font-size: 1.25em;
}

.cardContent {
  position: relative;
  width: inherit;
  height: inherit;
}

#opennedCard {
  position: fixed;
  top: 10%;
  left: 39.5%;
  border-radius: 5px;
  height: 500px;
  width: 350px;
  background: #fff;
  padding: 15px;
}

#blackBack {
  position: absolute;
  width: 100%;
  height: 100%;
  left: 0;
  top: 0;
  z-index: 1;
  background: rgba(0, 0, 0, 0.342);
  display: none;
}
</style>