require_relative "solution"

RSpec.describe Solution::Display do
  subject(:display) { described_class.new input }

  let(:input) {
    "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
  }

  specify do
    expect(display.signal).to eq %w[acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab]
  end
  specify { expect(display.output).to eq %w[cdfeb fcadb cdfeb cdbaf] }

  describe "when decoded" do
    before(:each) { display.decode }

    specify { expect(display.one).to eq "ab" }
    specify { expect(display.two).to eq "gcdfa" }
    specify { expect(display.three).to eq "fbcad" }
    specify { expect(display.four).to eq "eafb" }
    specify { expect(display.five).to eq "cdfbe" }
    specify { expect(display.six).to eq "cdfgeb" }
    specify { expect(display.seven).to eq "dab" }
    specify { expect(display.eight).to eq "acedgfb" }
    specify { expect(display.nine).to eq "cefabd" }
    specify { expect(display.zero).to eq "cagedb" }
  end

  specify { expect(display.solve).to eq(5_353) }
end
