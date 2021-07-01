import Vue from 'vue/dist/vue.esm'
import VueResource from 'vue-resource';
import Home from '../pages/home.vue'
import UsersList from '../pages/users_list.vue';
import MatchDay from '../pages/match_day.vue';
import NextMatchDay from '../components/next_match_day';
import Round from '../pages/round'

Vue.use(VueResource);
Vue.component('home', Home);
Vue.component('users-list', UsersList);
Vue.component('match-day', MatchDay);
Vue.component('next-match-day', NextMatchDay);
Vue.component('round', Round);

const metaCSRF = document.querySelector('meta[name="csrf-token"]')
if (metaCSRF) {
  Vue.http.headers.common['X-CSRF-TOKEN'] = metaCSRF.getAttribute('content')
}

document.addEventListener('DOMContentLoaded', () => {
  new Vue({el: "#main-vue"})
})
