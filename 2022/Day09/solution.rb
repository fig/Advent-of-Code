class Solution
  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # <<~INPUT
    #   R 4
    #   U 4
    #   L 3
    #   D 1
    #   R 4
    #   D 1
    #   L 5
    #   R 2
    # INPUT
  end

  def solutions
    puts "Part1: #{part1}"
    puts "Part2: #{part2}"
  end

  private

  def part1
    motions.each do |motion|
      direction = motion[0]
      steps = motion[1].to_i

      case direction
      when "R"
        steps.times do
          head[0] += 1
          move_tail
        end
      when "L"
        steps.times do
          head[0] -= 1
          move_tail
        end
      when "U"
        steps.times do
          head[1] += 1
          move_tail
        end
      when "D"
        steps.times do
          head[1] -= 1
          move_tail
        end
      end
    end
    seen_positions.uniq.size
  end

  def head
    @head ||= [0, 0]
  end

  def tail
    @tail ||= [0, 0]
  end

  def motions
    @motions ||= input.split("\n").map(&:split)
  end

  def seen_positions
    @seen_positions ||= [[0, 0]]
  end

  def move_tail
    return if head_and_tail_touching?

    if head[0] == tail[0]
      if head[1] > tail[1]
        tail[1] += 1
      else
        tail[1] -= 1
      end
    elsif head[1] == tail[1]
      if head[0] > tail[0]
        tail[0] += 1
      else
        tail[0] -= 1
      end
    else
      move_tail_diagonally
    end

    seen_positions << tail.dup
  end

  def head_and_tail_touching?
    (head[0] - tail[0]).abs <= 1 && (head[1] - tail[1]).abs <= 1
  end

  def move_tail_diagonally
    # move tail one step diagonally towards head
    if head[0] > tail[0]
      tail[0] += 1
    else
      tail[0] -= 1
    end

    if head[1] > tail[1]
      tail[1] += 1
    else
      tail[1] -= 1
    end
  end

  def part2
  end
end

Solution.new.solutions

# 5513
