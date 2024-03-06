# frozen_string_literal: true

require_relative '../../lib/move'

describe Move do
  # new is private, must use factory method to get new Move object
  subject(:move) { described_class.create(positions) }

  describe '.create' do
    context 'when positions is nil' do
      let(:positions) { nil }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when positions array only has 1 position' do
      let(:positions) { [position] }
      let(:position) { Position.create_with_chess_notation('E4') }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when positions array has 3 positions' do
      let(:positions) { [first_position, second_position, third_position] }
      let(:first_position) { Position.create_with_chess_notation('E4') }
      let(:second_position) { Position.create_with_chess_notation('A3') }
      let(:third_position) { Position.create_with_chess_notation('G5') }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when both positions are the same' do
      let(:positions) { [first_position, second_position] }
      let(:first_position) { Position.create_with_chess_notation('E4') }
      let(:second_position) { Position.create_with_chess_notation('E4') }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when both positions are valid' do
      let(:positions) { [first_position, second_position] }
      let(:first_position) { Position.create_with_chess_notation('E4') }
      let(:second_position) { Position.create_with_chess_notation('E5') }

      it 'Move object is returned' do
        is_expected.to be_a(described_class)
      end
    end
  end

  describe '#==' do
    context 'when both positions are not equal' do
      let(:positions) { [first_position, second_position] }
      let(:first_position) { Position.create_with_chess_notation('A4') }
      let(:second_position) { Position.create_with_chess_notation('B8') }

      let(:other_move) { described_class.create(other_positions) }
      let(:other_positions) { [other_first_position, other_second_position] }
      let(:other_first_position) { Position.create_with_chess_notation('F1') }
      let(:other_second_position) { Position.create_with_chess_notation('G2') }

      it 'not equal' do
        result = move == other_move
        expect(result).to be(false)
      end
    end

    context 'when only the first position is equal' do
      let(:positions) { [first_position, second_position] }
      let(:first_position) { Position.create_with_chess_notation('A4') }
      let(:second_position) { Position.create_with_chess_notation('B8') }

      let(:other_move) { described_class.create(other_positions) }
      let(:other_positions) { [other_first_position, other_second_position] }
      let(:other_first_position) { Position.create_with_chess_notation('A4') }
      let(:other_second_position) { Position.create_with_chess_notation('G2') }

      it 'not equal' do
        result = move == other_move
        expect(result).to be(false)
      end
    end

    context 'when only the second position is equal' do
      let(:positions) { [first_position, second_position] }
      let(:first_position) { Position.create_with_chess_notation('A4') }
      let(:second_position) { Position.create_with_chess_notation('B8') }

      let(:other_move) { described_class.create(other_positions) }
      let(:other_positions) { [other_first_position, other_second_position] }
      let(:other_first_position) { Position.create_with_chess_notation('A5') }
      let(:other_second_position) { Position.create_with_chess_notation('B8') }

      it 'not equal' do
        result = move == other_move
        expect(result).to be(false)
      end
    end

    context 'when both positions are equal' do
      let(:positions) { [first_position, second_position] }
      let(:first_position) { Position.create_with_chess_notation('A4') }
      let(:second_position) { Position.create_with_chess_notation('B8') }

      let(:other_move) { described_class.create(other_positions) }
      let(:other_positions) { [other_first_position, other_second_position] }
      let(:other_first_position) { Position.create_with_chess_notation('A4') }
      let(:other_second_position) { Position.create_with_chess_notation('B8') }

      it 'equal' do
        result = move == other_move
        expect(result).to be(true)
      end
    end
  end
end
