#!/usr/bin/env ruby

class Solution
  def input
    # <<~INPUT
    #   89010123
    #   78121874
    #   87430965
    #   96549874
    #   45678903
    #   32019012
    #   01329801
    #   10456732
    # INPUT
    File.read(File.join(__dir__, "input.txt"))
  end

  def lines
    @lines ||= input.lines.map(&:strip)
  end

  def map
    @map ||=
      lines.each_with_index.with_object({}) do |(line, row), map|
        line.chars.map(&:to_i).each_with_index do |char, col|
          map[[col, row]] = char
        end
      end
  end

  def trail_heads
    @trail_heads ||= map.select { |_, v| v == 0 }
                        .keys
  end

  # number of cells with value 9 reachable from trail_head by moving up,
  # down, left, right and incrementing the value by exactly 1 with each step.
  def score
    lambda { |trail_head|
      queue = [trail_head]
      visited = Set.new([trail_head])
      count = 0

      until queue.empty?
        current = queue.shift
        x, y = current
        value = map[current]

        [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]].each do |neighbor|
          next unless map[neighbor] == value + 1
          next if visited.include?(neighbor)

          if map[neighbor] == 9
            count += 1
          else
            queue << neighbor
          end
          visited << neighbor
        end
      end

      count
    }
  end

  # number of distinct paths that can be taken to reach a cell with value 9
  # from trail_head by moving up, down, left, right and incrementing the
  # value by exactly 1 with each step.
  def rating
    lambda { |trail_head|
      queue = [[trail_head, 0]]
      paths = 0

      until queue.empty?
        current, path_length = queue.shift
        x, y = current
        value = map[current]

        [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]].each do |neighbor|
          next unless map[neighbor] == value + 1

          if map[neighbor] == 9
            paths += 1
          else
            queue << [neighbor, path_length + 1]
          end
        end
      end

      paths
    }
  end

  def part1
    trail_heads.sum(&score)
  end

  def part2
    trail_heads.sum(&rating)
  end

  def solutions
    p1 = part1
    puts "Part1: #{p1} #{[36, 624].include?(p1) ? '✅' : '❌'}"
    p2 = part2
    puts "Part2: #{part2} #{[1483].include?(p2) ? '✅' : '❌'}"
  end
end

Solution.new.solutions
