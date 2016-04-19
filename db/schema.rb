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

ActiveRecord::Schema.define(version: 20160419203548) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_logs", force: :cascade do |t|
    t.integer  "organization_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "message"
    t.integer  "loggeable_id"
    t.string   "loggeable_type"
  end

  add_index "activity_logs", ["loggeable_type", "loggeable_id"], name: "index_activity_logs_on_loggeable_type_and_loggeable_id", using: :btree

  create_table "administrators", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "administrators", ["organization_id"], name: "index_administrators_on_organization_id", using: :btree
  add_index "administrators", ["user_id"], name: "index_administrators_on_user_id", using: :btree

  create_table "catalogs", force: :cascade do |t|
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",       default: false
    t.datetime "publish_date"
    t.string   "author"
  end

  add_index "catalogs", ["organization_id"], name: "index_catalogs_on_organization_id", using: :btree

  create_table "dataset_sectors", force: :cascade do |t|
    t.integer  "sector_id"
    t.integer  "dataset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dataset_sectors", ["dataset_id"], name: "index_dataset_sectors_on_dataset_id", using: :btree
  add_index "dataset_sectors", ["sector_id"], name: "index_dataset_sectors_on_sector_id", using: :btree

  create_table "datasets", force: :cascade do |t|
    t.text     "title"
    t.text     "description"
    t.text     "keyword"
    t.datetime "modified"
    t.string   "contact_point"
    t.string   "mbox"
    t.string   "temporal"
    t.string   "spatial"
    t.text     "landing_page"
    t.string   "accrual_periodicity"
    t.integer  "catalog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "publish_date"
    t.string   "contact_position"
    t.boolean  "public_access",       default: true
    t.boolean  "editable",            default: true
  end

  add_index "datasets", ["catalog_id"], name: "index_datasets_on_catalog_id", using: :btree

  create_table "designation_files", force: :cascade do |t|
    t.string   "file"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "designation_files", ["organization_id"], name: "index_designation_files_on_organization_id", using: :btree

  create_table "distributions", force: :cascade do |t|
    t.text     "title"
    t.text     "description"
    t.text     "download_url"
    t.string   "media_type"
    t.integer  "byte_size"
    t.string   "temporal"
    t.string   "spatial"
    t.integer  "dataset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "modified"
    t.string   "state"
  end

  add_index "distributions", ["dataset_id"], name: "index_distributions_on_dataset_id", using: :btree

  create_table "inventories", force: :cascade do |t|
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authorization_file"
    t.string   "designation_file"
  end

  add_index "inventories", ["organization_id"], name: "index_inventories_on_organization_id", using: :btree

  create_table "liaisons", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "liaisons", ["organization_id"], name: "index_liaisons_on_organization_id", using: :btree
  add_index "liaisons", ["user_id"], name: "index_liaisons_on_user_id", using: :btree

  create_table "opening_plan_logs", force: :cascade do |t|
    t.integer  "organization_id"
    t.json     "opening_plan"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "opening_plan_logs", ["organization_id"], name: "index_opening_plan_logs_on_organization_id", using: :btree

  create_table "organization_sectors", force: :cascade do |t|
    t.integer  "sector_id"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organization_sectors", ["organization_id"], name: "index_organization_sectors_on_organization_id", using: :btree
  add_index "organization_sectors", ["sector_id"], name: "index_organization_sectors_on_sector_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.text     "description"
    t.string   "logo_url"
    t.integer  "gov_type"
    t.text     "landing_page"
  end

  add_index "organizations", ["gov_type"], name: "index_organizations_on_gov_type", using: :btree
  add_index "organizations", ["slug"], name: "index_organizations_on_slug", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "sectors", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "sectors", ["slug"], name: "index_sectors_on_slug", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["organization_id"], name: "index_users_on_organization_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  add_foreign_key "designation_files", "organizations"
  add_foreign_key "opening_plan_logs", "organizations"
end
