require "open-uri"

url = "https://adventofcode.com/2024/day/1/input"
cookie = "session=53616c7465645f5fd698bebda299f4b28fd4a719fcbd421e327c50a819e733878d9618bb5cc1e5ea6408ae5e569fbadef95ed4461c46292c75ba07c8263ee2f3"

begin
  lists = URI.open(url, "Cookie" => cookie).read
  puts lists
rescue OpenURI::HTTPError => e
  puts "Failed to fetch input: #{e.message}"
end
