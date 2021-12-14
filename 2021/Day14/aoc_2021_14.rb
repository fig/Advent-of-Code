polymer_template, pair_insertion_rules = ARGF.read.split("\n\n")

rules         = {}
current_pairs = Hash.new(0)
element_tally = Hash.new(0)

pair_insertion_rules.each_line(chomp: true) do |line|
  pair, insert = line.split(" -> ")
  rules[pair]  = insert
end

polymer_template.chars.each_cons(2) { |pair| current_pairs[pair.join] += 1 }
polymer_template.chars.each { |char| element_tally[char] += 1 }

40.times do |step|
  if step == 10
    min, max = element_tally.minmax_by { |_k, v| v }
    puts "part 1: #{max[1] - min[1]}"
  end

  current_pairs.clone.each do |pair, pair_occurances|
    element_to_be_insert = rules[pair]

    element_tally[element_to_be_insert]           += pair_occurances
    current_pairs[pair]                           -= pair_occurances
    current_pairs[pair[0] + element_to_be_insert] += pair_occurances
    current_pairs[element_to_be_insert + pair[1]] += pair_occurances
  end
end

min, max = element_tally.minmax_by { |_k, v| v }
puts "part 2: #{max[1] - min[1]}"
