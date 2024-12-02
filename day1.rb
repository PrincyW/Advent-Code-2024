require 'dotenv/load'
require "open-uri"

#1 Read the given data

url = "https://adventofcode.com/2024/day/1/input"
cookie = "session=#{ENV['AOC_SESSION']}"

begin
  lists = URI.open(url, "Cookie" => cookie).read
rescue OpenURI::HTTPError => e
  puts "Failed to fetch input: #{e.message}"
end



#2 Transform the data into 2 arrays

# The following method works ONLY with this format of data !

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


#3 Measuring the difference between the two lists

  def difference(array1, array2)
    array1.zip(array2).map { |a, b| (a - b).abs }.sum
  end


#5 Total distance

  def distance (input_string)
    separated_lists = separate_numbers(input_string)
    list1 = separated_lists[0]
    list2 = separated_lists[1]
    sorted_list1 = list1.sort
    sorted_list2 = list2.sort
    return difference(sorted_list1, sorted_list2)
  end



puts "The total distance is #{distance(lists)}"

#4 Similarity score

  def similarity_score (input_string)
    separated_lists = separate_numbers(input_string)
    list1 = separated_lists[0]
    list2 = separated_lists[1]
    score = 0
    list1.each do |number|
      appearances = list2.count(number)
      score = score + number*appearances
    end
    return score
  end


  puts "The similarity score is #{similarity_score(lists)}"
# ************************** TESTS **************************

# Example inputs
example = "3   4
4   3
2   5
1   3
3   9
3   3"

#PART 1
puts "Example : The total distance for the example is #{distance(example)}."

# PART 2
puts "Example : The similarity score is #{similarity_score(example)}"
