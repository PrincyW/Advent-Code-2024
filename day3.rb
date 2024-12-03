require 'dotenv/load'
require "open-uri"

#1 Read the given data

url = "https://adventofcode.com/2024/day/3/input"
cookie = "session=#{ENV['AOC_SESSION']}"

begin
  memory = URI.open(url, "Cookie" => cookie).read
rescue OpenURI::HTTPError => e
  puts "Failed to fetch input: #{e.message}"
end
