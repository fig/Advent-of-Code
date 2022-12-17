require_relative "head"
require_relative "follower"

module Day09
  class Rope
    attr_reader :length, :members

    def initialize(length)
      @length = length
      @members = []
      add_knots
    end

    def [](index)
      members[index]
    end

    def head
      members.first
    end

    private

    def add_knots
      members << Head.new
      (length - 1).times do
        follower = Follower.new
        members.last.follower = follower
        members << follower
      end
    end
  end
end
