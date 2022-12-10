class Solution
  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    <<~INPUT
      R 4
      U 4
      L 3
      D 1
      R 4
      D 1
      L 5
      R 2
    INPUT
  end

  def data
  end

  def solutions
    puts "Part1: #{part1}"
    puts "Part2: #{part2}"
  end

  private

  def part1
    # Parse the input and extract the list of motions
    motions = input.split("\n").map { |line| line.split(" ") }

    # Initialize the head and tail positions
    head_pos = [0, 0]
    tail_pos = [0, 0]

    # Loop through the list of motions
    motions.each do |motion|
      # Extract the direction and number of steps from the current motion
      direction = motion[0]
      steps = motion[1].to_i

      # Update the head position based on the direction and number of steps
      case direction
      when "R"
        head_pos[0] += steps
      when "L"
        head_pos[0] -= steps
      when "U"
        head_pos[1] += steps
      when "D"
        head_pos[1] -= steps
      end

      # Update the tail position based on the new head position
      if head_pos[0].abs == 1 || head_pos[1].abs == 1
        # If the head is one step away from the tail in the same row or column,
        # move the tail one step in the same direction as the head
        tail_pos[0] += head_pos[0] - tail_pos[0]
        tail_pos[1] += head_pos[1] - tail_pos[1]
      elsif (head_pos[0] - tail_pos[0]).abs > 1 || (head_pos[1] - tail_pos[1]).abs > 1
        # If the head and tail are not in the same row or column, move the tail
        # one step diagonally to keep up with the head
        tail_pos[0] += (head_pos[0] - tail_pos[0]) # .sign
        tail_pos[1] += (head_pos[1] - tail_pos[1]) # .sign
      end
    end

    # Calculate the Manhattan distance between the head and tail positions
    distance = head_pos[0].abs + head_pos[1].abs

    # Print the result
    puts "The Manhattan distance between the head and tail positions is #{distance}"
  end

  def part2
  end
end

Solution.new.solutions
