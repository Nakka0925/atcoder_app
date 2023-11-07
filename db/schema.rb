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

ActiveRecord::Schema[7.0].define(version: 2023_10_27_122434) do
  create_table "algos", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "algo_id"
    t.string "algo_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["algo_id"], name: "index_algos_on_algo_id", unique: true
  end

  create_table "problems", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.string "problem_id"
    t.string "contest_id"
    t.string "problem_index"
    t.string "name"
    t.bigint "algo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "difficulty"
    t.index ["algo_id"], name: "fk_rails_12fdc1cdbf"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "problems", "algos"
end
