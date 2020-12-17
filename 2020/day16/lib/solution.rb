require_relative "ruleset"
require_relative "ticket"

class Solution
  def initialize(data = File.read(File.join(__dir__, "..", "input.txt")))
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
          .then { |res| extract_found(res) }
  end

  def extract_found(a)
    while a.any? { |e| e.length > 0 }
      found = a.select { |e| e.length == 1 }
      a.each_with_index.select { |f, i| f.length == 1 }.flatten!.each_slice(2) do |f, i|
        # jard
        fields_in_order[i] = f
      end
      found.flatten.each do |field|
        a.each { |e| e.delete field }
      end

    end
    # a
  end

  def fields_in_order
    @fields_in_order ||= Array.new(rules.size)
  end

  def part2
    order_fields
    fields_in_order.zip(my_ticket.fields.map(&:value)).to_h.select { |h, k| h.start_with?("departure") }.values.inject(:*)
  end
end
