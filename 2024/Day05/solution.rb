#!/usr/bin/env ruby

class Solution
  def input
    @input ||=
      File.read(File.join(__dir__, "input.txt"))
          .each_line
          .partition { |line| line.include?("|") }
  end

  def rules
    @rules ||=
      input[0].each_with_object({}) do |line, hash|
        pair = line.split("|").map(&:to_i)
        hash[pair] = true
      end
  end

  def updates
    @updates ||= input[1].map! { |update| update.split(",").map(&:to_i) }
  end

  def satisfies_rules? = ->(update) { update.each_cons(2).all? { |pair| rules[pair] } }

  def aoc_sort
    lambda { |update|
      update.each_cons(2).with_index { |pair, i|
        next if rules[pair]

        swap_pages[update, i]
        aoc_sort[update]
      }
    }
  end

  def swap_pages = ->(update, i) { update[i], update[i + 1] = update[i + 1], update[i] }

  def middle_page = ->(update) { update[update.size / 2] }

  def part1
    updates.select(&satisfies_rules?).sum(&middle_page)
  end

  def part2
    updates.reject(&satisfies_rules?).map!(&aoc_sort).sum(&middle_page)
  end

  def solutions
    p1 = part1
    p2 = part2
    puts "Part 1: #{p1} #{p1 == 5452 ? '✅' : '❌'}"
    puts "Part 2: #{p2} #{p2 == 4598 ? '✅' : '❌'}"
  end
end

Solution.new.solutions
