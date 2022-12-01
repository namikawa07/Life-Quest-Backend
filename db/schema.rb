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

ActiveRecord::Schema.define(version: 2022_09_20_145145) do

  create_table "firebase_authentications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "status", null: false, unsigned: true
    t.bigint "sign_in_provider", null: false, unsigned: true
    t.bigint "user_id", null: false
    t.string "uid", null: false, collation: "utf8mb4_bin"
    t.string "email", null: false, collation: "utf8mb4_bin"
    t.text "refresh_token", null: false
    t.text "access_token"
    t.text "id_token", null: false
    t.string "tenant_id", collation: "utf8mb4_bin"
    t.boolean "email_verified", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_firebase_authentications_on_user_id"
  end

  create_table "hellos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "hello_string"
    t.text "hello_text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid", limit: 50, null: false, collation: "utf8mb4_bin"
    t.bigint "status", null: false, unsigned: true
    t.string "name", limit: 191, null: false, collation: "utf8mb4_bin"
    t.text "self_introduction"
    t.text "thumbnail_url"
    t.string "email", limit: 191, collation: "utf8mb4_bin"
    t.string "uid", null: false, collation: "utf8mb4_bin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
