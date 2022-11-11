# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_11_11_092125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "bets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "match_id", null: false
    t.boolean "bonus", default: false, null: false
    t.integer "score1", default: 0, null: false
    t.integer "score2", default: 0, null: false
    t.decimal "points", precision: 6, scale: 2, default: "0.0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "exact", default: false, null: false
    t.index ["match_id"], name: "index_bets_on_match_id"
    t.index ["user_id", "match_id"], name: "index_bets_on_user_id_and_match_id", unique: true
    t.index ["user_id"], name: "index_bets_on_user_id"
  end

  create_table "match_days", force: :cascade do |t|
    t.datetime "stop_bet_time", null: false
    t.integer "day_number", null: false
    t.bigint "round_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["day_number"], name: "index_match_days_on_day_number", unique: true
    t.index ["round_id"], name: "index_match_days_on_round_id"
    t.index ["stop_bet_time"], name: "index_match_days_on_stop_bet_time", unique: true
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "match_day_id", null: false
    t.bigint "team1_id", null: false
    t.bigint "team2_id", null: false
    t.datetime "start_time", null: false
    t.integer "score1", default: 0, null: false
    t.integer "score2", default: 0, null: false
    t.boolean "finished", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_day_id"], name: "index_matches_on_match_day_id"
    t.index ["team1_id"], name: "index_matches_on_team1_id"
    t.index ["team2_id"], name: "index_matches_on_team2_id"
  end

  create_table "players", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.string "name"
    t.integer "position", default: 0, null: false
    t.integer "goals", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "assists", default: 0, null: false
    t.boolean "king", default: false, null: false
    t.index ["goals"], name: "index_players_on_goals"
    t.index ["king"], name: "index_players_on_king"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "score_factor", precision: 6, scale: 2, default: "1.0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "stage", default: 0, null: false
    t.index ["name"], name: "index_rounds_on_name", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.string "flag", null: false
    t.boolean "winner", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flag"], name: "index_teams_on_flag", unique: true
    t.index ["name"], name: "index_teams_on_name", unique: true
    t.index ["winner"], name: "index_teams_on_winner"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "player_id"
    t.boolean "admin", default: false, null: false
    t.bigint "team_id"
    t.string "name"
    t.decimal "points", precision: 6, scale: 2, default: "0.0", null: false
    t.integer "league_rank", default: 0, null: false
    t.integer "exact_bet_count", default: 0, null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["player_id"], name: "index_users_on_player_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  add_foreign_key "bets", "matches"
  add_foreign_key "bets", "users"
  add_foreign_key "match_days", "rounds"
  add_foreign_key "matches", "match_days"
  add_foreign_key "matches", "teams", column: "team1_id"
  add_foreign_key "matches", "teams", column: "team2_id"
  add_foreign_key "players", "teams"
  add_foreign_key "users", "players"
  add_foreign_key "users", "teams"
end
