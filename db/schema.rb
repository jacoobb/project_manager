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

ActiveRecord::Schema.define(version: 20140312110616) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "email"
    t.string   "matricula_number"
    t.string   "pesel"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students_subjects", force: true do |t|
    t.integer "student_id"
    t.integer "subject_id"
  end

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.string   "subject_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects_teachers", force: true do |t|
    t.integer "teacher_id"
    t.integer "subject_id"
  end

  create_table "teachers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "academic_title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
