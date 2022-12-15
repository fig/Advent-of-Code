class Solution
  def input
    # data ||
    File.read(File.join(__dir__, "input.txt"))
  end

  def register
    @register ||= [0, 1]
  end

  def run_program
    input.each_line(chomp: true) do |line|
      r = register.last
      register << r
      case line.split
      in ["addx", x]
        register << (r + x.to_i)
      else
        # noop
      end
    end
    register
  end

  def solutions
    puts "Part1: #{part1}"
    puts "Part2: #{part2}"
  end

  private

  def part1
    run_program
    # 21, 19, 18, 21, 16, 18
    [20, 60, 100, 140, 180, 220].sum { |i| i * register[i] }
  end

  def part2
  end

  def data
    <<~DATA
      addx 15
      addx -11
      addx 6
      addx -3
      addx 5
      addx -1
      addx -8
      addx 13
      addx 4
      noop
      addx -1
      addx 5
      addx -1
      addx 5
      addx -1
      addx 5
      addx -1
      addx 5
      addx -1
      addx -35
      addx 1
      addx 24
      addx -19
      addx 1
      addx 16
      addx -11
      noop
      noop
      addx 21
      addx -15
      noop
      noop
      addx -3
      addx 9
      addx 1
      addx -3
      addx 8
      addx 1
      addx 5
      noop
      noop
      noop
      noop
      noop
      addx -36
      noop
      addx 1
      addx 7
      noop
      noop
      noop
      addx 2
      addx 6
      noop
      noop
      noop
      noop
      noop
      addx 1
      noop
      noop
      addx 7
      addx 1
      noop
      addx -13
      addx 13
      addx 7
      noop
      addx 1
      addx -33
      noop
      noop
      noop
      addx 2
      noop
      noop
      noop
      addx 8
      noop
      addx -1
      addx 2
      addx 1
      noop
      addx 17
      addx -9
      addx 1
      addx 1
      addx -3
      addx 11
      noop
      noop
      addx 1
      noop
      addx 1
      noop
      noop
      addx -13
      addx -19
      addx 1
      addx 3
      addx 26
      addx -30
      addx 12
      addx -1
      addx 3
      addx 1
      noop
      noop
      noop
      addx -9
      addx 18
      addx 1
      addx 2
      noop
      noop
      addx 9
      noop
      noop
      noop
      addx -1
      addx 2
      addx -37
      addx 1
      addx 3
      noop
      addx 15
      addx -21
      addx 22
      addx -6
      addx 1
      noop
      addx 2
      addx 1
      noop
      addx -10
      noop
      noop
      addx 20
      addx 1
      addx 2
      addx 2
      addx -6
      addx -11
      noop
      noop
      noop
    DATA
  end
end

Solution.new.solutions
