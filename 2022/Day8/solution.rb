#!/usr/bin/env ruby

class Solution
  def test_data
    # <<~TEST
    #   30373
    #   25512
    #   65332
    #   33549
    #   35390
    # TEST
  end

  def input
    test_data || ::File.read(::File.join(__dir__, "input.txt"))
  end

  def forest
    @forest ||= input.split("\n").map(&:chars)
  end

  def part1
    forest.each { |row| sight row }
    forest.transpose.each { |row| sight row }
    forest.flatten.count { |tree| !tree.include?("xxxx") }
  end

  def sight(row)
    annotate row
    annotate row.reverse
  end

  def annotate(row)
    row.map.with_object("-") do |tree, memo|
      if memo < tree[0]
        memo.tr! memo, tree[0]
      else
        tree << "x"
      end
    end
  end

  def part2
    forest.each do |row|
      row.map! { |tree| [tree, []] }
      row.map.with_index do |tuple, i|
        tree, score = tuple
        if i.zero?
          [tree, score << 0]
        else
          (1..).each do |c|
            break [tree, score << c] if c == i
            next if row[i - c][0] < tree
            break [tree, score << c] if row[i - c][0] >= tree
            break [tree, score << c] if row[i - c].nil?
          end
        end
      end
      row.reverse!.map.with_index do |tuple, i|
        tree, score = tuple
        if i.zero?
          [tree, score << 0]
        else
          (1..).each do |c|
            break [tree, score << c] if c == i
            next if row[i - c][0] < tree
            break [tree, score << c] if row[i - c][0] >= tree
            break [tree, score << c] if row[i - c].nil?
          end
        end
      end
    end

    forest.transpose.each do |row|
      row.map.with_index do |tuple, i|
        tree, score = tuple
        if i.zero?
          [tree, score << 0]
        else
          (1..).each do |c|
            break [tree, score << c] if c == i
            next if row[i - c][0] < tree
            break [tree, score << c] if row[i - c][0] >= tree
            break [tree, score << c] if row[i - c].nil?
          end
        end
      end
      row.reverse!.map.with_index do |tuple, i|
        tree, score = tuple
        if i.zero?
          [tree, score << 0]
        else
          (1..).each do |c|
            break [tree, score << c] if c == i
            next if row[i - c][0] < tree
            break [tree, score << c] if row[i - c][0] >= tree
            break [tree, score << c] if row[i - c].nil?
          end
        end
      end
    end

    forest.flatten(1)
          .map! { |_, score| score }
          .map! { |score| score.inject(:*) }
          .max
  end
end

puts "Part1: #{Solution.new.part1}"
puts "Part2: #{Solution.new.part2}"
# 1827
# 335580

## Super elegant solution by /u/tobyaw
## [https://www.reddit.com/r/adventofcode/comments/zfpnka/2022_day_8_solutions/ize38wc/]
## [https://github.com/tobyaw/advent-of-code-2022]
#
# def process(row)
#   row.reduce([-1]) do |memo, cell|
#     cell[:visible] = true if cell[:height] > memo.max
#     cell[:scores] << ((memo.index { |i| i >= cell[:height] } || (memo.size - 2)) + 1)
#     [cell[:height]] + memo
#   end
# end

# input = File.readlines('day_08_input.txt', chomp: true)
#             .map { |i| i.chars.map { |j| { height: j.to_i, visible: false, scores: [] } } }

# [input, input.transpose].each { |i| i.each { |j| [j, j.reverse].each { |k| process k } } }

# puts input.flatten.select { |i| i[:visible].eql? true }.count
# puts input.flatten.map { |i| i[:scores].reduce(:*) }.max
