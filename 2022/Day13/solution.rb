#!/usr/bin/env ruby
require "json"

class Solution
  class Packet
    include Comparable
    attr :raw

    def initialize(raw)
      @raw = JSON.parse(raw)
    end

    def <=>(other)
      compare raw, other.raw
    end

    def compare(left, right)
      return if left == right
      return -1 if left.empty?
      return 1 if right.empty?

      l_head, *l_tail = left
      r_head, *r_tail = right

      case [l_head, r_head]
      in [Integer, Integer]
        return -1 if l_head < r_head
        return 1 if l_head > r_head
      in [Array, Array]
        result = compare(l_head, r_head)
      in [Array, Integer]
        result = compare(l_head, [r_head])
      in [Integer, Array]
        result = compare([l_head], r_head)
      end

      result || compare(l_tail, r_tail)
    end
  end

  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # <<~DATA
    #   [1,1,3,1,1]
    #   [1,1,5,1,1]

    #   [[1],[2,3,4]]
    #   [[1],4]

    #   [9]
    #   [[8,7,6]]

    #   [[4,4],4,4]
    #   [[4,4],4,4,4]

    #   [7,7,7,7]
    #   [7,7,7]

    #   []
    #   [3]

    #   [[[]]]
    #   [[]]

    #   [1,[2,[3,[4,[5,6,7]]]],8,9]
    #   [1,[2,[3,[4,[5,6,0]]]],8,9]
    # DATA
  end

  def packets
    @packets ||= input.lines(chomp: true).reject(&:empty?)
  end

  def part1
    packets.map! { |packet| Packet.new(packet) }
           .each_slice(2)
           .with_index(1)
           .sum { |(a, b), i| a < b ? i : 0 }
  end

  def part2
    packets.concat ["[[2]]", "[[6]]"]
    packets.sort_by! { |packet| Packet.new(packet) }
    (packets.index("[[2]]") + 1) * (packets.index("[[6]]") + 1)
  end
end

puts Solution.new.part1
puts Solution.new.part2
# 5882
# 24948
