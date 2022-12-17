require_relative "rope"

module Day09
  class Solution
    attr_reader :rope

    def initialize(length)
      @rope = Rope.new(length)
      move_rope
    end

    def uniq_locations(member)
      rope[member].trail.uniq.count
    end

    private

    def move_rope
      motions.each do |motion|
        rope.head.move(motion)
      end
    end

    def input
      File.read(File.join(__dir__, "input.txt"))
    end

    def motions
      input.split("\n").map(&:split)
    end
  end
end

s = Day09::Solution.new(10)
puts s.uniq_locations(1)
puts s.uniq_locations(9)

# 5513
# 2427
