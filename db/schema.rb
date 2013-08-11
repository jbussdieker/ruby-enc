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

ActiveRecord::Schema.define(:version => 20130811154049) do

  create_table "node_class_memberships", :force => true do |t|
    t.integer  "node_id"
    t.integer  "node_class_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "node_classes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "node_group_memberships", :force => true do |t|
    t.integer  "node_id"
    t.integer  "node_group_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "node_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "nodes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "reported_at"
    t.integer  "last_apply_report_id"
    t.string   "status"
    t.boolean  "hidden"
    t.integer  "last_inspect_report_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "nodes", ["name"], :name => "index_nodes_on_name", :unique => true

  create_table "parameters", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "parameterable_id"
    t.string   "parameterable_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "reports", :force => true do |t|
    t.integer  "node_id"
    t.string   "status"
    t.string   "environment"
    t.datetime "time"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "reports", ["node_id"], :name => "index_reports_on_node_id"

end
