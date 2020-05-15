<template>
  <div class="pag">
    <Menu />
    <Perfil />
    <Topo />
    <Mensagem
      v-if="mensagem"
      v-on:ok="mensagem = false"
      mensagem="Receita registrada com sucesso!"
      titulo="Toma o titulo"
      sair="oi"
    ></Mensagem>
    <Add v-if="adicionar" v-on:fechar="adicionar= false"></Add>
    <div class="centro">
      <div id="busca">
        <input class="filtro" type="search" placeholder="Pesquisar" v-model="filtro" />
        <img
          title="Adicionar um amigo"
          id="imgAdd"
          class="icone"
          src="../../images/adicAmigo.png"
          v-on:click="adicionar = true"
        />
      </div>
      <div id="lista-alunos">
        <div id="lista-alunos-item" v-for="amigo of filtraNome" :key="amigo.nome">
          <Painel :nome="amigo.nome" :foto="amigo.foto"></Painel>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Painel from "../shared/amigo/Amigo.vue";
import Menu from "../shared/menu/Menu.vue";
import Perfil from "../shared/float-perfil/Float-Perfil.vue";
import Topo from "../shared/voltar-topo/Voltar-Topo.vue";
import Mensagem from "../shared/mensagem/Mensagem.vue";
import Add from "../shared/adicionar-amigo/Adicionar-Amigo.vue";

export default {
  components: {
    Menu,
    Painel,
    Perfil,
    Topo,
    Mensagem,
    Add
  },
  data() {
    return {
      filtro: "",
      amigos: [
        // 💩👺💩 jovana ಥ‿ಥ✌2345678901
        { nome: "jovana ಥ‿ಥ✌", foto: "11" }, // apelido : varchar(14)
        { nome: "maru✌ʕ•́ᴥ•̀ʔっ", foto: "6" },
        { nome: "venizius😘😎", foto: "7" },
        { nome: "drigo", foto: "9" },
        { nome: "illy", foto: "10" },
        { nome: "zoen", foto: "5" }
      ],
      alunos: [],
      mensagem: false,
      adicionar: false
    };
  },
  computed: {
    filtraNome() {
      if (this.filtro) {
        let exp = new RegExp(this.filtro.trim(), "i");
        return this.amigos.filter(amigo => exp.test(amigo.nome));
      } else {
        return this.amigos;
      }
    }
  }
};
</script>

<style scoped>
.centro {
  margin-left: 7%;
}

#lista-alunos {
  margin-top: 20px;
  list-style: none;
  width: 100%;
}

#lista-alunos #lista-alunos-item {
  display: inline-block;
  margin: 0.5%;
}

#busca {
  display: -ms-flexbox;
  display: inline-flex;
  width: 100%;
  margin-bottom: 15px;
  box-sizing: border-box;
}

.filtro {
  width: 80%;
  padding: 7px 14px;
  outline: none;
  border-radius: 5px;
  border: none;
  font-size: 1.2em;
  background: rgba(0, 0, 0, 0.1);
  box-sizing: border-box;
  margin-right: -8%;
}

.filtro:focus {
  border: 1px solid rgba(5, 0, 0, 0.233);
}

#imgAdd {
  width: 60px;
  margin: auto;
}

.icone {
  cursor: pointer;
  padding: 10px;
  color: white;
  min-width: 50px;
  text-align: center;
  background-color: rgba(36, 107, 170, 0.719);
  border-radius: 87px;
  box-sizing: border-box;
}

.icone:hover {
  background-color: rgb(26, 81, 129);
}

::-webkit-input-placeholder {
  color: rgb(47, 49, 51);
  padding-left: 1%;
}
</style>