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

ActiveRecord::Schema.define(version: 20170410125237) do

  create_table "communes", force: :cascade do |t|
    t.string   "name"
    t.string   "code_insee"
    t.integer  "intercommunality_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "population"
    t.index ["intercommunality_id"], name: "index_communes_on_intercommunality_id"
  end

  create_table "intercommunalities", force: :cascade do |t|
    t.string   "name"
    t.string   "siren"
    t.string   "form"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "street_communes", force: :cascade do |t|
    t.integer  "street_id"
    t.integer  "commune_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commune_id"], name: "index_street_communes_on_commune_id"
    t.index ["street_id"], name: "index_street_communes_on_street_id"
  end

  create_table "streets", force: :cascade do |t|
    t.string   "title"
    t.integer  "from"
    t.integer  "to"
    t.integer  "commune_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commune_id"], name: "index_streets_on_commune_id"
  end

end
