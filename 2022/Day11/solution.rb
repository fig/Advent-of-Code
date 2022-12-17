#!/usr/bin/env ruby
require_relative "monkey"
class Solution
  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # <<~INPUT
    #   Monkey 0:
    #     Starting items: 79, 98
    #     Operation: new = old * 19
    #     Test: divisible by 23
    #       If true: throw to monkey 2
    #       If false: throw to monkey 3

    #   Monkey 1:
    #     Starting items: 54, 65, 75, 74
    #     Operation: new = old + 6
    #     Test: divisible by 19
    #       If true: throw to monkey 2
    #       If false: throw to monkey 0

    #   Monkey 2:
    #     Starting items: 79, 60, 97
    #     Operation: new = old * old
    #     Test: divisible by 13
    #       If true: throw to monkey 1
    #       If false: throw to monkey 3

    #   Monkey 3:
    #     Starting items: 74
    #     Operation: new = old + 3
    #     Test: divisible by 17
    #       If true: throw to monkey 0
    #       If false: throw to monkey 1
    # INPUT
  end

  def monkeys
    @monkeys ||= input.split("\n\n").map! { |monkey| Monkey.new(monkey) }
  end

  def part1
    20.times do
      monkeys.each do |monkey|
        while monkey.starting_items.any?
          item = monkey.starting_items.shift
          worry_level = calculate(item, monkey.operation)
          worry_level /= 3
          if (worry_level % monkey.test).zero?
            monkeys[monkey.if_true].starting_items << worry_level
          else
            monkeys[monkey.if_false].starting_items << worry_level
          end
          monkey.items_inspected += 1
        end
      end
    end
    monkeys.map(&:items_inspected).max(2).inject(:*)
  end

  def part2
    10_000.times do
      monkeys.each do |monkey|
        while monkey.starting_items.any?
          item = monkey.starting_items.shift % monkeys.map(&:test).reduce(:lcm)
          worry_level = calculate(item, monkey.operation)
          if (worry_level % monkey.test).zero?
            monkeys[monkey.if_true].starting_items << worry_level
          else
            monkeys[monkey.if_false].starting_items << worry_level
          end
          monkey.items_inspected += 1
        end
      end
    end
    monkeys.map(&:items_inspected).max(2).inject(:*)
  end

  def calculate(item, operation)
    case operation[1]
    when "old"
      item.public_send(operation[0], item)
    else
      item.public_send(operation[0].to_sym, operation[1].to_i)
    end
  end
end

puts "Part1: #{Solution.new.part1}"
puts "Part2: #{Solution.new.part2}"

# 120384
# 32059801242
