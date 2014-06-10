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

ActiveRecord::Schema.define(version: 20140601081652) do

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["name"], name: "index_accounts_on_name", unique: true, using: :btree

  create_table "admins", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "postal_code"
    t.string   "province"
    t.string   "country"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "phone3"
    t.string   "fax"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["user_id"], name: "index_admins_on_user_id", using: :btree

  create_table "appointments", force: true do |t|
    t.string   "name"
    t.datetime "when"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "subject_id"
    t.integer  "length"
  end

  add_index "appointments", ["subject_id"], name: "index_appointments_on_subject_id", using: :btree

  create_table "appointments_students", id: false, force: true do |t|
    t.integer  "appointment_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "appointments_teachers", id: false, force: true do |t|
    t.integer  "appointment_id"
    t.integer  "teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "certifications", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_instance", force: true do |t|
    t.integer  "course_id"
    t.datetime "when"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_instance", ["course_id"], name: "index_course_instance_on_course_id", using: :btree

  create_table "course_instance_instructors", id: false, force: true do |t|
    t.integer "instructor_id",      null: false
    t.integer "course_instance_id", null: false
  end

  add_index "course_instance_instructors", ["course_instance_id", "instructor_id"], name: "cii_course_to_instructor", unique: true, using: :btree
  add_index "course_instance_instructors", ["instructor_id", "course_instance_id"], name: "cii_instructor_to_course", unique: true, using: :btree

  create_table "course_instance_students", id: false, force: true do |t|
    t.integer "student_id",         null: false
    t.integer "course_instance_id", null: false
  end

  add_index "course_instance_students", ["course_instance_id", "student_id"], name: "cis_course_to_student", unique: true, using: :btree
  add_index "course_instance_students", ["student_id", "course_instance_id"], name: "cis_student_to_course", unique: true, using: :btree

  create_table "courses", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.string   "status"
    t.integer  "length"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses_instructors", id: false, force: true do |t|
    t.integer "instructor_id", null: false
    t.integer "course_id",     null: false
  end

  add_index "courses_instructors", ["course_id", "instructor_id"], name: "index_courses_instructors_on_course_id_and_instructor_id", using: :btree
  add_index "courses_instructors", ["instructor_id", "course_id"], name: "index_courses_instructors_on_instructor_id_and_course_id", using: :btree

  create_table "disciplines", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "fq_transactions", force: true do |t|
    t.datetime "occured"
    t.string   "processor"
    t.decimal  "amount",      precision: 9, scale: 2
    t.integer  "account_id"
    t.boolean  "reconciled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "external_id"
    t.string   "description"
    t.text     "pay_object"
    t.string   "pay_method"
    t.string   "callback_id"
    t.boolean  "validated"
  end

  add_index "fq_transactions", ["account_id"], name: "index_fq_transactions_on_account_id", using: :btree
  add_index "fq_transactions", ["callback_id"], name: "index_fq_transactions_on_callback_id", using: :btree

  create_table "instructors", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "postal_code"
    t.string   "province"
    t.string   "country"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "phone3"
    t.string   "fax"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "instructors", ["user_id"], name: "index_instructors_on_user_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "skills", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "specialties", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "postal_code"
    t.string   "province"
    t.string   "country"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "phone3"
    t.string   "fax"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["user_id"], name: "index_students_on_user_id", using: :btree

  create_table "subjects", force: true do |t|
    t.integer  "discipline_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "skills_id"
    t.integer  "specialties_id"
    t.integer  "certifications_id"
    t.string   "about"
    t.string   "text"
  end

  add_index "teachers", ["certifications_id"], name: "index_teachers_on_certifications_id", using: :btree
  add_index "teachers", ["skills_id"], name: "index_teachers_on_skills_id", using: :btree
  add_index "teachers", ["specialties_id"], name: "index_teachers_on_specialties_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name",                   default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
