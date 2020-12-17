require_relative "field"

class Ticket
  attr_reader :fields

  # include Enumerable
  def initialize(fields)
    @fields = fields
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
