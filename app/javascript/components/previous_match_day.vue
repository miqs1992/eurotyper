<template>
  <div id="previous-match-day" class="box h-100">
    <div class="box-header">
      <h4>Previous match day</h4>
    </div>
    <div class="skeleton-loading big" v-if="loading"></div>
    <table class="table table-striped" v-else>
      <thead>
      <tr class="text-center">
        <th scope="col">Match</th>
        <th scope="col">Score</th>
        <th scope="col">Bet</th>
        <th scope="col" class="d-none d-sm-table-cell">Points</th>
        <th scope="col" class="d-sm-none">P.</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="bet in matchDay.bets" :key="bet.id" class="text-center">
        <td class="d-none d-sm-table-cell">
          <span class="flag-icon" v-bind:class="'flag-icon-'+ bet.team1.flag"></span>
          {{ bet.team1.name }}
          -
          <span class="flag-icon" v-bind:class="'flag-icon-'+ bet.team2.flag"></span>
          {{ bet.team2.name }}
        </td>
        <td class="d-sm-none">
          <span class="flag-icon" v-bind:class="'flag-icon-'+ bet.team1.flag"></span>
          -
          <span class="flag-icon" v-bind:class="'flag-icon-'+ bet.team2.flag"></span>
        </td>
        <td> {{ bet.team1.score }} - {{ bet.team2.score }} </td>
        <td>
          {{ bet.score1 }} - {{ bet.score2 }}
          <span v-if="bet.bonus">*</span>
        </td>
        <th>{{ bet.points }}</th>
      </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      matchDay: null,
      loading: true
    }
  },

  methods: {
    getMatchDay() {
      this.$http.get("/match_days/last").then(response => {
        // get body data
        this.matchDay = response.body.match_day;
        this.loading  = false;
      }, response => {
        console.log(response)
      });
    }
  },

  created() {
    this.getMatchDay();
  }
}
</script>
