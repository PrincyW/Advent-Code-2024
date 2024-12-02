require 'dotenv/load'
require "open-uri"

#1 Read the given data

url = "https://adventofcode.com/2024/day/2/input"
cookie = "session=#{ENV['AOC_SESSION']}"

begin
  records_str = URI.open(url, "Cookie" => cookie).read
  puts records_str
rescue OpenURI::HTTPError => e
  puts "Failed to fetch input: #{e.message}"
end
