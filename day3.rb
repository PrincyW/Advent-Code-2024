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
