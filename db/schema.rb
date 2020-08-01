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

ActiveRecord::Schema.define(version: 2020_06_10_074826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cepas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cepas_on_name", unique: true
  end

  create_table "evaluations", force: :cascade do |t|
    t.bigint "wine_id"
    t.bigint "oenologist_id"
    t.float "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["oenologist_id"], name: "index_evaluations_on_oenologist_id"
    t.index ["wine_id"], name: "index_evaluations_on_wine_id"
  end

  create_table "magazines", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "oenologist_magazines", force: :cascade do |t|
    t.bigint "oenologist_id"
    t.bigint "magazine_id"
    t.string "charge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["magazine_id"], name: "index_oenologist_magazines_on_magazine_id"
    t.index ["oenologist_id"], name: "index_oenologist_magazines_on_oenologist_id"
  end

  create_table "oenologists", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "nationality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wine_cepas", force: :cascade do |t|
    t.bigint "wine_id"
    t.bigint "cepa_id"
    t.float "percentage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cepa_id"], name: "index_wine_cepas_on_cepa_id"
    t.index ["wine_id"], name: "index_wine_cepas_on_wine_id"
  end

  create_table "wines", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_wines_on_name", unique: true
  end

  add_foreign_key "evaluations", "oenologists"
  add_foreign_key "evaluations", "wines"
  add_foreign_key "oenologist_magazines", "magazines"
  add_foreign_key "oenologist_magazines", "oenologists"
  add_foreign_key "wine_cepas", "cepas"
  add_foreign_key "wine_cepas", "wines"
end
