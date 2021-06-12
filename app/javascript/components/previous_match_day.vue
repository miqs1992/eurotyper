<template>
  <div id="previous-match-day" class="box h-100">

    <div class="skeleton-loading big" v-if="loading"></div>
    <template v-else-if="!matchDay">
      <div class="box-header">
        <h4>Previous match day</h4>
      </div>
      <div class="text-center p-2" >
        <i class="bi bi-exclamation-diamond-fill fs-2"></i>
        <h5>No previous match day</h5>
      </div>
    </template>
    <template v-else>
      <div class="box-header">
        <h4> {{ matchDay.display_name }} </h4>
      </div>
      <table class="table table-striped" >
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
      <div class="col-12">
        <a class="btn btn-primary btn-sm float-end mb-3 text-center" :href="'/match_days/' + matchDay.id">
          View match day
        </a>
      </div>
    </template>
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
