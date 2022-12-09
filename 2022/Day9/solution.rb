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
  end

  def part2
  end
end

Solution.new.solutions
