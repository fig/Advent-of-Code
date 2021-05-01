require_relative "rule"
require_relative "ruleset"
require_relative "ticket"

module Day16
  class Solution
    def initialize(data = File.read(File.join(__dir__, "../../input.txt")))
      @data = data
    end

    def call
      puts "Solution part1:\n#{part1}"
      puts "Solution part2:\n#{part2}"
    end

    def rules
      @rules ||=
        @data.split("\n\n")[0].each_line.map do |line|
          Rule.new(line)
        end
    end

    def ruleset
      @ruleset ||= Ruleset.new(rules)
    end

    def nearby_tickets
      @nearby_tickets ||=
        @data.split("\n\n")[2].each_line.drop(1).map! do |line|
          fields = line.split(",").map { |f| Field.new(f, ruleset) }
          Ticket.new(fields)
        end
    end

    def part1
      nearby_tickets.map(&:invalid_values).flatten!.sum
    end

    def my_ticket
      @my_ticket ||=
        fields =
          @data.split("\n\n")[1].scan(/(\d+)/).flatten.map do |f|
            Field.new(f, ruleset)
          end
      Ticket.new(fields)
    end

    def all_fields
      @all_fields ||= rules.map(&:field)
    end

    def valid_tickets
      @valid_tickets ||= nearby_tickets.select(&:valid?)
    end

    def order_fields
      valid_tickets.map(&:possible_fields).each { |a| a.reduce(:&) }
                   .then { |a| first_filter a }
    end

    def first_filter(a)
      n = rules.size - 1
      (0..n).map { |i| a.map { |a| a[i] }.inject(:&) }
            .then { |res| extract_identified_fields(res) }
    end

    def extract_identified_fields(fields)
      until ordered_fields.all?
        found, index = fields.each_with_index.find { |field, _i| field.length == 1 }
        ordered_fields[index] = found[0]
        found.flatten.each do |field|
          fields.each { |e| e.delete field }
        end
      end
    end

    def ordered_fields
      @ordered_fields ||= Array.new(rules.size)
    end

    def part2
      order_fields
      ordered_fields.zip(my_ticket.values).to_h.select { |k, _v| k.start_with?("departure") }.values.inject(:*)
    end
  end
end
