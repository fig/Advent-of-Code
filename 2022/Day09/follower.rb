require_relative "knot"

module Day09
  class Follower < Knot
    attr_accessor :trail

    def initialize
      super
      @trail = [location.dup]
    end

    def follow(leader)
      return if touching?(leader)

      move_to(leader)

      trail << location.dup
      notify_follower
    end

    def touching?(leader)
      (leader[0] - location[0]).abs <= 1 && (leader[1] - location[1]).abs <= 1
    end

    def move_to(leader)
      if in_line_with?(leader)
        move_straight_toward(leader)
      else
        move_diagonally_toward(leader)
      end
    end

    def in_line_with?(leader)
      leader[0] == location[0] || leader[1] == location[1]
    end

    def move_straight_toward(leader)
      location[1] += leader[1] <=> location[1]
      location[0] += leader[0] <=> location[0]
    end

    def move_diagonally_toward(leader)
      location[0] += leader[0] <=> location[0]
      location[1] += leader[1] <=> location[1]
    end
  end
end
