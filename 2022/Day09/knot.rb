module Day09
  class Knot
    attr_reader :location
    attr_accessor :follower

    def initialize
      @location = [0, 0]
    end

    def[](index)
      location[index]
    end

    private

    def notify_follower
      follower.follow(self) if followed?
    end

    def followed?
      follower
    end
  end
end
