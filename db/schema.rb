# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_05_213611) do

  create_table "item_journeys", force: :cascade do |t|
    t.integer "item_id"
    t.integer "journey_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "noun"
    t.string "adjective"
    t.string "descript"
    t.string "space_id"
  end

  create_table "journeys", force: :cascade do |t|
    t.string "traveler_name"
    t.integer "user_id"
    t.integer "region_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
  end

  create_table "spaces", force: :cascade do |t|
    t.string "noun"
    t.string "adjective"
    t.string "descript"
    t.integer "region_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

end
