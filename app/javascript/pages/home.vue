<template>
  <div id="app">
    <div class="container">
      <cards />
      <div class="row g-3 mb-3">
        <div class="col-xs-12 col-sm-6">
          <next_match_day match-day-url= "/match_days/next.json" />
        </div>
        <div class="col-xs-12 col-sm-6">
          <previous_match_day />
        </div>
        <div class="col-xs-12 col-sm-6">
          <best_scorers />
        </div>
        <div class="col-xs-12 col-sm-6">
          <top_users />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import previous_match_day from "../components/previous_match_day";
import next_match_day from "../components/next_match_day";
import best_scorers from "../components/best_scorers";
import cards from "../components/cards";
import top_users from "../components/top_users";

export default {
  components: {
    previous_match_day,
    next_match_day,
    best_scorers,
    cards,
    top_users
  }
}
</script>
