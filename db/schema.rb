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

ActiveRecord::Schema.define(:version => 20110321111206) do

  create_table "album_artistships", :force => true do |t|
    t.integer  "album_id"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "album_songships", :force => true do |t|
    t.integer  "album_id"
    t.integer  "song_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "Trackno"
    t.integer  "CDno",       :default => 1
  end

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.date     "release_date"
    t.string   "album_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.string   "artist_type"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "male_female_group"
    t.integer  "city_id"
    t.integer  "MBID"
    t.string   "last_name"
    t.string   "first_name"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.string   "nation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "singer_relationships", :force => true do |t|
    t.integer  "song_id"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "singer_relationships", ["artist_id"], :name => "index_singer_relationships_on_artist_id"
  add_index "singer_relationships", ["song_id", "artist_id"], :name => "index_singer_relationships_on_song_id_and_artist_id", :unique => true
  add_index "singer_relationships", ["song_id"], :name => "index_singer_relationships_on_song_id"

  create_table "songs", :force => true do |t|
    t.string   "name"
    t.text     "lyric"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "user_like_songs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "song_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
    t.integer  "fb_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
