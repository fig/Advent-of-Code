#!/usr/bin/env ruby

class Solution
  def input
    test_input || File.read(File.join(__dir__, "input.txt"))
  end

  def test_input
    # <<~INPUT
    # INPUT
  end

  def data
    @data ||= format("%0#{input.chomp.size * 4}b", input.hex)
  end

  def packet
    @packet ||= PacketGenerator.for(data)
  end

  def part1
    packet.version_sum
  end

  def part2
    packet.value
  end

  class Packet
    def initialize(version:, type:, data:)
      @version = version
      @type = type
      @data = data
      @subpackets = []
      unpack
    end

    def version_sum
      @version.to_i(2) + @subpackets.sum(&:version_sum)
    end
  end

  class ValuePacket < Packet
    attr_reader :value

    private

    def unpack
      @value =
        loop {
          @accumulator ||= ""
          @accumulator << @data.slice!(1, 4)
          break @accumulator.to_i(2) if @data.slice!(0) == "0"
        }
    end
  end

  class OperatorPacket < Packet
    VALUES = {
      "000" => ->(subpackets) { subpackets.sum(&:value) },
      "001" => ->(subpackets) { subpackets.map(&:value).reduce(&:*) },
      "010" => ->(subpackets) { subpackets.map(&:value).min },
      "011" => ->(subpackets) { subpackets.map(&:value).max },
      "101" => ->(subpackets) { subpackets[0].value > subpackets[1].value ? 1 : 0 },
      "110" => ->(subpackets) { subpackets[0].value < subpackets[1].value ? 1 : 0 },
      "111" => ->(subpackets) { subpackets[0].value == subpackets[1].value ? 1 : 0 },
    }.freeze

    def value
      VALUES[@type].call(@subpackets)
    end
  end

  class Operator11Packet < OperatorPacket
    private

    def unpack
      @data.slice!(0, 11).to_i(2).times do
        @subpackets << PacketGenerator.for(@data)
      end
    end
  end

  class Operator15Packet < OperatorPacket
    private

    def unpack
      length_of_subpackets = @data.slice!(0, 15).to_i(2)
      substring = @data.slice!(0, length_of_subpackets)
      loop do
        @subpackets << PacketGenerator.for(substring)
        break if substring.length.zero?
      end
    end
  end

  module OperatorPacketGenerator
    TYPES = { "0" => Operator15Packet, "1" => Operator11Packet }.freeze
    class << self
      def for(version:, type:, data:)
        length_type = data.slice!(0)
        TYPES[length_type].new(version: version, type: type, data: data)
      end
    end
  end

  module PacketGenerator
    class << self
      def for(data)
        version = data.slice!(0, 3)
        type = data.slice!(0, 3)
        if type == "100"
          ValuePacket.new(version: version, type: type, data: data)
        else
          OperatorPacketGenerator.for(version: version, type: type, data: data)
        end
      end
    end
  end
end

solution = Solution.new
puts "Part1: #{solution.part1}"
puts "Part2: #{solution.part2}"
puts "=================="
