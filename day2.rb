require 'dotenv/load'
require "open-uri"

#1 Read the given data

url = "https://adventofcode.com/2024/day/2/input"
cookie = "session=#{ENV['AOC_SESSION']}"

begin
  data_str = URI.open(url, "Cookie" => cookie).read
rescue OpenURI::HTTPError => e
  puts "Failed to fetch input: #{e.message}"
end


#2 Making arrays
data = data_str.split("\n") # Transforming the string into an array.
reports = data.map { |array| array.split.map(&:to_i) }
# puts reports.count == data.count

#3 Getting the number of unsafe reports :
def safe_reports(array)
  safe = 0
  array.each do |report|
    if report.sort.uniq == report || report.sort.reverse.uniq == report
      if report.each_cons(2).all? { |a, b| (a - b).abs <= 3 }
        safe = safe + 1
      end
    end
  end
  return safe
end
puts "There are #{safe_reports(reports)} safe reports in the data"

# ************** TESTS *********************
example_str = "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"
example = example_str.split("\n")
example_reports = example.map { |array| array.split.map(&:to_i) }
puts "There are #{safe_reports(example_reports)} safe reports in the example"

example_str2 = "90 91 93 96 93
3 5 7 10 11 11
35 37 39 42 46
67 70 72 74 79
9 12 13 16 15 16 19
48 51 52 55 58 61 58 57
3 4 7 9 8 9 9
22 25 28 30 28 32
38 41 44 45 42 49
54 57 59 59 61"
example2 = example_str2.split("\n")
example_reports2 = example2.map { |array| array.split.map(&:to_i) }
puts "There are #{safe_reports(example_reports2)} safe reports in the example"
