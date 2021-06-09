<template>
  <div id="top-users" class="box h-100">
    <div class="box-header">
      <h4>Top users</h4>
    </div>
    <div class="skeleton-loading big" v-if="loading"></div>
    <table class="table table-striped" v-else>
      <thead>
      <tr class="text-center">
        <th scope="col">Rank</th>
        <th scope="col">Name</th>
        <th scope="col">Points</th>
        <th scope="col" class="d-none d-sm-table-cell">Exact Bets</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="user in users" :key="user.id" class="text-center">
        <th> {{ user.league_rank }} </th>
        <td> {{ user.name }} </td>
        <td> {{ user.points }} </td>
        <td class="d-none d-sm-table-cell"> {{ user.exact_bet_count }} </td>
      </tr>
      </tbody>
    </table>
    <div class="col-12">
      <a class="btn btn-primary btn-sm float-end mb-3 w-100px text-center" href="/users">
        Full ranking
      </a>
    </div>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      users: [],
      loading: true
    }
  },

  methods: {
    getUsers() {
      this.$http.get("/users", { params: { per: 5 } }).then(response => {
        // get body data
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
