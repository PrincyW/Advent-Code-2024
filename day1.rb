require "open-uri"

url = "https://adventofcode.com/2024/day/1/input"
lists = URI.open(url)
p lists
