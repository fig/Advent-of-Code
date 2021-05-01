require "day16/ruleset"
require "day16/rule"
require "day16/field"

module Day16
  RSpec.describe Ruleset do
    subject(:ruleset) { described_class.new(rules) }

    let(:rule1) { instance_double Rule }
    let(:rule2) { instance_double Rule }
    let(:rules) { [rule1, rule2]       }

    describe "valid_fields" do
      let(:rule1) { instance_double Rule, field: "foo", match?: true }
      let(:rule2) { instance_double Rule, field: "bar", match?: false }

      it "returns an array of valid fields for given value" do
        expect(ruleset.valid_fields(0)).to contain_exactly("foo")
      end
    end

    describe "#validate" do
      subject { ruleset.validate(field) }

      let(:field) { instance_double(Field, value: 7) }

      it "asks any rule to match the field" do
        allow(rule1).to receive(:match?).and_return(false)
        allow(rule2).to receive(:match?)

        ruleset.validate(field)

        expect(rule2).to have_received(:match?)
      end

      context "when given a valid field" do
        let(:rule1) { instance_double Rule, match?: true }

        it { is_expected.to be true }
      end

      context "when given an invalid field" do
        let(:rule1) { instance_double Rule, match?: false }
        let(:rule2) { instance_double Rule, match?: false }

        it { is_expected.to be false }
      end
    end
  end
end
