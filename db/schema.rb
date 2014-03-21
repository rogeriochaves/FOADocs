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

ActiveRecord::Schema.define(version: 20140320235251) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "arquivos", force: true do |t|
    t.integer  "projeto_id"
    t.integer  "arquivo_id"
    t.string   "file_id"
    t.string   "nome"
    t.boolean  "diretorio"
    t.string   "mime_type"
    t.string   "etag"
    t.integer  "tamanho",      limit: 8
    t.string   "download_url"
    t.string   "icon_link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "arquivos", ["arquivo_id"], name: "index_arquivos_on_arquivo_id", using: :btree
  add_index "arquivos", ["projeto_id"], name: "index_arquivos_on_projeto_id", using: :btree

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

  create_table "comentarios", force: true do |t|
    t.integer  "usuario_id"
    t.integer  "versao_id"
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comentarios", ["usuario_id"], name: "index_comentarios_on_usuario_id", using: :btree
  add_index "comentarios", ["versao_id"], name: "index_comentarios_on_versao_id", using: :btree

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

  create_table "notificacoes", force: true do |t|
    t.integer  "arquivo_id"
    t.integer  "versao_id"
    t.integer  "comentario_id"
    t.integer  "usuario_id"
    t.string   "texto"
    t.boolean  "lido"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notificacoes", ["arquivo_id"], name: "index_notificacoes_on_arquivo_id", using: :btree
  add_index "notificacoes", ["comentario_id"], name: "index_notificacoes_on_comentario_id", using: :btree
  add_index "notificacoes", ["usuario_id"], name: "index_notificacoes_on_usuario_id", using: :btree
  add_index "notificacoes", ["versao_id"], name: "index_notificacoes_on_versao_id", using: :btree

  create_table "paginas", force: true do |t|
    t.string   "url"
    t.string   "title"
    t.string   "description"
    t.text     "metatags"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participantes", force: true do |t|
    t.integer  "usuario_id"
    t.integer  "projeto_id"
    t.string   "grupo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participantes", ["projeto_id"], name: "index_participantes_on_projeto_id", using: :btree
  add_index "participantes", ["usuario_id"], name: "index_participantes_on_usuario_id", using: :btree

  create_table "projetos", force: true do |t|
    t.string   "nome"
    t.string   "tipo"
    t.datetime "data_inicio"
    t.boolean  "fechado"
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
    t.string   "matricula"
    t.string   "turma"
    t.boolean  "change_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.string   "token"
    t.string   "refresh_token"
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree

  create_table "versoes", force: true do |t|
    t.integer  "arquivo_id"
    t.string   "revision_id"
    t.string   "download_url"
    t.text     "conteudo"
    t.text     "alteracao"
    t.datetime "modified_date"
    t.string   "last_modifying_user_name"
    t.integer  "tamanho",                  limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versoes", ["arquivo_id"], name: "index_versoes_on_arquivo_id", using: :btree

end
