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

ActiveRecord::Schema.define(:version => 20131001123153) do

  create_table "forecast_todays", :force => true do |t|
    t.integer  "pref_id"
    t.datetime "time"
    t.float    "temp"
    t.float    "temp_min"
    t.float    "temp_max"
    t.float    "humidity"
    t.float    "pressure"
    t.string   "main"
    t.string   "description"
    t.string   "icon"
    t.float    "clouds"
    t.float    "windspeed"
    t.float    "winddeg"
    t.float    "rain"
    t.float    "snow"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "forecast_tomorrows", :force => true do |t|
    t.integer  "pref_id"
    t.datetime "time"
    t.float    "temp"
    t.float    "temp_min"
    t.float    "temp_max"
    t.float    "humidity"
    t.float    "pressure"
    t.string   "main"
    t.string   "description"
    t.string   "icon"
    t.float    "clouds"
    t.float    "windspeed"
    t.float    "winddeg"
    t.float    "rain"
    t.float    "snow"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "forecasts", :force => true do |t|
    t.integer  "pref_id"
    t.datetime "time"
    t.float    "temp"
    t.float    "temp_min"
    t.float    "temp_max"
    t.float    "humidity"
    t.float    "pressure"
    t.string   "main"
    t.string   "description"
    t.string   "icon"
    t.float    "clouds"
    t.float    "windspeed"
    t.float    "winddeg"
    t.float    "rain"
    t.float    "snow"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "prefs", :force => true do |t|
    t.string   "name"
    t.string   "capital"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "weathers", :force => true do |t|
    t.integer  "pref_id"
    t.float    "lat"
    t.float    "lon"
    t.datetime "sunset"
    t.string   "main"
    t.string   "description"
    t.string   "icon"
    t.float    "humidity"
    t.float    "pressure"
    t.float    "temp"
    t.float    "windspeed"
    t.float    "winddeg"
    t.float    "rain"
    t.float    "snow"
    t.float    "clouds"
    t.datetime "get_time"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.datetime "sunrise"
  end

end
