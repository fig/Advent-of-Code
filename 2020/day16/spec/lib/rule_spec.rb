require_relative "../../lib/rule"

RSpec.describe Rule do
  subject(:rule) { described_class.new(text) }

  let(:text) { "class: 0-1 or 4-19" }

  describe "#initialize" do
    it "extracts the field name" do
      expect(rule.field).to eq "class"
    end

    context "when field name is 2 words" do
      let(:text) { "foo bar: 0-1 or 4-19" }

      it "extracts both words" do
        expect(rule.field).to eq "foo bar"
      end
    end

    it "extracts the ranges " do
      expect(rule.ranges).to eq [(0..1), (4..19)]
    end
  end

  describe "#match?" do
    subject { rule.match?(value) }

    context "when passed a valid value" do
      let(:text) { "class: 0-1 or 4-19" }

      values = [0, 1, 4, 9, 19]
      values.each do |v|
        let(:value) { v }

        it { is_expected.to be true }
      end
    end

    context "when passed an invalid value" do
      let(:text) { "class: 0-1 or 4-19" }

      values = [-1, 2, 3, 20]
      values.each do |v|
        let(:value) { v }

        it { is_expected.to be false }
      end
    end
  end
end
