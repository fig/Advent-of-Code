require_relative "rule"

class Ruleset
  def initialize(rules)
    @rules = rules
  end

  def validate(value)
    @rules.any? { |r| r.match? value }
  end

  def valid_fields(value)
    @rules.select { |r| r.match? value }.map(&:field)
  end
end
