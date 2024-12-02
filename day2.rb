require 'dotenv/load'
require "open-uri"

#1 Read the given data

url = "https://adventofcode.com/2024/day/2/input"
cookie = "session=#{ENV['AOC_SESSION']}"

begin
  reports_str = URI.open(url, "Cookie" => cookie).read
rescue OpenURI::HTTPError => e
  puts "Failed to fetch input: #{e.message}"
end


#2 Making arrays
reports_arr = reports_str.split("\n") # Transforming the string into an array.
reports = reports_arr.map { |array| array.split.map(&:to_i) }
puts reports.count == reports_arr.count
