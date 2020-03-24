import Home from './components/home/Home.vue';
import Cadastro from './components/cadastro/Cadastro.vue';
import Perfil from './components/perfil/Perfil.vue';

export const routes = [

    { path: '', component: Home, titulo: 'Home' },
    { path: '/cadastro', component: Cadastro, titulo: 'Cadastro' },
    { path: '/perfil', component: Perfil, titulo: 'Perfil' }
]