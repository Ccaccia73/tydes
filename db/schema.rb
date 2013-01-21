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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130121071651) do

  create_table "detections", :force => true do |t|
    t.integer  "user"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "code"
    t.text     "positive_trainingset"
    t.text     "value",                :limit => 255
    t.text     "positive_training"
    t.integer  "fn"
    t.integer  "fp"
    t.integer  "tn"
    t.integer  "tp"
    t.text     "negative_training"
    t.integer  "sight"
    t.integer  "currId"
    t.string   "nickname"
  end

  add_index "detections", ["code"], :name => "index_detections_on_code", :unique => true

  create_table "evalnegatives", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "dir"
    t.string   "image"
    t.integer  "x"
    t.integer  "y"
    t.integer  "detections"
    t.integer  "positives"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "evalnegatives", ["code"], :name => "index_evalnegatives_on_code", :unique => true

  create_table "evalpositives", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "dir"
    t.string   "image"
    t.integer  "x"
    t.integer  "y"
    t.integer  "positives"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "evalpositives", ["code"], :name => "index_evalpositives_on_code", :unique => true

  create_table "negatives", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "dir"
    t.string   "image"
    t.integer  "x"
    t.integer  "y"
    t.integer  "trainings"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "negatives", ["code"], :name => "index_negatives_on_code", :unique => true

  create_table "positives", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "dir"
    t.string   "image"
    t.integer  "x"
    t.integer  "y"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "positives", ["code"], :name => "index_positives_on_code", :unique => true

end
