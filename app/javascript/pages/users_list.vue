<template>
  <div class="container" id="users-list">
    <div class="row">
      <div class="col-12">
        <div class="box my-3">
          <div class="box-header">
            <h4>Current ranking</h4>
          </div>
          <div class="skeleton-loading big" v-if="loading"></div>
          <table class="table table-striped" v-else>
            <thead>
            <tr class="text-center">
              <th scope="col">Rank</th>
              <th scope="col">Name</th>
              <th scope="col">Points</th>
              <th scope="col">Exact Bets</th>
              <th scope="col" class="d-none d-sm-table-cell">Top scorer</th>
              <th scope="col" class="d-none d-sm-table-cell">Winner</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="user in users" :key="user.id" class="text-center">
              <th> {{ user.league_rank }} </th>
              <td><a :href="user.show_path" class="link-dark">{{ user.name }}</a></td>
              <td> {{ user.points }} </td>
              <td> {{ user.exact_bet_count }} </td>
              <td class="d-none d-sm-table-cell">
                <template v-if="user.player">
                  <span class="flag-icon" v-bind:class="'flag-icon-'+ user.player.flag"></span>
                  {{ user.player.name }}
                </template>
              </td>
              <td class="d-none d-sm-table-cell">
                <template v-if="user.team">
                  <span class="flag-icon" v-bind:class="'flag-icon-'+ user.team.flag"></span>
                  {{ user.team.name }}
                </template>
              </td>
            </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    usersUrl: String
  },

  data: function () {
    return {
      users: [],
      loading: true,
      per: 30
    }
  },

  computed: {
    pageParams: function (){
      return { params: { per: this.per, extended: true } }
    }
  },

  methods: {
    getUsers() {
      this.$http.get(this.usersUrl, this.pageParams).then(response => {
        this.users = response.body.users;
        this.loading  = false;
      }, response => {
        console.log(response)
      });
    }
  },

  created() {
    this.getUsers();
  }
}
</script>
