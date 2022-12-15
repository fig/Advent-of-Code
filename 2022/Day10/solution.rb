class Solution
  def solutions
    puts "Part1: #{part1}"
    puts "Part2: \n#{part2}"
  end

  private

  def part1
    run_program
    [20, 60, 100, 140, 180, 220].sum { |i| i * register[i] }
  end

  def part2
    draw_screen
    screen.each_slice(40).map(&:join).join("\n")
  end

  def run_program
    input.each_line(chomp: true) do |line|
      register << register.last
      case line.split
      in ["addx", x]
        register << (register.last + x.to_i)
      else
        # noop
      end
    end
  end

  def draw_screen
    index = 1
    6.times do
      0.upto(39) do |pixel|
        mid_sprite = register[index]
        screen << if [mid_sprite.pred, mid_sprite, mid_sprite.succ].any?(pixel)
                    "⬜"
                  else
                    "⬛"
                  end
        index += 1
      end
    end
  end

  def input
    File.read(File.join(__dir__, "input.txt"))
  end

  def register
    @register ||= [0, 1]
  end

  def screen
    @screen ||= []
  end
end

Solution.new.solutions

# 14620
# BJFRHRFU
