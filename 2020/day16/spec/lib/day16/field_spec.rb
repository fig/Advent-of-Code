require "day16/field"
require "day16/ruleset"

module Day16
  RSpec.describe Field do
    subject(:field) { described_class.new(value, ruleset) }

    let(:value)     { "7"                     }
    let(:ruleset)   { instance_double Ruleset }

    describe "#initialize" do
      it "converts the 'value' argument to an Int" do
        expect(field.value).to eq 7
      end
    end

    describe "#valid?" do
      it "tells its ruleset to validate its value" do
        allow(ruleset).to receive(:validate)

        field.valid?

        expect(ruleset).to have_received(:validate).with(7)
      end
    end

    describe "#possible_fields" do
      it "asks its ruleset for fields matching value" do
        allow(ruleset).to receive(:valid_fields)

        field.possible_fields

        expect(ruleset).to have_received(:valid_fields).with(7)
      end
    end
  end
end
