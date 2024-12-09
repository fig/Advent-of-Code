#!/usr/bin/env ruby

class Solution
  DIRS = [[-1, 0], [0, 1], [1, 0], [0, -1]].freeze

  def input
    <<~INPUT
      ....#.....
      .........#
      ..........
      ..#.......
      .......#..
      ..........
      .#..^.....
      ........#.
      #.........
      ......#...
    INPUT
    # File.read(File.join(__dir__, "input.txt"))
  end

  def part1(map, current_position)
    seen = {}
    seen[current_position] = true
    heading = 0
    steps = 1
    loop do
      look_ahead = DIRS[heading].zip(current_position).map!(&:sum)
      case map[look_ahead]
      when true
        steps += 1 unless seen.include?(look_ahead)
        current_position = look_ahead
        seen[current_position] = true
      when false
        heading = (heading + 1) % 4
      when nil
        break steps
      end
    end
  end

  def walk_path(map, start, heading, seen, recursive)
    loops = 0
    while true
      look_ahead = DIRS[heading].zip(start).map!(&:sum)
      case map[look_ahead]
      when true
        if recursive
          map[look_ahead] = false
          loops += 1 if seen.none? { |pos, _|
            pos == look_ahead
          } && walk_path(map, start, heading, seen.clone, false)

          map[look_ahead] = true
        end
        start = look_ahead
        return true unless seen.add? [start, heading]
      when false
        heading = (heading + 1) % 4
      when nil
        return recursive && loops
      end
    end
  end

  def solve
    map = {}
    start = nil
    input.split("\n").each.with_index do |line, row|
      line.chars.each.with_index { |c, col|
        map[[row, col]] = c != "#"
        start = [row, col] if c == "^"
      }
    end
    [part1(map, start), walk_path(map, start, 0, Set.new([[start, 0]]), true)]
  end

  def solutions
    p1, p2 = solve
    puts "Part1: #{p1} #{[5312, 41].include?(p1) ? '✅' : '❌'}"
    puts "Part2: #{p2} #{[1748, 6].include?(p2) ? '✅' : '❌'}"
  end
end
Solution.new.solutions
