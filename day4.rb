require 'dotenv/load'
require "open-uri"

#1 Read the given data

url = "https://adventofcode.com/2024/day/3/input"
cookie = "session=#{ENV['AOC_SESSION']}"

begin
  grid = URI.open(url, "Cookie" => cookie).read
rescue OpenURI::HTTPError => e
  puts "Failed to fetch input: #{e.message}"
end

#2 Program
# Steps
# Find the size of the grid
# Divide it into arrays : horizontal, vertical, diagonal
