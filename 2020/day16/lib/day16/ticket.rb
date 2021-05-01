require_relative "field"

module Day16
  class Ticket
    attr_reader :fields

    def initialize(fields)
      @fields = fields
    end

    def values
      @fields.map(&:value)
    end

    def valid?
      @fields.all?(&:valid?)
    end

    def invalid_values
      @fields.reject(&:valid?).map!(&:value)
    end

    def possible_fields
      @fields.map(&:possible_fields)
    end
  end
end
