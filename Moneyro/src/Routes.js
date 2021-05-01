import Cadastro from './components/cadastro/Cadastro.vue';
import Comunidade from './components/comunidade/Comunidade.vue';
import Configuracoes from './components/configuracoes/Configuracoes.vue';
import Home from './components/home/Home.vue';
import Usuario from './components/usuario/Usuario.vue';
import Metas from './components/metas/Metas.vue';
import Planilha from './components/planilhas/Planilhas.vue';
import Relatorios from './components/relatorios/Relatorios.vue';
import Amigos from './components/amigos/Amigos.vue';
import Compras from './components/compras/Compras.vue';
import Boleto from './components/boleto/Boleto.vue';
import SalaAluno from './components/sala-aluno/SalaAluno.vue';
import SalaProfessor from './components/sala-professor/SalaProf.vue';
import Atividades from './components/atividades/Atividades.vue';

export const routes = [
    { path: '', component: Home, title: 'Home' },
    { path: '/cadastro', component: Cadastro, title: 'Cadastro' },
    { path: '/planilhas', component: Planilha, title: 'Planilha de Gastos' },
    { path: '/comunidade', component: Comunidade, title: 'Comunidade' },
    { path: '/relatorios', component: Relatorios, title: 'Relatórios' },
    { path: '/amigos', component: Amigos, title: 'Amigos' },
    { path: '/metas', component: Metas, title: 'Metas' },
    { path: '/configuracoes', component: Configuracoes, title: 'Cofigurações' },
    { path: '/usuario', component: Usuario, title: 'Usuario' },
    { path: '/compras', component: Compras, title: 'Compras' },
    { path: '/boleto', component: Boleto, title: 'Boleto' },
    { path: '/salaaluno', component: SalaAluno, title: 'Sala de Aula' },
    { path: '/salaprofessor', component: SalaProfessor, title: 'Sala de Aula' },
    { path: '/atividades', component: Atividades, title: 'Atividades' }
]