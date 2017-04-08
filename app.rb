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
    @name = 1
    @tag = 5

    i = 1
    table.each do |row|
      login = "time#{i}"
      pass = get_rand(5, 3)

      row[@name] = cap(row[@name]).strip
      row[@tag] = row[@tag].upcase.strip

      # csv
      out = [row[@name], row[@tag], login, pass]
      csv << out

      # users.txt
      f.puts "usernumber=#{$OFF+i}"
      f.puts "usersitenumber=1"
      f.puts "username=#{login}"
      f.puts "userfullname=[#{row[@tag]}] #{row[@name]}"
      f.puts "userenabled=t"
      f.puts "usermultilogin=t"
      f.puts "userpassword=#{pass}"
      f.puts

      # dump
      p out
      i += 1
    end
  }
end
