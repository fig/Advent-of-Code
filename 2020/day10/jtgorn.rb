# A bautiful solution posted on Reddit
# https://www.reddit.com/r/adventofcode/comments/ka8z8x/2020_day_10_solutions/gfcaf2q/

a = ARGF.readlines.map(&:to_i).sort!
x = (a.max - a.count) / 2
puts "Part 1: #{(a.count - x) * (x + 1)}"

c = [nil, nil, nil, 1]
a.each { |i| c[i + 3] = c[i..i + 2].compact.sum }
puts "Part 2: #{c.last}"
