#!/usr/bin/env ruby

class Solution
  def input
    # "2333133121414131402"
    File.read(File.join(__dir__, "input.txt"))
  end

  # ~13 seconds
  def part1
    disk = []
    input.chars.each_slice(2).with_index do |(file_size, free_space_size), idx|
      disk << { type: :file, id: idx, size: file_size.to_i }
      disk << { type: :free, size: free_space_size.to_i }
    end
    while disk.any? { |x| x[:type] == :free }
      sector = disk.pop
      next if sector[:type] == :free

      disk.each_with_index do |current_sector, idx|
        next unless current_sector[:type] == :free

        required_space = sector[:size]
        available_space = current_sector[:size]
        if required_space <= available_space
          disk.insert(idx, sector)
          current_sector[:size] -= required_space
        else
          remaining_size = required_space - available_space
          disk[idx] = { type: :file, id: sector[:id], size: available_space }
          sector[:size] = remaining_size
          disk << sector
          break
        end
        break
      end
    end
    disk.map { |sector| Array.new(sector[:size], sector[:id]) }
        .flatten!.map!.with_index { |x, i| x.to_i * i }
        .sum
  end

  # ~4.5 mins 😱
  def part2
    disk = []
    input.chars.each_slice(2).with_index do |(file_size, free_space_size), i|
      disk << ([i.to_s] * file_size.to_i)
      disk << (["."] * free_space_size.to_i)
    end
    disk.flatten!
    max_id = disk.last
    max_id.to_i.downto(0).each do |id|
      required_space = disk.count(id.to_s)

      disk.each_cons(required_space).with_index do |slice, index|
        break if slice.include?(id.to_s)
        next unless slice.all?(".")

        disk.slice!(index, required_space)
        disk.map! { |x| x == id.to_s ? "." : x }
        insert = []
        required_space.times { insert << (id.to_s) }
        disk.insert(index, *insert)
        break
      end
    end
    disk.map.with_index { |x, i| x.to_i * i }
        .sum
  end

  def solutions
    p1 = part1
    puts "Part1: #{p1} #{[6_288_707_484_810, 1928].include?(p1) ? '✅' : '❌'}"
    p2 = part2
    puts "Part2: #{p2} #{[6_311_837_662_089, 2858].include?(p2) ? '✅' : '❌'}"
  end
end

Solution.new.solutions
