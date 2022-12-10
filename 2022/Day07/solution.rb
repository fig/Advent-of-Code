#!/usr/bin/env ruby

module Day7
  DISK_SIZE = 70_000_000
  REQUIRED_SPACE = 30_000_000
  File = Struct.new(:file_size)

  class Dir
    attr_reader :name, :parent, :children, :files

    def initialize(name, parent)
      @name = name
      @parent = parent
      @children = []
      @files = []
    end

    def size
      files.sum(&:file_size) + children.sum(&:size)
    end
  end

  class Solution
    attr_accessor :dirs, :cwd

    def initialize
      @cwd = Dir.new("/", self)
      @dirs = [cwd]
    end

    def run
      while command_line.any?
        case command_line.shift.split
        in ["$", "cd", dir]
          cd dir
        in ["dir", name]
          mkdir name
        in [size, *]
          touch size
        end
      end
    end

    def part1
      dirs.map(&:size).reject! { _1 > 100_000 }.sum
    end

    def part2
      dirs.reject { |dir| dir.size < REQUIRED_SPACE - free_space }
          .min_by(&:size).size
    end

    private

    def cd(dir)
      return if cwd.name == "#{cwd.name + dir}/"

      @cwd =
        case dir
        when ".." then cwd.parent
        when "/" then dirs.first
        else cwd.children.find { _1.name == "#{cwd.name + dir}/" }
        end
    end

    def mkdir(name)
      new_dir = Dir.new("#{cwd.name}#{name}/", @cwd)
      cwd.children << new_dir
      dirs << new_dir
    end

    def touch(size)
      cwd.files << File.new(size.to_i)
    end

    def used_space
      dirs.first.size
    end

    def free_space
      DISK_SIZE - used_space
    end

    def command_line
      @command_line ||= input.lines(chomp: true)
    end

    def input
      ARGV[0] || ::File.read(::File.join(__dir__, "input.txt"))
    end
  end
end

s = Day7::Solution.new
s.run
puts "Part1: #{s.part1}"
puts "Part2: #{s.part2}"
# 1581595
# 1544176
