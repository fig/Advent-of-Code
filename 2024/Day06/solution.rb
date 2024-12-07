#!/usr/bin/env ruby

class Solution
  def input
    # <<~INPUT
    #   ....#.....
    #   .........#
    #   ..........
    #   ..#.......
    #   .......#..
    #   ..........
    #   .#..^.....
    #   ........#.
    #   #.........
    #   ......#...
    # INPUT
    File.read(File.join(__dir__, "input.txt"))
  end

  def map
    @map ||=
      begin
        map = {}
        input.lines.map(&:chomp).each_with_index do |line, y|
          line.chars.each_with_index { |char, x| map[[x, y]] = char }
        end
        map
      end
  end

  def path_taken
    @path_taken ||= []
  end

  def part1
    seen = {}
    directions = %i[up right down left]
    current_position = map.key("^")
    seen[current_position] = true
    heading = :up
    steps = 1
    loop do
      look_ahead =
        case heading
        when :up
          [current_position[0], current_position[1] - 1]
        when :right
          [current_position[0] + 1, current_position[1]]
        when :down
          [current_position[0], current_position[1] + 1]
        when :left
          [current_position[0] - 1, current_position[1]]
        end
      case map[look_ahead]
      when ".", "^"
        steps += 1 unless seen.include?(look_ahead)
        current_position = look_ahead
        path_taken << current_position
        seen[current_position] = true
      when "#"
        heading = directions[(directions.index(heading) + 1) % 4]
      else
        break steps
      end
    end
  end

  def part2
    directions = %i[up right down left]

    foo = ["#", "^"]
    obstructions = 0
    path_taken.uniq.each do |position|
      next if foo.include? map[position]

      dup_map = map.dup
      dup_map[position] = "#"
      heading = :up
      current_position = dup_map.key("^")
      seen = Hash.new { |h, k| h[k] = [] }
      seen[current_position] = [heading]

      loop do
        look_ahead =
          case heading
          when :up
            [current_position[0], current_position[1] - 1]
          when :right
            [current_position[0] + 1, current_position[1]]
          when :down
            [current_position[0], current_position[1] + 1]
          when :left
            [current_position[0] - 1, current_position[1]]
          end
        case dup_map[look_ahead]
        when ".", "^"
          break obstructions += 1 if seen[look_ahead].include?(heading)

          current_position = look_ahead
          seen[current_position] << heading
        when "#"
          heading = directions[(directions.index(heading) + 1) % 4]
        else
          break
        end
      end
    end
    obstructions
  end

  def solutions
    p1 = part1
    puts "Part1: #{p1} #{[5312, 41].include?(p1) ? '✅' : '❌'}"
    p2 = part2
    puts "\nPart2: #{p2} #{[1748, 6].include?(p2) ? '✅' : '❌'}"
  end
end

Solution.new.solutions
