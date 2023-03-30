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

ActiveRecord::Schema[7.0].define(version: 2023_03_30_054141) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.bigint "day_id", null: false
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_activities_on_day_id"
  end

  create_table "days", force: :cascade do |t|
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hydrations", force: :cascade do |t|
    t.integer "cups"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "day_id", null: false
    t.index ["day_id"], name: "index_hydrations_on_day_id"
  end

  create_table "sleeps", force: :cascade do |t|
    t.time "length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "day_id", null: false
    t.index ["day_id"], name: "index_sleeps_on_day_id"
  end

  add_foreign_key "activities", "days"
  add_foreign_key "hydrations", "days"
  add_foreign_key "sleeps", "days"
end
