# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_616_013_714) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'fetch_ais', force: :cascade do |t|
    t.string 'mood'
    t.string 'schedule'
    t.string 'how'
    t.string 'popularity'
    t.string 'quote_type'
    t.text 'response'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id'
    t.index ['user_id'], name: 'index_fetch_ais_on_user_id'
  end

  create_table 'first_parts', force: :cascade do |t|
    t.text 'content'
    t.bigint 'user_id', null: false
    t.bigint 'make_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['make_id'], name: 'index_first_parts_on_make_id'
    t.index ['user_id'], name: 'index_first_parts_on_user_id'
  end

  create_table 'information', force: :cascade do |t|
    t.integer 'visitor_id'
    t.integer 'visited_id'
    t.integer 'first_part_id'
    t.integer 'second_part_id'
    t.string 'action'
    t.boolean 'checked'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'make_id'
  end

  create_table 'likes', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'make_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['make_id'], name: 'index_likes_on_make_id'
    t.index %w[user_id make_id], name: 'index_likes_on_user_id_and_make_id', unique: true
    t.index ['user_id'], name: 'index_likes_on_user_id'
  end

  create_table 'makes', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_makes_on_user_id'
  end

  create_table 'second_parts', force: :cascade do |t|
    t.text 'content'
    t.bigint 'user_id', null: false
    t.bigint 'make_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['make_id'], name: 'index_second_parts_on_make_id'
    t.index ['user_id'], name: 'index_second_parts_on_user_id'
  end

  create_table 'sns_credentials', force: :cascade do |t|
    t.string 'provider'
    t.string 'uid'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_sns_credentials_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'name'
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'avatar'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'fetch_ais', 'users'
  add_foreign_key 'first_parts', 'makes'
  add_foreign_key 'first_parts', 'users'
  add_foreign_key 'likes', 'makes'
  add_foreign_key 'likes', 'users'
  add_foreign_key 'makes', 'users'
  add_foreign_key 'second_parts', 'makes'
  add_foreign_key 'second_parts', 'users'
  add_foreign_key 'sns_credentials', 'users'
end
