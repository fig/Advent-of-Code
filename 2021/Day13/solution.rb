#!/usr/bin/env ruby

class Solution
  def input
    @input ||= test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    <<~INPUT
      6,10
      0,14
      9,10
      0,3
      10,4
      4,11
      6,0
      6,12
      4,1
      0,13
      10,12
      3,4
      3,0
      8,4
      1,10
      2,14
      8,10
      9,0

      fold along y=7
      fold along x=5

    INPUT
    nil
  end

  def data
    @data ||= input.split("\n\n")
  end

  def paper
    @paper ||= data[0].each_line.map{_1.split(",").map(&:to_i)}
  end

  def instructions
    @instructions ||=
      data[1].each_line.map{_1.split("=")}.map{[_1[0].tr(" ", "_").to_sym, _1[1].to_i]}
  end

  def fold_along_x(magnitude, paper)
    paper.map { |x, y| [x < magnitude ? x : magnitude - (x - magnitude), y] }
         .uniq!
  end

  def fold_along_y(magnitude, paper)
    paper.map { |x, y| [x, y < magnitude ? y : magnitude - (y - magnitude)] }
         .uniq!
  end

  def part1
    __send__(*instructions.first, paper).size
  end

  def part2
    dots = instructions.reduce(paper) { |acc, elem| __send__(*elem, acc) }
    (0..dots.max_by{_1[1]}[1]).each do |line|
      (0..dots.max_by{_1[0]}[0]).each do |char|
        print dots.include?([char, line]) ? "##" : "  "
      end
      print "\n"
    end
    nil
  end
end

puts "Part1: #{Solution.new.part1}"
puts "Part2:"
Solution.new.part2
