import Cadastro from './components/cadastro/Cadastro.vue';
import Comunidade from './components/comunidade/Comunidade.vue';
import Configuracoes from './components/configuracoes/Configuracoes.vue';
import Home from './components/home/Home.vue';
import Usuario from './components/user/Usuario.vue';
import Planilha from './components/planilhas/Planilhas.vue';
import Registrar from './components/registrar/Registrar.vue';
import Relatorios from './components/relatorios/Relatorios.vue';
import Amigos from './components/amigos/Amigos.vue';

export const routes = [

    { path: '', component: Home, titulo: 'Home' },
    { path: '/cadastro', component: Cadastro, titulo: 'Cadastro' },
    { path: '/registrar', component: Registrar, titulo: 'Registrar' },
    { path: '/planilha', component: Planilha, titulo: 'Planilha de Gastos' },
    { path: '/comunidade', component: Comunidade, titulo: 'Comunidade' },
    { path: '/relatorios', component: Relatorios, titulo: 'Relatórios' },
    { path: '/amigos', component: Amigos, titulo: 'Amigos' },
    { path: '/configuracoes', component: Configuracoes, titulo: 'Cofigurações' },
    { path: '/usuario', component: Usuario, titulo: 'Usuario' }
]