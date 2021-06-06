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
          <td class="p-2">
            <input type="number"
                   min="0"
                   max="10"
                   class="form-control py-0 pe-0"
                   v-model="bet.score1"
                   v-bind:class="{'is-valid': updateSuccess, 'is-invalid': updateFail}" >
          </td>
          <td class="p-2">
            <input type="number"
                   min="0"
                   max="10"
                   class="form-control py-0 pe-0"
                   v-model="bet.score2"
                   v-bind:class="{'is-valid': updateSuccess, 'is-invalid': updateFail}" >
          </td>
        </tr>
        </tbody>
      </table>
      <div class="col-12">
        <a class="btn btn-outline-primary btn-sm float-end mb-3 w-100px text-center" v-if="updating">
          <i class="bi bi-arrow-repeat bi-spin"></i>
        </a>
        <a class="btn btn-primary btn-sm float-end mb-3 w-100px text-center" @click.prevent="updateBets" v-else>
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
      loading: true,
      updating: false,
      updateSuccess: false,
      updateFail: false
    }
  },

  computed: {
    betParams: function() {
      let params = {}
      this.matchDay.bets.forEach(bet => {
        params[bet.id] = {
          score1: bet.score1,
          score2: bet.score2,
          bonus: bet.bonus
        }
      })
      return { bets: params };
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
    },

    updateBets() {
      this.updating = true;
      const id = this.matchDay.id
      this.$http.put(`/match_days/${id}/update_bets`, this.betParams).then(() => {
        this.updating = false;
        this.updateSuccess = true;
        setTimeout(() => { this.updateSuccess = false } , 2000)
      }, () => {
        this.updating = false;
        this.getMatchDay();
        this.updateFail = true;
        setTimeout(() => { this.updateFail = false } , 2000)
      })
    }
  },

  created() {
    this.getMatchDay();
  }
}
</script>
