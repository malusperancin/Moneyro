<template>
    <div class="comunicado">
        <div class="conteudo">
            <div class="titulo">
                <img src="../../../images/perfil2.png" style="width: 50px">
                <div>
                    <strong><b>{{professor.nome}}</b></strong>
                    <p class="data">{{datahoje}} </p>
                </div>
            </div>
            <div class="texto">
                <textarea class="input" type="text" rows="3" placeholder="Adicionar comentário..."/>  
            </div>
            <div id="btn">
             <button class="botao">Enviar</button>
             </div>
        </div>
    </div>
</template>


<script>
export default {
  data() {
    return {
      datahoje: '',
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
    dataAtual(){
    var data = new Date(),
        dia  = data.getDate().toString(),
        diaF = (dia.length == 1) ? '0'+dia : dia,
        mes  = (data.getMonth()+1).toString(), //+1 pois no getMonth Janeiro começa com zero.
        mesF = (mes.length == 1) ? '0'+mes : mes,
        anoF = data.getFullYear();
        this.datahoje = diaF+"/"+mesF+"/"+anoF;
}
  },
  computed: {
  },
  created() {
   this.dataAtual();
  },
  beforeCreate(){

  },
  watch: {
    expanded(){
      
    }
  },
};

</script>

<style scoped>
.data{
    padding:0;
}

img{
    width:100%;
    height: 100%;
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

.input {
    box-sizing: border-box;
    border-radius: 10px;
    resize: none;
    width: 100%;
    padding: 10px 12px 6px 15px;
    outline: none;
    font-size: 1em;
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
    margin-bottom: 5px;
}

.texto {
    padding: 1% 0;
}

.botao {
    font-size: 1em;
    border: none;
    width: 15%;
    color: white;
    background-color: rgba(241, 174, 30, 0.863);
    border-radius: 9px;
    cursor: pointer;
    font-weight: 800;
    padding: 5px;
    float: right;
}

.botao:hover {
      background-color: rgba(241, 174, 30, 1);
}

textarea::-webkit-scrollbar {
  width: 10px;
  border-radius: 50px;
  background-color: #F5F5F5; }

textarea::-webkit-scrollbar-thumb {
  border-radius: 10px;
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.1);
  background-color: #D3D3D3; }
</style>
