# frozen_string_literal: true

require_relative '../../../lib/positionals/move'

describe Move do
  # new is private, must use factory method to get new Move object
  subject(:move) { described_class.create(starting_position, ending_position) }
  let(:starting_position) { Position.create_with_chess_notation('E4') }
  let(:ending_position) { Position.create_with_chess_notation('A3') }

  describe '.create' do
    context 'when starting_position and ending_position are nil' do
      let(:starting_position) { nil }
      let(:ending_position) { nil }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when the starting_position is nil' do
      let(:starting_position) { nil }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when the ending_position is nil' do
      let(:ending_position) { nil }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when both positions are the same' do
      let(:starting_position) { Position.create_with_chess_notation('E4') }
      let(:ending_position) { Position.create_with_chess_notation('E4') }

      it 'nil is returned' do
        is_expected.to be_nil
      end
    end

    context 'when both positions are valid' do
      it 'Move object is returned' do
        is_expected.to be_a(described_class)
      end
    end
  end

  describe '#==' do
    context 'when both positions are not equal' do
      let(:starting_position) { Position.create_with_chess_notation('A4') }
      let(:ending_position) { Position.create_with_chess_notation('B8') }

      let(:other_move) { described_class.create(other_starting_position, other_ending_position) }
      let(:other_starting_position) { Position.create_with_chess_notation('F1') }
      let(:other_ending_position) { Position.create_with_chess_notation('G2') }

      it 'not equal' do
        result = move == other_move
        expect(result).to be(false)
      end
    end

    context 'when only the first position is equal' do
      let(:starting_position) { Position.create_with_chess_notation('A4') }
      let(:ending_position) { Position.create_with_chess_notation('B8') }

      let(:other_move) { described_class.create(other_starting_position, other_ending_position) }
      let(:other_starting_position) { Position.create_with_chess_notation('A4') }
      let(:other_ending_position) { Position.create_with_chess_notation('G2') }

      it 'not equal' do
        result = move == other_move
        expect(result).to be(false)
      end
    end

    context 'when only the second position is equal' do
      let(:starting_position) { Position.create_with_chess_notation('A4') }
      let(:ending_position) { Position.create_with_chess_notation('B8') }

      let(:other_move) { described_class.create(other_starting_position, other_ending_position) }
      let(:other_starting_position) { Position.create_with_chess_notation('A5') }
      let(:other_ending_position) { Position.create_with_chess_notation('B8') }

      it 'not equal' do
        result = move == other_move
        expect(result).to be(false)
      end
    end

    context 'when both positions are equal' do
      let(:starting_position) { Position.create_with_chess_notation('A4') }
      let(:ending_position) { Position.create_with_chess_notation('B8') }

      let(:other_move) { described_class.create(other_starting_position, other_ending_position) }
      let(:other_starting_position) { Position.create_with_chess_notation('A4') }
      let(:other_ending_position) { Position.create_with_chess_notation('B8') }

      it 'equal' do
        result = move == other_move
        expect(result).to be(true)
      end
    end
  end
end
