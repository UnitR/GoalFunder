# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_04_172014) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "controllers", force: :cascade do |t|
    t.string "testcontroller"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "goal_owners", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.bigint "goal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["goal_id"], name: "index_goal_owners_on_goal_id"
    t.index ["group_id"], name: "index_goal_owners_on_group_id"
    t.index ["user_id"], name: "index_goal_owners_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string "name"
    t.float "target"
    t.text "keywords", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "goals_reports", force: :cascade do |t|
    t.date "date_generated"
    t.string "report_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "invites", force: :cascade do |t|
    t.string "email"
    t.integer "group_id"
    t.integer "sender_id"
    t.integer "recipient_id"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "organisation_details", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "address"
    t.string "telephone"
    t.string "website"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_organisation_details_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "goal_id", null: false
    t.float "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "pp_id"
    t.index ["goal_id"], name: "index_payments_on_goal_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.jsonb "image_data"
    t.bigint "user_id"
    t.bigint "group_id"
    t.bigint "goal_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["goal_id"], name: "index_photos_on_goal_id"
    t.index ["group_id"], name: "index_photos_on_group_id"
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "user_group_memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_user_group_memberships_on_group_id"
    t.index ["user_id"], name: "index_user_group_memberships_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "is_organisation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.boolean "is_admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["is_organisation"], name: "index_users_on_is_organisation"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "goal_owners", "goals"
  add_foreign_key "goal_owners", "groups"
  add_foreign_key "goal_owners", "users"
  add_foreign_key "groups", "users"
  add_foreign_key "organisation_details", "users"
  add_foreign_key "payments", "goals"
  add_foreign_key "payments", "users"
  add_foreign_key "photos", "goals"
  add_foreign_key "photos", "groups"
  add_foreign_key "photos", "users"
  add_foreign_key "user_group_memberships", "groups"
  add_foreign_key "user_group_memberships", "users"

  create_view "report_goals", sql_definition: <<-SQL
      SELECT g.name AS goal_name,
      g.created_at AS goal_created_at,
      g.target AS goal_target,
      sum(p.amount) AS goal_funded,
      u.last_name AS user_last_name,
      u.first_name AS user_first_name,
      u.email AS user_email,
      g.keywords
     FROM (((goals g
       JOIN goal_owners go ON ((g.id = go.goal_id)))
       JOIN payments p ON ((g.id = p.goal_id)))
       JOIN users u ON ((go.user_id = u.id)))
    GROUP BY g.name, g.created_at, g.target, u.last_name, u.first_name, u.email, g.keywords;
  SQL
  create_view "user_goals_alls", sql_definition: <<-SQL
      SELECT g.id AS goal_id,
      g.name AS goal_name,
      g.target AS goal_target,
      grp.id AS group_id,
      grp.name AS group_name,
      NULL::bigint AS user_id,
      sum(p.amount) AS contr_amount
     FROM (((((goals g
       LEFT JOIN goal_owners go ON ((g.id = go.goal_id)))
       LEFT JOIN groups grp ON ((grp.id = go.group_id)))
       LEFT JOIN user_group_memberships ugm ON ((grp.id = ugm.group_id)))
       LEFT JOIN users u ON ((ugm.user_id = u.id)))
       LEFT JOIN payments p ON ((u.id = p.user_id)))
    WHERE ((go.group_id IS NOT NULL) AND (go.user_id IS NULL))
    GROUP BY g.name, grp.id, grp.name, g.target, g.id
  UNION ALL
   SELECT g.id AS goal_id,
      g.name AS goal_name,
      g.target AS goal_target,
      NULL::bigint AS group_id,
      NULL::character varying AS group_name,
      u.id AS user_id,
      sum(p.amount) AS contr_amount
     FROM (((goals g
       LEFT JOIN goal_owners go ON ((g.id = go.goal_id)))
       LEFT JOIN users u ON ((u.id = go.user_id)))
       LEFT JOIN payments p ON ((p.user_id = u.id)))
    WHERE ((go.user_id IS NOT NULL) AND (go.group_id IS NULL))
    GROUP BY g.name, u.id, g.target, g.id;
  SQL
end
