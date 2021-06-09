import Vue from 'vue';
import VueResource from 'vue-resource';
import App from '../components/users_list.vue';

Vue.use(VueResource);

const metaCSRF = document.querySelector('meta[name="csrf-token"]')
if (metaCSRF) {
  Vue.http.headers.common['X-CSRF-TOKEN'] = metaCSRF.getAttribute('content')
}

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App)
  }).$mount()
  document.getElementById("main").appendChild(app.$el)
})