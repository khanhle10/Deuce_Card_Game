# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151209074615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards_playeds", force: :cascade do |t|
    t.integer  "player_card_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "conversations", ["recipient_id"], name: "index_conversations_on_recipient_id", using: :btree
  add_index "conversations", ["sender_id"], name: "index_conversations_on_sender_id", using: :btree

  create_table "deuces", force: :cascade do |t|
    t.integer  "player_count"
    t.string   "name"
    t.string   "player1"
    t.string   "player2"
    t.string   "player3"
    t.string   "player4"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "game_rules", force: :cascade do |t|
    t.integer  "round_id"
    t.integer  "winner_id"
    t.integer  "position"
    t.string   "winner_suit"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer "Player1"
    t.integer "Player2"
    t.integer "Player3"
    t.integer "Player4"
    t.integer "CurrentHand"
    t.integer "LargestCard"
    t.integer "CurrentPlayer"
  end

  create_table "lobbies", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "user_name"
    t.integer  "game_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "player_cards", force: :cascade do |t|
    t.integer  "player_cards"
    t.integer  "card_id"
    t.integer  "card_passing_set_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "players", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.integer  "seat"
    t.integer  "total_score", default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "widgets", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "stock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
end
