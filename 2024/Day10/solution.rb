#!/usr/bin/env ruby

require "algorithms"
class Solution
  include Containers
  def input
    <<~INPUT
      0123456789876543210123456789876543210
      1234567898987654321234567898987654321
      2345678987898765432345678987898765432
      3456789876789876543456789876789876543
      4567898765678987654567898765678987654
      5678987654567898765678987654567898765
      6789876543456789876789876543456789876
      7898765412345678987898765432105678987
      8987654301234567898987654321214567898
      9876543210123456789876543210123456789
      8987654321214567898987654301234567898
      7898765432105678987898765432321678987
      6789876543456789876789876543210789876
      5678987654567898765678987654567898765
      4567898765678987654567898765678987654
      3456789876789876543456789876789876543
      2345678987898765432345678987898765432
      1234567898987654321234567898987654321
      0123456789876543210123456789876543210
      1234567898987654321234567898987654321
      2345678987898765410145678987898765432
      3456789876789876543456789876789876543
      4567898765678987652567898765678987654
      5678987654567898761678987654567898765
      6789876543456789870789012543456789876
      7898765432345678989898123432345678987
      8987654321234567898987654321234567898
      9876543210123456789876543210123456789
      8987654321214567898987654321234567898
      7898765432105678987898765432345678987
      6789876543456789876789876543456789876
      5678987654567898765678987654567898765
      4567898765678987654567898765678987654
      3456789876789876543456789876789876543
      2345678987898765432345678987898765432
      1234567898987654321234567898987654321
      0123456789876543210123456789876543210
    INPUT
    # File.read(File.join(__dir__, "input.txt"))
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
      current_altitude = map[current_location]
      [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]].select { |neighbor|
        map[neighbor] == current_altitude + 1
      }.zip([current_altitude + 1] * 4)
    }
  end

  def method_missing(method_name, *args, &block)
    if %i[score rating].include?(method_name)
      define_singleton_method(:score?) { method_name == :score }
      lambda { |trail_head|
        path_length = 0
        queue = PriorityQueue.new
        queue.push [trail_head, 0], map[trail_head]
        visited = Set.new(trail_head)
        access_paths = {}
        count = 0

        until queue.empty?
          current, path_length = queue.pop
          valid_neighbors[current].each do |neighbor, neighbor_altitude|
            next if score? && visited.include?(neighbor)

            if neighbor_altitude == 9
              count += 1
            else
              queue.push [neighbor, path_length + 1], neighbor_altitude
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
    starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    p1 = part1
    puts "Part1: #{p1} #{[36, 464, 624].include?(p1) ? '✅' : '❌'}"
    p2 = part2
    puts "Part2: #{part2} #{[81, 16_451, 1483].include?(p2) ? '✅' : '❌'}"

    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    puts "\nSolved in #{((ending - starting) * 1000).round(2)}ms"
  end
end

Solution.new.solutions
