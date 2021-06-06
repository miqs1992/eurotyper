<template>
  <div id="app">
    <div class="container">
      <div class="row g-3 mt-3">
        <div class="col-xs-12 col-sm-6">
          <previous_match_day />
        </div>
        <div class="col-xs-12 col-sm-6">
          <next_match_day />
        </div>
        <div class="col-xs-12 col-sm-6">
          <best_scorers />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import previous_match_day from "./components/previous_match_day";
import next_match_day from "./components/next_match_day";
import best_scorers from "./components/best_scorers";

export default {
  components: {
    previous_match_day,
    next_match_day,
    best_scorers
  }
}
</script>
