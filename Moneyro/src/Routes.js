import Cadastro from './components/cadastro/Cadastro.vue';
import Comunidade from './components/comunidade/Comunidade.vue';
import Configuracoes from './components/configuracoes/Configuracoes.vue';
import Home from './components/home/Home.vue';
import Usuario from './components/usuario/Usuario.vue';
import Metas from './components/metas/Metas.vue';
import Planilha from './components/planilhas/Planilhas.vue';
import Relatorios from './components/relatorios/Relatorios.vue';
import Amigos from './components/amigos/Amigos.vue';

export const routes = [

    { path: '', component: Home, titulo: 'Home' },
    { path: '/cadastro', component: Cadastro, titulo: 'Cadastro' },
    { path: '/planilhas', component: Planilha, titulo: 'Planilha de Gastos' },
    { path: '/comunidade', component: Comunidade, titulo: 'Comunidade' },
    { path: '/relatorios', component: Relatorios, titulo: 'Relatórios' },
    { path: '/amigos', component: Amigos, titulo: 'Amigos' },
    { path: '/metas', component: Metas, titulo: 'Metas' },
    { path: '/configuracoes', component: Configuracoes, titulo: 'Cofigurações' },
    { path: '/usuario', component: Usuario, titulo: 'Usuario' }
]