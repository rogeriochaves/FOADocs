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

ActiveRecord::Schema.define(version: 20130728231157) do

  create_table "banneres", force: true do |t|
    t.string   "nome"
    t.string   "link"
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",          default: 999
  end

  create_table "editables", force: true do |t|
    t.string   "key"
    t.text     "text"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mensagens", force: true do |t|
    t.string   "nome"
    t.string   "email"
    t.string   "telefone"
    t.text     "mensagem"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paginas", force: true do |t|
    t.string   "url"
    t.string   "title"
    t.string   "description"
    t.text     "metatags"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuarios", force: true do |t|
    t.string   "email",                  default: "",        null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "nome"
    t.string   "grupo",                  default: "usuario"
    t.boolean  "change_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true

end
