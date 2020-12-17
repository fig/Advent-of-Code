require_relative "../../lib/solution"

RSpec.describe Solution do
  subject(:solution) { described_class.new(input) }

  let(:input) do
    <<~DATA
      class: 0-1 or 4-19
        row: 0-5 or 8-19
        seat: 0-13 or 16-19

        your ticket:
        11,12,13

        nearby tickets:
        3,9,18
        15,1,5
        5,14,9
    DATA
  end

  describe "#rules" do
    it "is a collection of 3 rules" do
      expect(solution.rules).to all(be_a Rule)
        .and(have_attributes(count: 3))
    end
  end

  describe "#nearby_tickets" do
    it "is a collection of nearby_tickets" do
      expect(solution.nearby_tickets).to all(be_a Ticket)
        .and(have_attributes(count: 3))
    end
  end

  describe "#part1" do
    let(:input) do
      <<~DATA
        class: 1-3 or 5-7
        row: 6-11 or 33-44
        seat: 13-40 or 45-50

        your ticket:
        7,1,14

        nearby tickets:
        7,3,47
        40,4,50
        55,2,20
        38,6,12
      DATA
    end

    it "is correct" do
      expect(solution.part1).to eq 71
    end
  end

  describe "#part2" do
    let(:input) do
      <<~DATA
        class: 0-1 or 4-19
        row: 0-5 or 8-19
        seat: 0-13 or 16-19

        your ticket:
        11,12,13

        nearby tickets:
        3,9,18
        15,1,5
        5,14,9
      DATA
    end

    describe "my_ticket" do
      subject(:my_ticket) { solution.my_ticket }

      it { is_expected.to be_a Ticket }

      it "is expeted to have 3 fields" do
        expect(my_ticket.fields.size).to eq 3
      end
    end

    describe "#all_fields" do
      it "is a collection of all fields" do
        expect(solution.all_fields).to contain_exactly("class", "row", "seat")
      end

      it "is mutable" do
        initial = solution.all_fields
        initial.delete "class"
        expect(solution.all_fields).to contain_exactly("row", "seat")
      end
    end

    describe "#valid_tickets" do
      it "is a collection of all valid tickets" do
        expect(solution.valid_tickets).to have_attributes(count: 3)
      end
    end

    context "with exam data" do
      let(:input) { File.read(File.join(__dir__, "../../input.txt")) }

      it "is correct" do
        expect(solution.part2).to eq 1_515_506_256_421
      end
    end
  end
end
