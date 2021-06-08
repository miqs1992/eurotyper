<template>
  <div class="row g-3 my-3" id="cards">
    <div class="col-6 col-md-4 ">
      <div class="card h-100">
        <div class="row g-0 h-100">
          <div class="col-4 centered-text h-100">
            <i class="bi bi-award-fill bi-big"></i>
          </div>
          <div class="col-8 h-100">
            <div class="card-body h-100 centered-text">
              <div class="skeleton-loading" v-if="loading"></div>
              <h5 class="card-title mb-0" v-else>
                {{ me.points || "0" }} points
              </h5>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-6 col-md-4">
      <div class="card h-100">
        <div class="row g-0 h-100">
          <div class="col-4 centered-text h-100">
            <i class="bi bi-list-ol bi-big"></i>
          </div>
          <div class="col-8 h-100">
            <div class="card-body h-100 centered-text">
              <div class="skeleton-loading" v-if="loading"></div>
              <h5 class="card-title mb-0" v-else>
                {{ me.main_league_place || "-" }} place
              </h5>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-xs-12 col-md-4">
      <div class="card">
        <div class="row g-0">
          <div class="col-4 centered-text">
            <i class="bi bi-alarm-fill bi-big"></i>
          </div>
          <div class="col-8">
            <div class="card-body h-100 centered-text">
              <div class="skeleton-loading" v-if="loading"></div>
              <h5 class="card-title mb-0 text-center" v-else>
                {{ me.stop_bet_time || "-" }}
              </h5>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      me: null,
      loading: true
    }
  },

  methods: {
    getData() {
      this.$http.get("/users/me").then(response => {
        // get body data
        this.me = response.body.me;
        this.loading  = false;
      }, response => {
        console.log(response)
      });
    }
  },

  created() {
    this.getData();
  }
}
</script>
