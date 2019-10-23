require_relative "../config/environment.rb"

sql = <<-SQL
  CREATE TABLE guests (
      id INTEGER PRIMARY KEY,
      year INTEGER,
      occupation TEXT,
      show_date TEXT,
      group_type TEXT,
      name TEXT
  );
SQL
DB.execute("DROP TABLE IF EXISTS guests")
DB.execute(sql)

CSV.foreach("daily_show_guests.csv", headers: true) do |row|
  DB.execute "INSERT INTO guests(year, occupation, show_date, group_type, name) VALUES (?, ?, ?, ?, ?)", row.fields 
end

puts ""
puts "Seeding is complete"
puts ""
puts DB.execute("SELECT * FROM guests LIMIT 1") 