#!/usr/bin/env ruby
# frozen_string_literal: true

require "ruby_jard"

def test_data
  # <<~DATA
  #   nop +0
  #   acc +1
  #   jmp +4
  #   acc +3
  #   jmp -3
  #   acc -99
  #   acc +1
  #   jmp -4
  #   acc +6
  # DATA
end

DATA = test_data || File.read(File.join(__dir__, "input.txt"))
INSTSTRUCTIONS = DATA.split "\n"

def accumulator
  @accumulator ||= 0
end

def trace
  @trace ||= []
end

def fixed
  @fixed ||= []
end

def seen
  @seen ||= []
end

def part1
  run INSTSTRUCTIONS.dup
end

def part2
  run INSTSTRUCTIONS.dup
end

def run(instructions, pointer = 0)
  @accumulator = 0
  @trace = []
  @fixed ||= []
  @seen = []
  @previous_fix ||= nil
  loop do
    return accumulator if pointer == instructions.length
    break fix instructions if seen.include? pointer

    trace << [pointer, instructions[pointer]]
    seen << pointer

    case instructions[pointer]
    when /acc ([+-]\d+)/
      @accumulator += Regexp.last_match(1).to_i
      pointer += 1
    when /jmp ([+-]\d+)/
      pointer += Regexp.last_match(1).to_i
    when /nop/
      pointer += 1
    end
  end
end

def fix(instructions)
  loop do
    line, instruction = trace.pop
    next if fixed.include? line
    next if instruction.include?("acc")

    instructions[@previous_fix[0]] = @previous_fix[1] if @previous_fix
    @previous_fix = [line, instruction]
    instructions[line] =
      case instruction
      when /nop/
        instructions[line].gsub "nop", "jmp"
      else
        instructions[line].gsub "jmp", "nop"
      end
    fixed << line
    break
  end
  run instructions
end

puts "Solution part1:\n#{part1}"
puts "Solution part2:\n#{part2}" if part2
