<template>
  <div class="container" id="round">
    <div class="row">
      <div class="col-12">
        <div class="box my-3">
          <div class="skeleton-loading big" v-if="loading"></div>
          <template v-else>
            <div class="box-header">
              <h4>{{ name }}</h4>
            </div>

            <table class="table table-striped">
              <thead>
              <tr class="text-center">
                <th scope="col">Rank</th>
                <th scope="col">Name</th>
                <th scope="col">Points</th>
                <th scope="col">Exact Bets</th>
              </tr>
              </thead>
              <tbody>
              <tr v-for="(user, index) in users" :key="user.id" class="text-center">
                <th> {{ index + 1 }} </th>
                <td> {{ user.name }} </td>
                <td> {{ user.points }} </td>
                <td> {{ user.exact_bet_count }} </td>
              </tr>
              </tbody>
            </table>
          </template>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    roundUrl: String,
    name: String
  },

  data: function () {
    return {
      users: [],
      loading: true
    }
  },

  methods: {
    getUsers() {
      this.$http.get(this.roundUrl).then(response => {
        this.users = response.body.users.sort((u1, u2) => {
          if(u2.points === u1.points) {
            return u2.exact_bet_count - u1.exact_bet_count;
          } else {
            return parseFloat(u2.points) - parseFloat(u1.points);
          }
        });
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
