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

ActiveRecord::Schema.define(version: 20150113234806) do

  create_table "boards", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "puzzles", force: true do |t|
    t.boolean  "complete"
    t.text     "board"
    t.text     "guess"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "0, 0"
    t.string   "0, 1"
    t.string   "0, 2"
    t.string   "0, 3"
    t.string   "0, 4"
    t.string   "0, 5"
    t.string   "0, 6"
    t.string   "0, 7"
    t.string   "0, 8"
    t.string   "1, 0"
    t.string   "1, 1"
    t.string   "1, 2"
    t.string   "1, 3"
    t.string   "1, 4"
    t.string   "1, 5"
    t.string   "1, 6"
    t.string   "1, 7"
    t.string   "1, 8"
    t.string   "2, 0"
    t.string   "2, 1"
    t.string   "2, 2"
    t.string   "2, 3"
    t.string   "2, 4"
    t.string   "2, 5"
    t.string   "2, 6"
    t.string   "2, 7"
    t.string   "2, 8"
    t.string   "3, 0"
    t.string   "3, 1"
    t.string   "3, 2"
    t.string   "3, 3"
    t.string   "3, 4"
    t.string   "3, 5"
    t.string   "3, 6"
    t.string   "3, 7"
    t.string   "3, 8"
    t.string   "4, 0"
    t.string   "4, 1"
    t.string   "4, 2"
    t.string   "4, 3"
    t.string   "4, 4"
    t.string   "4, 5"
    t.string   "4, 6"
    t.string   "4, 7"
    t.string   "4, 8"
    t.string   "5, 0"
    t.string   "5, 1"
    t.string   "5, 2"
    t.string   "5, 3"
    t.string   "5, 4"
    t.string   "5, 5"
    t.string   "5, 6"
    t.string   "5, 7"
    t.string   "5, 8"
    t.string   "6, 0"
    t.string   "6, 1"
    t.string   "6, 2"
    t.string   "6, 3"
    t.string   "6, 4"
    t.string   "6, 5"
    t.string   "6, 6"
    t.string   "6, 7"
    t.string   "6, 8"
    t.string   "7, 0"
    t.string   "7, 1"
    t.string   "7, 2"
    t.string   "7, 3"
    t.string   "7, 4"
    t.string   "7, 5"
    t.string   "7, 6"
    t.string   "7, 7"
    t.string   "7, 8"
    t.string   "8, 0"
    t.string   "8, 1"
    t.string   "8, 2"
    t.string   "8, 3"
    t.string   "8, 4"
    t.string   "8, 5"
    t.string   "8, 6"
    t.string   "8, 7"
    t.string   "8, 8"
  end

end
