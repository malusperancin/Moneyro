<template>
    <div class="comunicado">
        <div class="conteudo">
            <div class="infos">
                <div class="flex">
                    <img src="../../../images/perfil2.png">
                    <div class="textos">
                        <strong><b>{{professor}}</b></strong>
                        <small>{{data}}</small>
                    </div>
                </div>
                <div v-on:click="excluir(comunicado.id)" class="deletar_icone">
                    <ion-icon name="trash"></ion-icon>
                </div>
            </div>
            <div class="texto">
                {{comunicado.descricao}}
            </div>
            <div class="divi"></div>
            <div class="enviar_comentario">
                <img src="../../../images/perfil2.png">  
                <div class="comentario">
                    <input class="input" 
                    type="text"
                    placeholder="Adicionar comentário..."
                    />
                    <ion-icon name="send-outline" class="enviar"></ion-icon>
                </div>
            </div>
        </div>
    </div>
</template>


<script>
export default {
props: ["comunicado", "professor"],
  data() {
    return {
        data: ""
   };
  },
  methods: {
    excluir(id) {
        this.$http
            .delete("https://localhost:5001/api/postagens/"+id)
            .then(
                response => {
                    this.$emit('deletada', id);
                }, 
                erro =>{
                    console.log(erro);
            });
    }
  },
  computed: {
    
  },
  created() {
      var a = new Date(this.comunicado.data);
      var dd = String(a.getDate()).padStart(2, '0');
      var mm = String(a.getMonth() + 1).padStart(2, '0'); //January is 0!
      var yyyy = a.getFullYear();
     
      this.data = dd + '/' + mm + '/' + yyyy;
  },
  watch: {
    expanded(){
      
    }
  },
};

</script>

<style scoped>
.enviar_comentario {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.enviar_comentario img{
    width:50px;
    height:50px;
}

.comentario {
    display: flex;
    height: 90%;
    justify-content: space-between;
    border-radius: 15px;
    width: 95%;
    position: relative;
}

.enviar {
    font-size: 1.75rem;
    color: gray;
    position: absolute;
    top: 7px;
    right: 10px;
}

.enviar:hover {
    color: black;
    cursor: pointer;
}

.input {
    margin-left:5px;
    box-sizing: border-box;
    border-radius: 25px;
    width: 100%;
    padding: 9px 50px 9px 25px;
    outline: none;
    border: transparent;
    font-size:1em;
}

.infos{
  display:flex;
  flex-direction:row;
  justify-content: space-between;
  font-size: 1.2em;
}

.flex {
    display: flex;
    width: 100%;
}

.deletar_icone {
    border: 1px solid grey;
    height: fit-content;
    padding: 5px;
    line-height: 0;
    border-radius: 87px;
    color: grey;
    transition: all 0.1s easy-in !important;
}

.deletar_icone:hover {
    color: white;
    background: rgb(211, 49, 49);
}

.textos {
  display: flex;
  flex-direction: column;
  margin-left: 4%;
}

img {
    border-radius: 8px;
    width: 55px;
    height: 55px;
}

p {
    margin: 0;
    color: white;
    padding: 3px;
}

.comunicado {
    height: 100%;
    align-items: center;
}

.conteudo {
    color: rgb(255, 255, 255);
    background: rgb(46, 48, 46);
    border-radius: 5px;
    height: fit-content;
    min-width: 250px;
    display: flex;
    flex-direction: column;
    box-sizing: border-box;
    padding: 30px;
}

.titulo div {
    display: flex;
    flex-direction: column;
    margin-left: 2%;
}

.titulo {
    display: flex;
    font-size: 1.4em;
}

.texto {
    padding: 1%;
    font-size:1.2em;
}

.divi {
    width: 100%;
    height: 1px;
    background: rgba(0, 0, 0, 0.5);
    margin: 1% 0 1.5%;
}
</style>
