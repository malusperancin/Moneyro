<template>
    <div class="comunicado">
        <div class="conteudo">
            <div class="infos">
                <img src="../../../images/perfil2.png">
                <div class="textos">
                    <strong><b>{{professor.nome}}</b></strong>
                    <small>{{comunicado.data}}</small>
                </div>
            </div>
            <div class="texto">
                {{comunicado.texto}}
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
  data() {
    return {
      sala:{
        nome: "Sala da Maria Luzia",
        codigo: "x5f7h6"
      },
      professor: {
        nome: "Maria Luzia", 
      },
      comunicado: {
        texto: "Pessoal, boa noite.Amanhã não conseguirei dar aulas, pois tenho vacina agendada para o horário das aulas. Então, nossa aula será assíncrona, através da leitura do material que estou adicionando a esta mensagem.",
        data: "12/02/2004"
      },
   };
  },
  methods: {
    
  },
  computed: {
    
  },
  created() {
   
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
  width: 50%;
  font-size:1.5em;
}

.textos {
  display: flex;
  flex-direction: column;
  margin-left: 4%;
}

img {
    border-radius: 8px;
    width: 75px;
    height: 75px;
}

p {
    margin: 0;
    color: white;
    padding: 3px;
}

.comunicado {
    height: 100%;
    width: 80%;
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
    font-size: 1.5em;
}

.texto {
    padding: 1%;
    font-size:1.5em;
}

.divi {
    width: 100%;
    height: 1px;
    background: rgba(0, 0, 0, 0.5);
    margin: 1% 0 1.5%;
}
</style>
