import Cadastro from './pages/cadastro/Cadastro.vue';
import Comunidade from './pages/comunidade/Comunidade.vue';
import Configuracoes from './pages/configuracoes/Configuracoes.vue';
import Home from './pages/home/Home.vue';
import Usuario from './pages/usuario/Usuario.vue';
import Metas from './pages/metas/Metas.vue';
import Planilha from './pages/planilhas/Planilhas.vue';
import Relatorios from './pages/relatorios/Relatorios.vue';
import Amigos from './pages/amigos/Amigos.vue';
import Compras from './pages/compras/Compras.vue';
import Boleto from './pages/boleto/Boleto.vue';
import SalaAluno from './pages/sala-aluno/SalaAluno.vue';
import SalaProfessor from './pages/sala-professor/SalaProf.vue';
import Atividades from './pages/atividades/Atividades.vue';
import Pontos from './pages/pontos/Pontos.vue';
import Quiz from './pages/quiz/Quiz.vue';
import Jogo from './pages/jogo/Jogo.vue';
import Sobre from './pages/sobre/Sobre.vue';

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
    { path: '/salaprofessor/:codigoSala?', component: SalaProfessor, title: 'Sala de Aula' },
    { path: '/atividades', component: Atividades, title: 'Atividades' },
    { path: '/pontos', component: Pontos, title: 'Pontos' },
    { path: '/quiz', component: Quiz, title: 'Quiz' },
    { path: '/jogo', component: Jogo, title: 'Jogo' },
    { path: '/sobre', component: Sobre, title: 'Sobre' }
]