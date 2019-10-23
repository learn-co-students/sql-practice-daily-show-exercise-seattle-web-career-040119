require 'bundler'
Bundler.require

DB = SQLite3::Database.new("daily_show.db")