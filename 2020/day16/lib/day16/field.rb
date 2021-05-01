module Day16
  class Field
    attr_reader :value

    def initialize(value, ruleset)
      @value = value.to_i
      @ruleset = ruleset
    end

    def valid?
      @ruleset.validate(value)
    end

    def possible_fields
      @ruleset.valid_fields(value)
    end
  end
end
