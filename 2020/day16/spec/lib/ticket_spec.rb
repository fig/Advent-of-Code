require_relative "../../lib/ticket"
require_relative "../../lib/field"

RSpec.describe Ticket do
  subject(:ticket) { described_class.new(fields) }

  let(:field1)  { instance_double(Field, value: 1) }
  let(:field2)  { instance_double(Field, value: 2) }
  let(:fields)  { [field1, field2]                 }

  describe "#fields" do
    it "has 2 fields" do
      expect(ticket.fields.size).to eq 2
    end

    # it "contains an array of fields" do
    #   # expect(ticket.fields).to contain_exactly(4, 5)
    #   expect(ticket.fields).to all(be_a Field)
    # end
  end

  describe "#valid?" do
    subject { ticket.valid? }

    it "asks it's fields if they are valid" do
      allow(field1).to receive(:valid?).and_return(true)
      allow(field2).to receive(:valid?)
      ticket.valid?
      expect([field1, field2]).to all(have_received(:valid?))
    end

    context "when all fields are valid" do
      let(:field1)  { instance_double(Field, valid?: true) }
      let(:field2)  { instance_double(Field, valid?: true) }

      it { is_expected.to be true }
    end

    context "when not all fields are valid" do
      let(:field1) { instance_double(Field, valid?: false) }

      it { is_expected.to be false }
    end
  end

  describe "#invalid_values" do
    it "asks all fields if they are valid" do
      allow(field1).to receive(:valid?)
      allow(field2).to receive(:valid?)
      ticket.invalid_values
      expect([field1, field2]).to all(have_received(:valid?))
    end

    it "returns an Array of invalid values" do
      allow(field1).to receive(:valid?).and_return(false)
      allow(field2).to receive(:valid?).and_return(false)
      expect(ticket.invalid_values).to eq([1, 2])
    end
  end

  describe "#possible_fields" do
    it "asks each field for an array of possible field names" do
      allow(field1).to receive(:possible_fields)
      allow(field2).to receive(:possible_fields)
      ticket.possible_fields
      expect(field2).to have_received(:possible_fields)
    end
  end
end
