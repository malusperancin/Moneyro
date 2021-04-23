<template>
    <div class="comunicado">
        <div class="conteudo">
            <div class="titulo">
                <img src="../../../images/perfil2.png" style="width: 50px">
                <div>
                    <strong><b>{{professor.nome}}</b></strong>
                    <strong><b>{{comunicado.data}}</b></strong>
                </div>
            </div>
            <div class="texto">
                {{comunicado.texto}}
            </div>
            <div class="divi"></div>
            <div class="enviar_comentario">
                <img src="../../../images/perfil2.png" style="width: 50px">  
                <div class="comentario">
                    <input class="input" 
                    type="text"
                    placeholder="Adicionar comentário..."
                    />
                    <ion-icon name="send-outline" class="enviar" v-on:click=""></ion-icon>
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

.enviar {
    font-size: 1.75rem;
    color: gray;
    background: white;
    padding: 5px 10px;
    border-radius: 0 25px 25px 0;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.enviar:hover {
    color: black;
    cursor: pointer;
}

.comentario {
    display: flex;
    height: 90%;
    justify-content: space-between;
    border-radius: 15px;
    width: 92%;
}

.input {
    box-sizing: border-box;
    border-radius: 25px 0 0 25px;
    width: 100%;
    padding: 6px 6px 6px 25px;
    outline: none;
    border: transparent;
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
    padding: 5px;
    border-radius: 5px;
    height: fit-content;
    min-width: 250px;
    display: flex;
    flex-direction: column;
    box-sizing: border-box;
    padding: 15px;
}

.titulo div {
    display: flex;
    flex-direction: column;
    margin-left: 2%;
}

.titulo {
    display: flex;
}

.texto {
    padding: 1% 0;
}

.divi {
    width: 91.5%;
    height: 1px;
    background: rgba(0, 0, 0, 0.5);
    margin: 1% auto 1.5%;
}
</style>
