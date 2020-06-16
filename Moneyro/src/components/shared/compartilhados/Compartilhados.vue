<template>
<div class="modal">
    <div class="modal-conteudo animate width-30">
        <div class="cima">
            <span>Registros compartilhados</span> <span class="fechar" v-on:click="$emit('fechar')">&times;</span>
        </div>
        <div v-if="!metas[0] && !despesas[0]" class="corpo">
            <h3>Você não compartilhou nada com esse user</h3>
        </div>
        <div class="corpo" v-else>
            <div class="despesa" v-for="(despesa, i) in despesas" :key="i">
            <div class="titulo">
                Despesa
            </div>
             <div class="nome">
                 {{despesa.nome}}
             </div> 
             <div class="quantia">
                 {{despesa.quantia}}
             </div>
            </div>
            <div class="meta" v-for="(meta, i) in metas" :key="i">
                <div class="titulo">
                Meta
            </div>
                <div class="nome">{{meta.nome}} </div> 
                <div class="quantia">
                    <big> {{meta.porcentagem}} </big>completa
                </div>
            </div>
        </div>
    </div>
</div>
</template>

<script>
export default {
    props: ["id"],
    data(){
        return{
            despesas:[],
            metas:[]
        }
    },
    created() {
      this.$http
      .get("https://localhost:5001/api/registros/compartilhados/" + this.$session.get("id") + "/"+this.id)
      .then(dados=> {
          dados.body.map(reg => {
        //   alert(dados.body[0]);
            if(reg.quantia < 0)
                this.despesas.push({
                    nome: reg.nome,
                    quantia: "R$"+Math.abs(reg.quantia),
                });
        });
      }, erro => {
        console.log("Erro ao pegar registro: " + erro.bodyText);
      });

      this.$http
      .get("https://localhost:5001/api/metas/compartilhados/" + this.$session.get("id") + "/"+this.id)
      .then(dados=> {
        dados.body.map(reg => {
            this.metas.push({
                nome: reg.nome,
                porcentagem: (reg.atual/reg.objetivo)*100 + "%"
            });
        });
      }, erro => {
        console.log("Erro ao adicionar registro: " + erro.bodyText);
      });
    },
}
</script>

<style scoped src="../../../css/modal.css"></style>
<style scoped>
.cima{
    justify-content: space-between;
    align-items: center;
    background-color: rgb(243, 243, 243);
    font-weight: 800;
    font-size: 1.5em;
}

.despesa {
    border: 2px solid red;
    background: rgba(255, 0, 0, 0.7);
    border-radius: 3px;
    width: fit-content;
    padding: 5px 10px;
    box-sizing: border-box;
    position: relative;
    min-width: 150px;
    color: whitesmoke;
}

.meta {
    border: 2px solid  rgb(99, 97, 219);
    background: rgb(99, 97, 219, 0.7);
    border-radius: 3px;
    width: fit-content;
    padding: 10px 15px;
    box-sizing: border-box;
    min-width: 150px;
    position: relative;
    color: whitesmoke;
}

.despesa .titulo{
    position: absolute;
    font-weight: 600;
    background: rgb(236, 73, 73);
    border-radius: 3px;
    padding: 0px 8px;
    bottom: -10px;
    right: -15px;
}

.despesa .nome{
    font-weight: 700;
    font-size: 25px
}

.despesa .quantia{
    font-weight: 1000;
    border-radius: 3px;
    padding: 2px 4px;
    width: fit-content;
    font-size: 20px
}

big{
    font-size: 20px;
}

.meta .titulo{
    position: absolute;
    font-weight: 600;
    background: rgb(99, 97, 219);
    border-radius: 3px;
    padding: 1px 8px;
    bottom: -15px;
    right: -20px;
}

.meta .nome{
    font-weight: 700;
    font-size: 25px
}

.corpo {
    padding: 15px;
    display: flex;
    flex-flow: row wrap;
    max-height: 80vh;
}

.corpo div{
    margin: 5px;
}
</style>