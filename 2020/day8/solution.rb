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

class Runner
  def initialize(instructions, fix_errors: true)
    @instructions = instructions
    @fix_errors = fix_errors
    @fixed_lines = []
    @previous_fix = nil
  end

  def run
    initialize_run
    loop do
      return @accumulator if end_of_code? || (error? && !@fix_errors)

      repair_code if error?
      execute_instruction
    end
  end

  private

  def initialize_run
    @pointer = 0
    @accumulator = 0
    @trace = []
    @seen = []
  end

  def end_of_code?
    @pointer == @instructions.length
  end

  def error?
    @seen.include?(@pointer)
  end

  def execute_instruction
    @trace << [@pointer, @instructions[@pointer]]
    @seen << @pointer

    case @instructions[@pointer]
    when /acc ([+-]\d+)/ then increment_accumulator(Regexp.last_match(1))
    when /jmp ([+-]\d+)/ then move_pointer(Regexp.last_match(1))
    when /nop/ then @pointer += 1
    end
  end

  def increment_accumulator(value)
    @accumulator += value.to_i
    @pointer += 1
  end

  def move_pointer(value)
    @pointer += value.to_i
  end

  def repair_code
    loop do
      line, instruction = @trace.pop
      next if @fixed_lines.include?(line) || instruction.start_with?("acc")

      fix_line(line, instruction)
      break
    end
    run
  end

  def fix_line(line, instruction)
    revert_previous_fix
    @previous_fix = [line, instruction]
    @instructions[line] = instruction.tr "nojm", "jmno"
    @fixed_lines << line
  end

  def revert_previous_fix
    @previous_fix && @instructions[@previous_fix[0]] = @previous_fix[1]
  end
end

DATA = test_data || File.read(File.join(__dir__, "input.txt"))
CODE = DATA.split "\n"

def part1
  Runner.new(CODE.dup, fix_errors: false).run
end

def part2
  Runner.new(CODE.dup).run
end

puts "Solution part1:\n#{part1}"
puts "Solution part2:\n#{part2}"
