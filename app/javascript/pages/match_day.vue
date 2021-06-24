<template>
  <div class="container" id="users-list">
    <div class="row">
      <div class="col-12">
        <div class="box my-3" v-if="loading">
          <div class="skeleton-loading big" ></div>
        </div>
        <div class="box mt-3" v-else>
          <div class="box-header" >
            <h4> {{ name }}</h4>
          </div>
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
              <tr class="text-center">
                <th scope="col"></th>
                <th scope="col" colspan="2" class="no-break" v-for="match in matches" :key="match.id">
                  <span class="flag-icon" v-bind:class="'flag-icon-'+ match.team1.flag"></span>
                  <span class="d-none d-sm-inline">{{ match.team1.name }}</span>
                  -
                  <span class="flag-icon" v-bind:class="'flag-icon-'+ match.team2.flag"></span>
                  <span class="d-none d-sm-inline">{{ match.team2.name }}</span>
                </th>
              </tr>
              </thead>
              <tbody>
              <tr v-for="user in users" :key="user.id" class="text-center">
                <th class="sticky no-break"> {{user.name}} </th>
                <template v-for="match in matches">
                  <td class="no-break">
                    {{ bets[match.id][user.id] && bets[match.id][user.id].score1 }}
                    -
                    {{ bets[match.id][user.id] && bets[match.id][user.id].score2 }}
                    <span v-if="bets[match.id][user.id] && bets[match.id][user.id].bonus">*</span>
                  </td>
                  <td> {{ bets[match.id][user.id] && bets[match.id][user.id].points }} </td>
                </template>
              </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    matchDayUrl: String
  },

  data: function () {
    return {
      loading: true,
      name: null,
      matches: [],
      users: [],
      bets: {}
    }
  },

  methods: {
    getMatchDay() {
      this.$http.get(this.matchDayUrl).then(response => {
        this.name = response.body.display_name;
        this.users = response.body.users;
        this.matches = response.body.matches;
        this.bets = response.body.bets;
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