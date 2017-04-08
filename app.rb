require 'csv'

$OFF = 0

def get_rand(n, m)
  f = (0...n).map { ('a'..'z').to_a[rand(26)] }.join
  s = (0...m).map{ ('0'..'9').to_a[rand(10)] }.join
  return f+s
end

def cap(s)
  return s.split.map{|x| x.length > 2 ? x.capitalize : x}.join(' ')
end

CSV.open("users.csv", "wb") do |csv|
  File.open("users.txt", "w"){|f|
    table = CSV.read("input.csv")
    table.slice!(0)

    f.puts "[user]"

    i = 1
    table.each do |row|
      login = "time#{i}"
      pass = get_rand(5, 3)
      i += 1

      row[1] = cap(row[1])
      row[2].capitalize!

      # csv
      out = [row[1], row[2], login, pass]
      csv << out

      # users.txt
      f.puts "usernumber=#{$OFF+i}"
      f.puts "usersitenumber=1"
      f.puts "username=#{login}"
      f.puts "userfullname=[#{row[2]}] #{row[1]}"
      f.puts "userenabled=t"
      f.puts "usermultilogin=t"
      f.puts "userpassword=#{pass}"
      f.puts

      # dump
      p out
    end
  }
end
