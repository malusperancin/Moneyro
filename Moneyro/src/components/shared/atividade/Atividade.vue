 <template>
 <div class="atividade">
      <div class="conteudo">
        <div class="cabecalho">
            <img src="../../../images/perfil2.png" style="width: 50px">
            <div class="escrita">
                <div class="infos">
                  <strong><b>{{professor.nome}}</b></strong>
                  <strong><b> Atividade numero 1 - Quiz</b></strong>
                </div>
                <strong><b>{{comunicado.data}}</b></strong>
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
        texto: "Informamos: Fuleco faleceu!",
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

p {
  margin: 0;
  color:white;
  padding: 3px;
}

.atividade{
  height: 100%;
  width: 80%;
  align-items: center;
}

.escrita{
    display: flex;
    flex-direction: column;
    margin-left: 2%;
    width:100%;
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

.atividade :hover {
  background: rgb(60, 62, 60);
}

.infos {
  display: flex;
  justify-content: space-between;
}

.cabecalho{
    display: flex;
}

.texto {
  background: green;
  margin-left: 2.3%;
  margin-bottom: 1%;
  margin-top:1%;
}


/* .topo-atividade {
  background: rgb(37, 33, 33);
  padding: 10px;
  display: flex;
  justify-content: space-between;
  border-top-left-radius: inherit;
  border-top-right-radius: inherit;
} */

</style>
