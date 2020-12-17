class Rule
  attr_reader :field, :ranges

  def initialize(input_string)
    @input_string = input_string
    @field = extract_field
    @ranges = extract_ranges
  end

  def match?(value)
    @ranges.any? { |r| r.cover? value }
  end

  private

  def extract_field
    @input_string.slice(/\A([^:]+):/, 1)
  end

  def extract_ranges
    @input_string
      .scan(/\d+-\d+/)
      .map { |r| r.split("-") }
      .map! { |d| (d[0].to_i..d[1].to_i) }
  end
end
