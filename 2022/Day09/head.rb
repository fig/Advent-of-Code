require_relative "knot"

module Day09
  class Head < Knot
    def move(motion)
      direction = motion[0]
      steps = motion[1].to_i

      case direction
      when "R"
        steps.times do
          location[0] += 1
          notify_follower
        end
      when "L"
        steps.times do
          location[0] -= 1
          notify_follower
        end
      when "U"
        steps.times do
          location[1] += 1
          notify_follower
        end
      when "D"
        steps.times do
          location[1] -= 1
          notify_follower
        end
      end
    end
  end
end
