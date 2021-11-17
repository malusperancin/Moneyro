<template>
    <div class="comunicado">
        <div class="conteudo">
            <div class="cabecalho">
                <div class="infos">
                    <img :src="'../../src/images/perfil'+professor.foto+'.png'">
                    <div class="textos">
                        <strong><b>{{professor.nome}}</b></strong>
                        <small>{{data}}</small>
                    </div>
                </div>
                <div v-if="professor.id == $session.get('usuario').id" class="acoes">
                    <div v-on:click="excluir(comunicado.id)" class="deletar_icone">
                        <ion-icon name="trash" v-pre></ion-icon>
                    </div>
                </div>
            </div>
            <div class="texto">
                {{comunicado.descricao}}
            </div>
            <div class="divi"></div>
            <div class="enviar_comentario">
                <img :src="'../../src/images/perfil'+$session.get('usuario').foto+'.png'">
                <div class="comentario">
                    <input class="input" 
                    type="text"
                    placeholder="Adicionar comentário..."
                    />
                    <ion-icon name="send-outline" class="enviar" v-pre></ion-icon>
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
            data: "",
        };
    },
    methods: {
        excluir(id) {
            var msg = {
                visivel: true,
                titulo: "Excluir Postagem",
                mensagem: "Deseja mesmo excluir essa postagem de forma definitiva?",
                botoes: [
                    {
                        mensagem: "Cancelar",
                        evento: "cancelar",
                    },
                    {
                        mensagem: "Sim",
                        evento: "excluirPostagem",
                    }
                ],
            };

            this.$emit('excluir', msg);
        }
    },
    created() {
        var a = new Date(this.comunicado.data);
        var dd = String(a.getDate()).padStart(2, '0');
        var mm = String(a.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = a.getFullYear();
        
        this.data = dd + '/' + mm + '/' + yyyy;
    },
};

</script>

<style scoped>
.acoes {
    display: flex;
    grid-gap: 6px;
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

.cabecalho{
  display:flex;
  flex-direction:row;
  justify-content: space-between;
  font-size: 1.2em;
}

.infos {
    display: flex;
    flex: 1;
}

.deletar_icone{
    border: 1px solid grey;
    height: fit-content;
    padding: 5px;
    line-height: 0;
    border-radius: 87px;
    color: grey;
    transition: all 0.1s easy-in !important;
    cursor: pointer;
}

.deletar_icone:hover {
    color: white;
    background: rgb(211, 49, 49);
}

.enviar_comentario {
    display: flex;
    align-items: center;
    grid-gap: 10px;
    padding: 15px 0 0 0;
}

.enviar_comentario img{
    width:50px;
    height:50px;
    border-radius: 100px;
}

.comentario {
    border-radius: 15px;
    display: flex;
    flex: 1;
    position: relative;
}

.enviar {
    font-size: 1.75rem;
    color: gray;
    position: absolute;
    top: 10px;
    right: 15px;
}

.enviar:hover {
    color: black;
    cursor: pointer;
}

.input {
    margin-left:5px;
    box-sizing: border-box;
    border-radius: 25px;
    flex: 1;
    padding: 9px 50px 9px 15px;
    outline: none;
    border: 3px solid rgba(0, 0, 0, 0);
    font-size:1em;
}

.input:focus {
    border: 3px solid rgb(70, 67, 233);
}

.textos {
  display: flex;
  flex-direction: column;
  margin-left: 20px;
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

.texto {
    padding: 15px 0 5px 0;
    font-size:1.1em;
}

.divi {
    width: 100%;
    height: 1px;
    background: rgba(0, 0, 0, 0.5);
    margin: 10px 0;
}
</style>
