require_relative "../config/environment.rb"

def guest_with_most_appearances
  sql = <<-SQL
    SELECT name 
    FROM guests
    GROUP BY name
    ORDER BY COUNT(name) DESC
    LIMIT 1
  SQL
  DB.execute(sql).first
end

def most_popular_profession_by_year
# What was the most popular profession of guest for each year Jon Stewart hosted the Daily Show?
  sql = <<-SQL
  SELECT a.year, a.occupation 
  FROM (
    SELECT year, occupation, id
    FROM guests
    GROUP BY year, occupation
    ORDER BY COUNT(id) DESC
  ) a
  GROUP BY a.year;
  SQL
  DB.execute(sql)
end

def most_profession_overall
# What profession was on the show most overall?
  sql = <<-SQL
  SELECT occupation 
  FROM guests
  GROUP BY occupation
  ORDER BY COUNT(occupation) DESC
  LIMIT 1
  SQL
  DB.execute(sql).first
end

def most_bills
# How many people did Jon Stewart have on with the first name of Bill?
  sql = <<-SQL
  SELECT COUNT(DISTINCT name) 
  FROM guests
  WHERE name LIKE "Bill%";
  SQL
  DB.execute(sql).first
end

def first_partrick_stewart
# What dates did Patrick Stewart appear on the show?
  sql = <<-SQL
  SELECT show_date
  FROM guests
  WHERE name = "Patrick Stewart";
  SQL
  DB.execute(sql)
end

def year_with_most_guests
# Which year had the most guests?
  sql = <<-SQL
  SELECT year 
  FROM guests
  GROUP BY year
  ORDER BY(year) DESC;
  LIMIT 1
  SQL
  DB.execute(sql).first
end

def most_popular_group_by_year
# What was the most popular "Group" for each year Jon Stewart hosted?
  sql = <<-SQL
  SELECT a.year, a.group_type 
  FROM (
    SELECT year, group_type, id
    FROM guests
    GROUP BY year, group_type
    ORDER BY COUNT(id) DESC
  ) a
  GROUP BY a.year;
  SQL
  DB.execute(sql)
end


# Active record refactors

def guest_with_most_appearances
  # sql = <<-SQL
  #   SELECT name 
  #   FROM guests
  #   GROUP BY name
  #   ORDER BY COUNT(name) DESC
  #   LIMIT 1
  # SQL
  # DB.execute(sql).first
  Guest.select(:name).order(Guest[:name].count).reverse_order.group(:name).limit(1)
end

def most_popular_profession_by_year
# What was the most popular profession of guest for each year Jon Stewart hosted the Daily Show?
  sql = <<-SQL
  SELECT a.year, a.occupation 
  FROM (
    SELECT year, occupation, id
    FROM guests
    GROUP BY year, occupation
    ORDER BY COUNT(id) DESC
  ) a
  GROUP BY a.year;
  SQL
  DB.execute(sql)
end

def most_profession_overall
# What profession was on the show most overall?
  sql = <<-SQL
  SELECT occupation 
  FROM guests
  GROUP BY occupation
  ORDER BY COUNT(occupation) DESC
  LIMIT 1
  SQL
  DB.execute(sql).first
  # Guest.select(:occupation).order(Guest[:occupation].count).reverse_order.group(:occupation).limit(1)
end

def most_bills
# How many people did Jon Stewart have on with the first name of Bill?
  sql = <<-SQL
  SELECT COUNT(DISTINCT name) 
  FROM guests
  WHERE name LIKE "Bill%";
  SQL
  DB.execute(sql).first
  # Guest.select(Guest[:name].count).where(:name)
end

def first_partrick_stewart
# What dates did Patrick Stewart appear on the show?
  sql = <<-SQL
  SELECT show_date
  FROM guests
  WHERE name = "Patrick Stewart";
  SQL
  DB.execute(sql)
end

def year_with_most_guests
# Which year had the most guests?
  sql = <<-SQL
  SELECT year 
  FROM guests
  GROUP BY year
  ORDER BY(year) DESC;
  LIMIT 1
  SQL
  DB.execute(sql).first
  # Guest.select(:year).order(:year).reverse_order.group(:year)
end

def most_popular_group_by_year
# What was the most popular "Group" for each year Jon Stewart hosted?
  sql = <<-SQL
  SELECT a.year, a.group_type 
  FROM (
    SELECT year, group_type, id
    FROM guests
    GROUP BY year, group_type
    ORDER BY COUNT(id) DESC
  ) a
  GROUP BY a.year;
  SQL
  DB.execute(sql)
end

puts ""
puts "guest_with_most_appearances= #{guest_with_most_appearances}"
puts "most_popular_profession_by_year= #{most_popular_profession_by_year}"
puts "most_profession_overall= #{most_profession_overall}"
puts "most_bills= #{most_bills}"
puts "first_partrick_stewart= #{first_partrick_stewart}"
puts "year_with_most_guests= #{year_with_most_guests}"
puts "most_popular_group_by_year= #{most_popular_group_by_year}"
puts ""

# binding.pry
# 0



