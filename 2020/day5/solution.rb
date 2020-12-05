def test_data
  # <<~DATA
  #   BFFFBBFRRR
  #   FFFBBBFRRR
  #   BBFFBBFRLL
  # DATA
end

INPUT = test_data || File.read(File.join(__dir__, "input.txt"))

class Pass
  ROWS = (0..127).to_a.freeze
  COLUMNS = (0..7).to_a.freeze
  LEFT_HALF = %w[L F].freeze

  def initialize(code)
    @code = code
  end

  def id
    @id ||= calculate_id
  end

  private

  def calculate_id
    (row * 8) + column
  end

  def row
    @row ||= calculate_row
  end

  def column
    @column ||= calculate_column
  end

  def calculate_row
    codes = @code[0..6].chars
    seats = ROWS.dup
    find(codes, seats)
  end

  def calculate_column
    codes = @code[7..9].chars
    seats = COLUMNS.dup
    find(codes, seats)
  end

  def find(codes, seats)
    while codes.any?
      codes.shift.tap do |c|
        m = seats.size / 2
        LEFT_HALF.include?(c) ? seats.slice!(m..) : seats.slice!(0, m)
      end
    end
    seats[0]
  end
end

def boarding_pass_ids
  @boarding_pass_ids = INPUT.split.map { |data| Pass.new(data).id }
end

def part1
  boarding_pass_ids.max
end

def part2
  ((81..855).to_a - boarding_pass_ids)[0]
end

puts "Solution part1:\n#{part1}"
puts "Solution part2:\n#{part2}" if part2
