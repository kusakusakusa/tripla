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

ActiveRecord::Schema[7.0].define(version: 2023_03_01_094429) do
  create_table "followings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "follower_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id"], name: "index_followings_on_follower_id"
    t.index ["user_id", "follower_id"], name: "index_followings_on_user_id_and_follower_id", unique: true
    t.index ["user_id"], name: "index_followings_on_user_id"
  end

  create_table "sleep_logs", force: :cascade do |t|
    t.datetime "wake_up_at"
    t.integer "user_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["created_at"], name: "index_sleep_logs_on_created_at"
    t.index ["user_id"], name: "index_sleep_logs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "followings", "users"
  add_foreign_key "followings", "users", column: "follower_id"
  add_foreign_key "sleep_logs", "users"
end
