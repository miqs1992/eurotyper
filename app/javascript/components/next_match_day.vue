<template>
  <div id="next-match-day" class="box h-100">
    <div class="box-header">
      <h4>Next match day</h4>
    </div>
    <div class="skeleton-loading big" v-if="loading"></div>
    <div class="text-center p-2" v-else-if="!matchDay">
      <i class="bi bi-exclamation-diamond-fill fs-2"></i>
      <h5>No next match day</h5>
    </div>
    <template v-else>
      <table class="table table-striped" >
        <thead>
        <tr class="text-center">
          <th scope="col">Match</th>
          <th scope="col" colspan="2">Bet</th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="bet in matchDay.bets" :key="bet.id" class="text-center">
          <td class="d-none d-sm-block">
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
          <td class="p-1">
            <input type="number" min="0" max="10" v-model="bet.score1">
          </td>
          <td class="p-1">
            <input type="number" min="0" max="10" v-model="bet.score2">
          </td>
        </tr>
        </tbody>
      </table>
      <div class="col-12">
        <a class="btn btn-primary btn-sm float-end mb-3">
          Save
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
      this.$http.get("/match_days/next").then(response => {
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

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>