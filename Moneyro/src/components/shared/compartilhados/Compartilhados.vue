<template>
<div class="modal">
    <div class="modal-conteudo animate width-30">
        <div class="cima">
            <span class="fechar" v-on:click="$emit('fechar')">&times;</span>
        </div>
        <div class="corpo">
            {{despesas}}
            {{metas}}
        </div>
        <div class="baixo">

        </div>
    </div>
</div>
</template>

<script>
export default {
    props: {
        idAmigo: Number
    },
    data(){
        return{
            despesas:[],
            metas:[]
        }
    },
    created() {
      this.$http
      .get("https://localhost:5001/api/registros/compartilhados/" + this.$session.get("id") + "/"+this.idAmigo)
      .then(dados=> {
        dados.body.map(reg => {
            if(reg.quantia < 0)
                this.despesas.push({
                    data: new Date(reg.data),
                    nome: reg.nome,
                    idTag: reg.tag,
                    lugar: reg.lugar,
                    quantia: reg.quantia,
                });
        });
      }, erro => {
        console.log("Erro ao adicionar registro: " + erro.bodyText);
      });

      this.$http
      .get("https://localhost:5001/api/metas/compartilhados/" + this.$session.get("id") + "/"+this.idAmigo)
      .then(dados=> {
        dados.body.map(reg => {
            this.metas.push({
                data: new Date(reg.dataLimite),
                nome: reg.nome,
                atual: reg.atual,
                objetivo: reg.objetivo,
            });
        });
      }, erro => {
        console.log("Erro ao adicionar registro: " + erro.bodyText);
      });
    },
}
</script>

<style scoped src="../../../css/modal.css"></style>
<style>

</style>