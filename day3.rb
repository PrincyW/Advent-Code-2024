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

#2 Method

puts "*************** PART 1 ***************"

def sum_multiplications(a_string)
  # Selection of the right multiplicators
  multiplications = a_string.scan(/mul\(\d{1,3},\d{1,3}\)/)
  sum = 0
  # Procession of the array
  multiplications.each do |mul|
    xy = mul.scan(/\d{1,3}/) # Selection of the numbers to multiply
    result = xy[0].to_i * xy[1].to_i
    sum = sum + result
  end
  return sum
end
puts "Original input : The sum of multiplication is #{sum_multiplications(memory)}"

# ************ TESTS ***************
example1 = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
example2 = "}mul(620,236)where()*@}!&[mul(589,126)]&^]mul(260,42 )when() when()$ ?{/^*mul(335,2509)>"

puts "Example 1: The sum of multiplication is #{sum_multiplications(example1)}"
puts "Example 2: The sum of multiplication is #{sum_multiplications(example2)}"


# PART 2

puts "*************** PART 2 ***************"

# Extraction of the correct "muls"

def extract_safe_muls(a_string)
  # Define the result array
  result = []

  # Split the string into sections based on "don't()"
  sections = a_string.split(/don't\(\)/)

  sections.each_with_index do |section, index|
    # Check if we're in the first section (before the first "don't()")
    if index == 0
      # Extract "mul(x,y)" in the section before the first "don't()"
      result.concat(section.scan(/mul\(\d{1,3},\d{1,3}\)/))
    else
      # For sections after "don't()", check if preceded by "do()"
      if section.include?("do()")
        # Extract all "mul(x,y)" after "do()" in the section
        # Ensure to only capture after the last "do()"
        valid_part = section.split("do()").last
        result.concat(valid_part.scan(/mul\(\d{1,3},\d{1,3}\)/))
      end
    end
  end

  result
end

# TESTS
example3 = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
example4 = "}mul(620,236)where()*@}!&[mul(589,126)]&^]mul(260,42)when() when()$ ?{/^*mul(335,250)>,@!<{when()+-$don't()*'^?+>>/%:mul(422,738),mul(694,717);~;%<[why()>@-mul(417,219)?&who(474,989){select()-{#mul(366,638)mul(773,126)/*{mul(757,799)]when()mul(778,467)^mul(487,365)]*'{where(952,954){?who()who()when()mul(172,666)#<do()why()~&why())'< {mul(33,475)}mul(916,60)what()?when()>?$,-mul(250,228)(]when()}<mul(817,274)'{})mul(836,930):@how()]!@'select()~?mul(514,457)from()&what()what()when()mul(872,884)select()<select()from()'!who()mul(11,966)/from()(~}#,"
puts "Example 3"
puts extract_safe_muls(example3)
puts "Example 4"
puts extract_safe_muls(example4)

# Sum of multiplications
def sum_safe_mul (a_string)
  safe_muls = extract_safe_muls(a_string)
  sum = 0
  # Procession of the array
  safe_muls.each do |mul|
    xy = mul.scan(/\d{1,3}/) # Selection of the numbers to multiply
    result = xy[0].to_i * xy[1].to_i
    sum = sum + result
  end
  return sum
end

puts "Original input : The sum of multiplications WITH conditions is #{sum_safe_mul(memory)}"
puts "Example 3 : The sum of multiplications WITH conditions is #{sum_safe_mul(example3)}"
puts "Example 4 : The sum of multiplications WITH conditions is #{sum_safe_mul(example4)}"
