import Cadastro from './components/cadastro/Cadastro.vue';
import Comunidade from './components/comunidade/Comunidade.vue';
import Configuracoes from './components/configuracoes/Configuracoes.vue';
import Despesas from './components/despesas/Despesas.vue';
import Home from './components/home/Home.vue';
import Perfil from './components/perfil/Perfil.vue';
import Planilha from './components/planilhas/Planilhas.vue';
import Receitas from './components/receitas/Receitas.vue';
import Registrar from './components/registrar/Registrar.vue';
import Relatorios from './components/relatorios/Relatorios.vue';
import Amigos from './components/amigos/Amigos.vue';

export const routes = [

    { path: '', component: Home, titulo: 'Home' },
    { path: '/cadastro', component: Cadastro, titulo: 'Cadastro' },
    { path: '/registrar', component: Registrar, titulo: 'Registrar' },
    { path: '/planilha', component: Planilha, titulo: 'Planilha de Gastos' },
    { path: '/comunidade', component: Comunidade, titulo: 'Comunidade' },
    { path: '/despesas', component: Despesas, titulo: 'Despesas' },
    { path: '/receitas', component: Receitas, titulo: 'Receitas' },
    { path: '/relatorios', component: Relatorios, titulo: 'Relatórios' },
    { path: '/configuracoes', component: Configuracoes, titulo: 'Cofigurações' },
    { path: '/amigos', component: Amigos, titulo: 'Amigos' },
    { path: '/perfil', component: Perfil, titulo: 'Perfil' }
]