# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100131234711) do

  create_table "feed_items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.integer  "poster_id"
    t.datetime "post_created_at"
    t.datetime "created_at"
  end

  create_table "follows", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "following_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "new_user_id"
    t.datetime "redeemed_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mp3"
    t.string   "title"
    t.string   "artist"
    t.string   "album"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.integer  "posts_count",                        :default => 0, :null => false
    t.integer  "followings_count",                   :default => 0, :null => false
    t.integer  "followers_count",                    :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "password_salt"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "inviter_id"
    t.string   "email"
    t.string   "reset_password_token", :limit => 20
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

end
