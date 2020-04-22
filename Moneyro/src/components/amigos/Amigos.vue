<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <div class="centro">
      <span id="busca">
        <input
          type="search"
          class="filtro"
          placeholder="Filtre pelo Nome do Amigo"
          v-model="filtro"
        />
        <button id="btnAdd">
          <img id="imgAdd" src="../../images/adicAmigo.png" />
        </button>
      </span>
      <br />
      <ul id="lista-alunos">
        <li id="lista-alunos-item" v-for="amigo of filtraNome" :key="amigo.nome">
          <Painel :nome="amigo.nome" :foto="amigo.foto"></Painel>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import Painel from "../shared/amigo/Amigo.vue";
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/float-perfil/Float-Perfil.vue";

export default {
  components: {
    Menu,
    Painel,
    Perfil
  },
  data() {
    return {
      filtro: "",
      amigos: [
        // 💩👺💩
        { nome: "jovana ಥ‿ಥ✌", foto: "11" },
        { nome: "maru✌ʕ•́ᴥ•̀ʔっ", foto: "6" },
        { nome: "venizius😘😎", foto: "7" },
        { nome: "drigo", foto: "9" },
        { nome: "illy", foto: "10" },
        { nome: "zoen", foto: "5" }
      ]
    };
  },
  computed: {
    filtraNome() {
      if (this.filtroNome) {
        let exp = new RegExp(this.filtroNome.trim(), "i");
        return this.amigos.filter(amigo => exp.test(amigo.nome));
      } else {
        return this.amigos;
      }
    }

    // methods: {}
  }
};
</script>

<style scoped>
#busca {
  padding: 0px;
  margin: 0;
}
#lista-alunos {
  list-style: none;
  width: 100%;
}

#lista-alunos #lista-alunos-item {
  display: inline-block;
  margin: 1%;
}

#busca {
  margin-left: 22%;
}

.filtro {
  font-size: 1em;
  width: 50%;
  /* margin-top: 12px; */
  padding: 7px 14px;
  border: 0px;
  border-radius: 5px;
  color: black;
  background: rgba(0, 0, 0, 0.1);
}

/* #btnAdd {
  border: none;
  width: 50px;
  height: 50px;
  color: black;
  border-radius: 50px;
  background-color: rgb(11, 83, 148);
  /* margin: auto; 
  cursor: pointer;
  /* margin: 10px 0 -15px 10px; 
} */
#btnAdd {
  width: 50px;
  height: 50px;
  border-radius: 50px;
  background-color: rgb(11, 83, 148);
  border: none;
  margin-left: 10px;
  /* margin-top: 20px; */
}

#imgAdd {
  width: 100%;
}

::-webkit-input-placeholder {
  color: rgb(47, 49, 51);
}
</style>