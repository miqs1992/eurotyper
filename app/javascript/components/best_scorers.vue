<template>
  <div id="best-scorers" class="box h-100">
    <div class="box-header">
      <h4>Best scorers</h4>
    </div>
    <div class="skeleton-loading big" v-if="loading"></div>
    <table class="table table-striped" v-else>
      <thead>
      <tr class="text-center">
        <th scope="col">Name</th>
        <th scope="col">Team</th>
        <th scope="col" class="d-none d-sm-table-cell">Position</th>
        <th scope="col">Goals</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="player in players" :key="player.id" class="text-center">
        <td> {{ player.name }} </td>
        <td class="d-none d-sm-table-cell">
          <span class="flag-icon" v-bind:class="'flag-icon-'+ player.team.flag"></span>
          {{ player.team.name }}
        </td>
        <td class="d-sm-none">
          <span class="flag-icon" v-bind:class="'flag-icon-'+ player.team.flag"></span>
        </td>
        <td class="d-none d-sm-table-cell"> {{ player.position }} </td>
        <th>{{ player.goals }}</th>
      </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      players: [],
      loading: true
    }
  },

  methods: {
    getPlayers() {
      this.$http.get("/players").then(response => {
        // get body data
        this.players = response.body.players;
        this.loading  = false;
      }, response => {
        console.log(response)
      });
    }
  },

  created() {
    this.getPlayers();
  }
}
</script>
