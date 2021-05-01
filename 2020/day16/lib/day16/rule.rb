module Day16
  class Rule
    attr_reader :field, :ranges

    def initialize(input)
      @input = input
      @field, @ranges = extract_data
    end

    def match?(value)
      @ranges.any? { |r| r.cover? value }
    end

    private

    def extract_data
      [extract_field, extract_ranges]
    end

    def extract_field
      @input.slice(/\A([^:]+):/, 1)
    end

    def extract_ranges
      @input
        .scan(/\d+-\d+/)
        .map { |r| r.split("-") }
        .map! { |d| (d[0].to_i..d[1].to_i) }
    end
  end
end
