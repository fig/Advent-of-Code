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

  def valid_neighbors
    lambda { |current_location|
      x, y = current_location
      value = map[current_location]
      [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]].select { |neighbor|
        map[neighbor] == value + 1
      }
    }
  end

  def method_missing(method_name, *args, &block)
    if %i[score rating].include?(method_name)
      define_singleton_method(:score?) { method_name == :score }
      lambda { |trail_head|
        queue = [[trail_head, 0]]
        visited = Set.new([[trail_head], 0])
        count = 0

        until queue.empty?
          current, path_length = queue.shift
          valid_neighbors[current].each do |neighbor|
            next if score? && visited.include?(neighbor)

            if map[neighbor] == 9
              count += 1
            else
              queue << [neighbor, path_length + 1]
            end
            visited << neighbor
          end
        end

        count
      }
    else
      super
    end
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
    puts "Part2: #{part2} #{[81, 1483].include?(p2) ? '✅' : '❌'}"
  end
end

Solution.new.solutions
