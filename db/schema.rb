# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_20_201807) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "matches", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "home_player_id", null: false
    t.uuid "away_player_id", null: false
    t.uuid "tournament_id", null: false
    t.string "stage", null: false
    t.date "date", null: false
    t.string "home_seed"
    t.string "away_seed"
    t.integer "home_set_1_score"
    t.integer "home_set_2_score"
    t.integer "home_set_3_score"
    t.integer "home_set_4_score"
    t.integer "home_set_5_score"
    t.integer "away_set_1_score"
    t.integer "away_set_2_score"
    t.integer "away_set_3_score"
    t.integer "away_set_4_score"
    t.integer "away_set_5_score"
    t.string "tiebreak_set_1_score"
    t.string "tiebreak_set_2_score"
    t.string "tiebreak_set_3_score"
    t.string "tiebreak_set_4_score"
    t.string "tiebreak_set_5_score"
    t.boolean "retirement", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "country", null: false
    t.date "date_of_birth"
    t.string "born"
    t.string "sex", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tournaments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "country", null: false
    t.string "city", null: false
    t.string "category", null: false
    t.string "tour", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "matches", "players", column: "away_player_id"
  add_foreign_key "matches", "players", column: "home_player_id"
  add_foreign_key "matches", "tournaments"
end
