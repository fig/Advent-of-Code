require "strscan"
class Monkey
  attr_reader :starting_items, :operation, :test, :if_true, :if_false
  attr_accessor :items_inspected

  def initialize(text)
    @items_inspected = 0
    parse text
  end

  def parse(text)
    s = StringScanner.new(text)
    s.scan_until(/Starting items: /)
    @starting_items = s.scan(/\d+(?:, \d+)*/).split(", ").map(&:to_i)
    s.scan_until(/Operation: new = old /)
    @operation = s.scan(/. .+/).split
    s.scan_until(/Test: divisible by /)
    @test = s.scan(/\d+/).to_i
    s.scan_until(/If true: throw to monkey /)
    @if_true = s.scan(/\d+/).to_i
    s.scan_until(/If false: throw to monkey /)
    @if_false = s.scan(/\d+/).to_i
  end
end
