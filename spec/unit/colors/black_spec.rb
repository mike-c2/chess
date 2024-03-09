# frozen_string_literal: true

require_relative '../../../lib/colors/black'

describe Black do
  subject(:black_object) { black_class.new }
  let(:black_class) { Class.new { include Black } }

  describe '#color' do
    it "only returns 'black'" do
      result = black_object.color
      expect(result).to eq('black')
    end
  end

  describe '#font_color' do
    it 'only returns \'\e[30m\'' do
      result = black_object.font_color
      expect(result).to eq("\e[30m")
    end
  end

  describe '#same_side?' do
    let(:other) { double }

    context 'when the other object is not black' do
      before do
        allow(other).to receive(:color).and_return('white')
      end

      it 'returns false' do
        is_expected.not_to be_same_side(other)
      end
    end

    context 'when the other object is black' do
      before do
        allow(other).to receive(:color).and_return('black')
      end

      it 'returns true' do
        is_expected.to be_same_side(other)
      end
    end
  end

  describe '#opponents_side?' do
    let(:other) { double }

    context 'when the other object is neither black nor white' do
      before do
        allow(other).to receive(:white?).and_return(false)
      end

      it 'returns false' do
        is_expected.not_to be_opponents_side(other)
      end
    end

    context 'when the other object is black' do
      before do
        allow(other).to receive(:white?).and_return(false)
      end

      it 'returns false' do
        is_expected.not_to be_opponents_side(other)
      end
    end

    context 'when the other object is white' do
      before do
        allow(other).to receive(:white?).and_return(true)
      end

      it 'returns true' do
        is_expected.to be_opponents_side(other)
      end
    end
  end

  describe '#black?' do
    it 'only returns true' do
      is_expected.to be_black
    end
  end

  describe '#white?' do
    it 'only returns false' do
      is_expected.not_to be_white
    end
  end
end
