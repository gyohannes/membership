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

ActiveRecord::Schema.define(version: 20190606141838) do

  create_table "budget_years", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.date "from"
    t.date "to"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "educations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "person_id"
    t.string "institution_name"
    t.string "study_field"
    t.string "qualification"
    t.date "from"
    t.date "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_educations_on_person_id"
  end

  create_table "facilities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "facility_type_id"
    t.string "code"
    t.bigint "organization_unit_id"
    t.string "ownership"
    t.string "contact_person"
    t.string "contact_phone"
    t.string "contact_email"
    t.string "url"
    t.integer "latitude"
    t.integer "longitude"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_type_id"], name: "index_facilities_on_facility_type_id"
    t.index ["organization_unit_id"], name: "index_facilities_on_organization_unit_id"
  end

  create_table "facility_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "institution_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "institutions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "institution_type_id"
    t.string "address"
    t.string "url"
    t.string "contact_person"
    t.string "email"
    t.string "phone"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.integer "logo_file_size"
    t.datetime "logo_updated_at"
    t.index ["institution_type_id"], name: "index_institutions_on_institution_type_id"
  end

  create_table "languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "membership_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mp_amount_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "mp_year_id"
    t.bigint "membership_type_id"
    t.float "amount", limit: 24
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["membership_type_id"], name: "index_mp_amount_settings_on_membership_type_id"
    t.index ["mp_year_id"], name: "index_mp_amount_settings_on_mp_year_id"
  end

  create_table "mp_years", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.date "from"
    t.date "to"
    t.boolean "status"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organization_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organization_units", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "short_name"
    t.string "code"
    t.bigint "organization_type_id"
    t.integer "parent_organization_unit_id"
    t.string "url"
    t.string "contact_person"
    t.string "contact_phone"
    t.string "contact_email"
    t.float "latitude", limit: 24
    t.float "longitude", limit: 24
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_type_id"], name: "index_organization_units_on_organization_type_id"
  end

  create_table "payments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "person_id"
    t.bigint "mp_year_id"
    t.text "remark"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.index ["mp_year_id"], name: "index_payments_on_mp_year_id"
    t.index ["person_id"], name: "index_payments_on_person_id"
  end

  create_table "people", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.string "gender"
    t.string "email"
    t.string "phone_number"
    t.string "address"
    t.string "country"
    t.bigint "institution_id"
    t.bigint "organization_unit_id"
    t.bigint "facility_id"
    t.bigint "user_id"
    t.string "job_title"
    t.bigint "profession_category_id"
    t.bigint "profession_id"
    t.bigint "membership_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.index ["facility_id"], name: "index_people_on_facility_id"
    t.index ["institution_id"], name: "index_people_on_institution_id"
    t.index ["membership_type_id"], name: "index_people_on_membership_type_id"
    t.index ["organization_unit_id"], name: "index_people_on_organization_unit_id"
    t.index ["profession_category_id"], name: "index_people_on_profession_category_id"
    t.index ["profession_id"], name: "index_people_on_profession_id"
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "profession_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "professions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "profession_category_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profession_category_id"], name: "index_professions_on_profession_category_id"
  end

  create_table "program_areas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trainee_distributions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "training_id"
    t.bigint "organization_unit_id"
    t.integer "number_of_trainees"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_unit_id"], name: "index_trainee_distributions_on_organization_unit_id"
    t.index ["training_id"], name: "index_trainee_distributions_on_training_id"
  end

  create_table "trainees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "training_id"
    t.bigint "person_id"
    t.float "pre_training_score", limit: 24
    t.float "post_training_score", limit: 24
    t.string "status"
    t.string "training_interest"
    t.text "trainer_feedback"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_trainees_on_person_id"
    t.index ["training_id"], name: "index_trainees_on_training_id"
  end

  create_table "trainer_languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "trainer_profile_id"
    t.bigint "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_trainer_languages_on_language_id"
    t.index ["trainer_profile_id"], name: "index_trainer_languages_on_trainer_profile_id"
  end

  create_table "trainer_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "person_id"
    t.string "trainer_type"
    t.string "primary_job"
    t.string "secondary_job"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_trainer_profiles_on_person_id"
  end

  create_table "trainer_training_titles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "trainer_profile_id"
    t.bigint "training_title_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trainer_profile_id"], name: "index_trainer_training_titles_on_trainer_profile_id"
    t.index ["training_title_id"], name: "index_trainer_training_titles_on_training_title_id"
  end

  create_table "trainers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "training_id"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_trainers_on_person_id"
    t.index ["training_id"], name: "index_trainers_on_training_id"
  end

  create_table "training_funds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "training_id"
    t.bigint "institution_id"
    t.float "amount", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_training_funds_on_institution_id"
    t.index ["training_id"], name: "index_training_funds_on_training_id"
  end

  create_table "training_materials", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "training_title_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.index ["training_title_id"], name: "index_training_materials_on_training_title_id"
  end

  create_table "training_methods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "training_titles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.bigint "program_area_id"
    t.float "duration", limit: 24
    t.string "duration_in"
    t.integer "maximum_number_of_participants"
    t.bigint "training_method_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "topic_image_file_name"
    t.string "topic_image_content_type"
    t.integer "topic_image_file_size"
    t.datetime "topic_image_updated_at"
    t.index ["program_area_id"], name: "index_training_titles_on_program_area_id"
    t.index ["training_method_id"], name: "index_training_titles_on_training_method_id"
  end

  create_table "trainings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "organization_unit_id"
    t.bigint "training_title_id"
    t.bigint "budget_year_id"
    t.string "training_type"
    t.string "category"
    t.date "start_time"
    t.date "end_time"
    t.bigint "institution_id"
    t.string "location"
    t.text "description"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_year_id"], name: "index_trainings_on_budget_year_id"
    t.index ["institution_id"], name: "index_trainings_on_institution_id"
    t.index ["organization_unit_id"], name: "index_trainings_on_organization_unit_id"
    t.index ["training_title_id"], name: "index_trainings_on_training_title_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "role_id"
    t.string "user_name"
    t.integer "organization_unit_id"
    t.integer "facility_id"
    t.integer "institution_id"
    t.string "user_type"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_experiences", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "person_id"
    t.string "company"
    t.string "job_title"
    t.date "from"
    t.date "to"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_work_experiences_on_person_id"
  end

  add_foreign_key "educations", "people"
  add_foreign_key "facilities", "facility_types"
  add_foreign_key "facilities", "organization_units"
  add_foreign_key "institutions", "institution_types"
  add_foreign_key "mp_amount_settings", "membership_types"
  add_foreign_key "mp_amount_settings", "mp_years"
  add_foreign_key "organization_units", "organization_types"
  add_foreign_key "payments", "mp_years"
  add_foreign_key "payments", "people"
  add_foreign_key "people", "facilities"
  add_foreign_key "people", "institutions"
  add_foreign_key "people", "membership_types"
  add_foreign_key "people", "organization_units"
  add_foreign_key "people", "profession_categories"
  add_foreign_key "people", "professions"
  add_foreign_key "people", "users"
  add_foreign_key "professions", "profession_categories"
  add_foreign_key "trainee_distributions", "organization_units"
  add_foreign_key "trainee_distributions", "trainings"
  add_foreign_key "trainees", "people"
  add_foreign_key "trainees", "trainings"
  add_foreign_key "trainer_languages", "languages"
  add_foreign_key "trainer_languages", "trainer_profiles"
  add_foreign_key "trainer_profiles", "people"
  add_foreign_key "trainer_training_titles", "trainer_profiles"
  add_foreign_key "trainer_training_titles", "training_titles"
  add_foreign_key "trainers", "people"
  add_foreign_key "trainers", "trainings"
  add_foreign_key "training_funds", "institutions"
  add_foreign_key "training_funds", "trainings"
  add_foreign_key "training_materials", "training_titles"
  add_foreign_key "training_titles", "program_areas"
  add_foreign_key "training_titles", "training_methods"
  add_foreign_key "trainings", "budget_years"
  add_foreign_key "trainings", "institutions"
  add_foreign_key "trainings", "organization_units"
  add_foreign_key "trainings", "training_titles"
  add_foreign_key "work_experiences", "people"
end
