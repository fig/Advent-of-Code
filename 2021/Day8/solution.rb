#!/usr/bin/env ruby
require "ruby_jard"

class Solution
  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    <<~INPUT
      be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
      edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
      fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
      fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
      aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
      fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
      dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
      bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
      egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
      gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
    INPUT
  end

  def data
    @data ||= input.strip
  end

  def part1
    data.each_line.sum { |line|
      line.split("|")[1].split.count { |word| [2, 3, 4, 7].include? word.length }
    }
  end

  class Display
    DECODERS = {
      one:   "1",
      seven: "7",
      four:  "4",
      eight: "8",
      two:   "2",
      three: "3",
      five:  "5",
      nine:  "9",
      zero:  "0",
      six:   "6",
    }.freeze

    attr_accessor :signal, :output, :lookup

    def initialize(input)
      @signal, @output = input.split(" | ").map(&:split)
      @lookup = {}
    end

    def solve
      decode
      output.map { |sequence|
        lookup.find { |key, _v| sequence.chars.sort == key.chars.sort }[1]
      }.join.to_i
    end

    def decode
      DECODERS.each do |number, value|
        sequence = __send__ number
        lookup[sequence] = value
      end
    end

    def one
      @one ||= signal.delete(signal.find { |e| e.length == 2 })
    end

    def four
      @four ||= signal.delete(signal.find { |e| e.length == 4 })
    end

    def seven
      @seven ||= signal.delete(signal.find { |e| e.length == 3 })
    end

    def eight
      @eight ||= signal.delete(signal.find { |e| e.length == 7 })
    end

    def two
      @two ||= signal.delete(
        signal.find { |e|
          e.length == 5 && ((eight.chars - four.chars - seven.chars) - e.chars).empty?
        },
      )
    end

    def three
      @three ||= signal.delete(signal.find { |e| e.length == 5 && (one.chars - e.chars).empty? })
    end

    def five
      @five ||= signal.delete(signal.find { |e| e.length == 5 })
    end

    def nine
      @nine ||= signal.delete(signal.find { |e| e.length == 6 && (four.chars - e.chars).empty? })
    end

    def zero
      @zero ||= signal.delete(signal.find { |e| e.length == 6 && (seven.chars - e.chars).empty? })
    end

    def six
      @six ||= signal.delete(signal.find { |e| e.length == 6 })
    end
  end

  def part2
    data.each_line.sum { |line| Display.new(line).solve }
  end
end

puts "Part1: #{Solution.new.part1}"
puts "Part2: #{Solution.new.part2}"
