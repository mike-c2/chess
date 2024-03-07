# frozen_string_literal: true

require_relative '../../lib/white'

describe White do
  subject(:white_object) { white_class.new }
  let(:white_class) { Class.new { include White } }

  describe '#color' do
    it "only returns 'white'" do
      result = white_object.color
      expect(result).to eq('white')
    end
  end

  describe '#font_color' do
    it 'only returns \'\e[37m\'' do
      result = white_object.font_color
      expect(result).to eq("\e[37m")
    end
  end

  describe '#same_side?' do
    let(:other) { double }

    context 'when the other object is not white' do
      before do
        allow(other).to receive(:color).and_return('black')
      end

      it 'returns false' do
        is_expected.not_to be_same_side(other)
      end
    end

    context 'when the other object is white' do
      before do
        allow(other).to receive(:color).and_return('white')
      end

      it 'returns true' do
        is_expected.to be_same_side(other)
      end
    end
  end

  describe '#opponents_side?' do
    let(:other) { double }

    context 'when the other object is neither white nor black' do
      before do
        allow(other).to receive(:color).and_return('none')
      end

      it 'returns false' do
        is_expected.not_to be_opponents_side(other)
      end
    end

    context 'when the other object is white' do
      before do
        allow(other).to receive(:color).and_return('white')
      end

      it 'returns false' do
        is_expected.not_to be_opponents_side(other)
      end
    end

    context 'when the other object is black' do
      before do
        allow(other).to receive(:color).and_return('black')
      end

      it 'returns true' do
        is_expected.to be_opponents_side(other)
      end
    end
  end
end
