# frozen_string_literal: true

require_relative '../../../lib/pieces/empty_piece'

describe EmptyPiece do
  subject(:piece) { described_class.new(board) }
  let(:board) { double }

  describe '#increment_move_count' do
    context 'when move count is at its initial value' do
      it 'count is 0' do
        result = piece.move_count

        expect(result).to eq(0)
      end
    end

    context 'when incremented once' do
      let(:expected_result) { 1 }
      it 'move_count is 1' do
        piece.increment_move_count
        result = piece.move_count

        expect(result).to eq(expected_result)
      end
    end

    context 'when incremented twice' do
      let(:expected_result) { 2 }
      it 'move_count is 2' do
        piece.increment_move_count
        piece.increment_move_count
        result = piece.move_count

        expect(result).to eq(expected_result)
      end
    end
  end
end
