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

ActiveRecord::Schema.define(version: 20140219030905) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_type_id"
  end

  add_index "categories", ["order_type_id"], name: "index_categories_on_order_type_id"

  create_table "order_types", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.string   "order"
    t.string   "note"
    t.integer  "order_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["order_type_id"], name: "index_orders_on_order_type_id"

  create_table "tasks", force: true do |t|
    t.string   "description"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["category_id"], name: "index_tasks_on_category_id"

  create_table "validations", force: true do |t|
    t.integer  "task_id"
    t.integer  "order_id"
    t.boolean  "approval"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "validations", ["order_id"], name: "index_validations_on_order_id"
  add_index "validations", ["task_id"], name: "index_validations_on_task_id"

end
