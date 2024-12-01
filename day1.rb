require "open-uri"

#1 Read the given data

url = "https://adventofcode.com/2024/day/1/input"
cookie = "session=53616c7465645f5fd698bebda299f4b28fd4a719fcbd421e327c50a819e733878d9618bb5cc1e5ea6408ae5e569fbadef95ed4461c46292c75ba07c8263ee2f3"

begin
  lists = URI.open(url, "Cookie" => cookie).read
  # puts lists[13]
  # puts lists[14]
  # puts lists[15]
  # puts lists[16]
  # p lists.class
rescue OpenURI::HTTPError => e
  puts "Failed to fetch input: #{e.message}"
end


#2 Transform the data into 2 arrays

def separate_numbers(input_string)
  # Split the input into lines
  lines = input_string.strip.split("\n")

  # Initialize the two arrays
  array1 = []
  array2 = []

  # Process each line
  lines.each do |line|
    # Extract the two numbers based on their format
    numbers = line.split(/\s+/) # Split on spaces (1 or more) using a regex
    array1 << numbers[0].to_i
    array2 << numbers[1].to_i
  end

  [array1, array2]
end

# Example input
input = <<~NUMBERS
  82728   61150
  39850   94024
  24609   43406
  24964   98661
  16230   17299
NUMBERS

# Call the function and print the results
result = separate_numbers(input)
puts "Array 1: #{result[0]}"
puts "Array 2: #{result[1]}"



#3 Order the arrays
