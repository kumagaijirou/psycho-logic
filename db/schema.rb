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

ActiveRecord::Schema[7.0].define(version: 2025_02_14_122748) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "service_name"
    t.integer "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "service_id"], name: "index_favorites_on_user_id_and_service_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "hyakuhyakus", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "front_comment"
    t.text "back_comment"
    t.integer "number_of_times_seen"
    t.integer "number_of_refunds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_hyakuhyakus_on_user_id"
  end

  create_table "mini_know_hows", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title"
    t.text "content"
    t.integer "viewing_fee"
    t.integer "number_of_times_seen"
    t.integer "number_of_refunds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_mini_know_hows_on_user_id"
  end

  create_table "novels", force: :cascade do |t|
    t.text "work_name"
    t.integer "user_id"
    t.text "synopsis"
    t.string "url1"
    t.string "url2"
    t.string "url3"
    t.integer "accumulation_dice_point"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "novels_supports", force: :cascade do |t|
    t.integer "novel_id"
    t.integer "user_id", null: false
    t.integer "support_fee"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_novels_supports_on_user_id"
  end

  create_table "point_codes", force: :cascade do |t|
    t.string "code"
    t.integer "point"
    t.integer "user_id"
    t.datetime "used_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "point_logs", force: :cascade do |t|
    t.integer "user_id"
    t.string "service_name"
    t.integer "service_id"
    t.string "category"
    t.integer "dice_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "point_mails", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "send_user_id"
    t.string "send_user_email"
    t.string "title"
    t.text "content"
    t.integer "send_dice_point"
    t.datetime "send_date"
    t.boolean "open", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_point_mails_on_user_id"
  end

  create_table "praise_mes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "comment"
    t.integer "number_of_people"
    t.datetime "deadline"
    t.string "phase"
    t.integer "rest_number_of_people"
    t.integer "number_of_times_seen"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_praise_mes_on_user_id"
  end

  create_table "praises", force: :cascade do |t|
    t.integer "praise_me_id"
    t.integer "user_id", null: false
    t.text "praise_comment"
    t.boolean "adopt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_praises_on_user_id"
  end

  create_table "probably_a_hits", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "service_name"
    t.integer "service_id"
    t.integer "creater_user_id"
    t.string "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_probably_a_hits_on_user_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer "user_id"
    t.text "question"
    t.text "answer"
    t.integer "number_of_times_solved"
    t.integer "number_of_correct_answers"
    t.integer "number_of_times_we_saw_the_answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supports", force: :cascade do |t|
    t.integer "task_id"
    t.integer "user_id"
    t.integer "support_fee"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.integer "bet_user_id"
    t.datetime "deadline_at"
    t.integer "amount_bet"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_time_at"
    t.text "last_message"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "thoughts", force: :cascade do |t|
    t.integer "novel_id"
    t.integer "user_id"
    t.text "thoughts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "open", default: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.text "profile"
    t.integer "dice_point"
    t.datetime "dice_point_expiry_date"
    t.text "final_answer"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "favorites", "users"
  add_foreign_key "hyakuhyakus", "users"
  add_foreign_key "mini_know_hows", "users"
  add_foreign_key "novels_supports", "users"
  add_foreign_key "point_mails", "users"
  add_foreign_key "praise_mes", "users"
  add_foreign_key "praises", "users"
  add_foreign_key "probably_a_hits", "users"
end
