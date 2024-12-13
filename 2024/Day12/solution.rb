#!/usr/bin/env ruby

class Solution
  def input
    <<~INPUT
      RRRRIICCFF
      RRRRIICCCF
      VVRRRCCFFF
      VVRCCCJFFF
      VVVVCJJCFE
      VVIVCCJJEE
      VVIIICJJEE
      MIIIIIJJEE
      MIIISIJEEE
      MMMISSJEEE
    INPUT
    File.read(File.join(__dir__, "input.txt"))
  end

  def cache
    @cache ||= {}
  end

  def grid
    @grid ||=
      begin
        hash = {}
        input.each_line.map(&:strip).each_with_index do |line, y|
          line.each_char.with_index do |char, x|
            hash[[x, y]] = char
          end
        end
        hash
      end
  end

  def areas
    @areas ||= Hash.new(0)
  end

  def fences
    @fences ||= Hash.new(0)
  end

  def fences2
    @fences2 ||= Hash.new(0)
  end

  def neighbors
    ->(x, y) { [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]] }
  end

  def corners
    lambda { |x, y|
      [
        [[x - 1, y], [x - 1, y - 1], [x, y - 1]],
        [[x, y - 1], [x + 1, y - 1], [x + 1, y]],
        [[x + 1, y], [x + 1, y + 1], [x, y + 1]],
        [[x, y + 1], [x - 1, y + 1], [x - 1, y]],
      ]
    }
  end

  def part1
    id = "a"
    seen = Set.new
    seen_as_neighbor = Set.new
    grid.each do |(x, y), type|
      next if seen.include?([x, y])

      queue = [[x, y]]
      until queue.empty?
        current = queue.shift
        seen_as_neighbor << current
        areas[id] += 1
        neighbors.call(*current).each do |neighbor|
          n_type = grid[neighbor]
          fences[id] += 1 if n_type != type
          next if grid[neighbor].nil?
          next if seen_as_neighbor.include?(neighbor)

          queue << neighbor if n_type == type
          seen_as_neighbor << neighbor if n_type == type
        end
        seen << current
      end
      id = id.next
    end
    areas.values.zip(fences.values).sum { |a, f| a * f }
  end

  def part2
    id = "a"
    seen = Set.new
    seen_as_neighbor = Set.new
    grid.each do |(x, y), type|
      next if seen.include?([x, y])

      queue = [[x, y]]
      until queue.empty?
        current = queue.shift
        neighboring = neighbors.call(*current)
        if neighboring.map { |n| grid[n] }
                      .none? { |n| n == type }
          areas[id] += 1
          fences2[id] = 4
          next
        end
        neighboring.each do |neighbor|
          n_type = grid[neighbor]

          next unless type == n_type
          next if seen_as_neighbor.include?(neighbor)

          areas[id] += 1

          corners.call(*neighbor).each do |a, b, c|
            a = (grid[a] == type)
            b = (grid[b] == type)
            c = (grid[c] == type)
            fences2[id] += 1 if (a == c) && (!a || !b)
          end

          queue << neighbor
          seen_as_neighbor << neighbor
        end
        seen << current
      end
      id = id.next
    end
    fences2.values.zip(areas.values).sum { |f, a| f * a }
  end

  def solutions
    p1 = part1

    @areas = @fences = Hash.new(0)
    p2 = part2

    puts "Part1: #{p1} #{[1930, 1_415_378].include?(p1) ? '✅' : '❌'}"
    puts "Part2: #{p2} #{[1206, 862_714].include?(p2) ? '✅' : '❌'}"

    require "benchmark"
    puts "Benchmarking..."

    bm = (((1..10).to_a.sum { cache.clear && Benchmark.realtime { part1 } }) / 10)
    puts "Part1: #{(bm * 1000).round 3} ms"
    bm = (((1..10).to_a.sum { cache.clear && Benchmark.realtime { part2 } }) / 10)
    puts "Part2: #{(bm * 1000).round 3} ms"
  end
end

Solution.new.solutions
