<template>
  <div class="container" id="user">
    <div class="row">
      <div class="col-12">
        <div class="box my-3">
          <div class="skeleton-loading big" v-if="loading"></div>
          <template v-else>
            <div class="box-header">
              <h4>{{ user.name }}</h4>
            </div>

            <table class="table table-striped">
              <thead>
              <tr class="text-center">
                <th scope="col" class="d-none d-md-table-cell" colspan="3">Match</th>
                <th scope="col" class="d-none d-sm-table-cell d-md-none" colspan="2">Match</th>
                <th scope="col" class="d-sm-none">Match</th>
                <th scope="col">Score</th>
                <th scope="col">Bet</th>
                <th scope="col">Points</th>
              </tr>
              </thead>
              <tbody>
                <tr v-for="bet in bets" :key="bet.id" class="text-center">
                  <td class="d-none d-sm-table-cell">
                    {{ bet.match.round }}
                  </td>
                  <td class="no-break">
                    <span class="flag-icon" v-bind:class="'flag-icon-'+ bet.team1.flag"></span>
                    <span class="d-none d-sm-inline">{{ bet.team1.name }}</span>
                    -
                    <span class="flag-icon" v-bind:class="'flag-icon-'+ bet.team2.flag"></span>
                    <span class="d-none d-sm-inline">{{ bet.team2.name }}</span>
                  </td>
                  <td class="d-none d-md-table-cell">
                    {{ bet.match.time }}
                  </td>
                  <td class="no-break">
                    {{ bet.match.score1 }} - {{ bet.match.score2 }}
                  </td>
                  <td class="no-break">
                    {{ bet.score1 }} - {{ bet.score2 }}
                    <span v-if="bet.bonus">*</span>
                  </td>
                  <th>{{ bet.points }}</th>
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
    userUrl: String,
    user: Object
  },

  data: function () {
    return {
      loading: true,
      bets: []
    }
  },

  methods: {
    getUser() {
      this.$http.get(this.userUrl).then(response => {
        this.bets = response.body.bets;
        this.loading  = false;
      }, response => {
        console.log(response)
      });
    }
  },

  created() {
    this.getUser();
  }
}
</script>
