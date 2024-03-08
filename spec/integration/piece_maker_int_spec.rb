# frozen_string_literal: true

require_relative '../../lib/piece_maker'
require_relative '../../lib/board'
require_relative '../../lib/positionals/position'
require_relative '../../lib/pieces/all_colored_pieces'

describe PieceMaker do
  subject(:piece_maker) { described_class.new(board) }
  let(:board) { Board.new }
  let(:piece) { board.get(position) }
  let(:position) { Position.create_with_chess_notation(location) }

  describe '#created?' do
    context "when color is 'white'" do
      let(:color) { 'white' }

      context "when the type is 'king'" do
        let(:type) { 'king' }
        let(:location) { 'E1' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end

        it 'piece is present on the board' do
          piece_maker.created?(color: color, type: type, location: location)

          expect(piece).to be_a(WhiteKing)
        end
      end

      context "when the type is 'queen'" do
        let(:type) { 'queen' }
        let(:location) { 'D1' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end

        it 'piece is present on the board' do
          piece_maker.created?(color: color, type: type, location: location)

          expect(piece).to be_a(WhiteQueen)
        end
      end

      context "when the type is 'bishop'" do
        let(:type) { 'bishop' }
        let(:location) { 'C1' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end

        it 'piece is present on the board' do
          piece_maker.created?(color: color, type: type, location: location)

          expect(piece).to be_a(WhiteBishop)
        end
      end

      context "when the type is 'knight'" do
        let(:type) { 'knight' }
        let(:location) { 'B1' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end

        it 'piece is present on the board' do
          piece_maker.created?(color: color, type: type, location: location)

          expect(piece).to be_a(WhiteKnight)
        end
      end

      context "when the type is 'rook'" do
        let(:type) { 'rook' }
        let(:location) { 'A1' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end

        it 'piece is present on the board' do
          piece_maker.created?(color: color, type: type, location: location)

          expect(piece).to be_a(WhiteRook)
        end
      end

      context "when the type is 'pawn'" do
        let(:type) { 'pawn' }
        let(:location) { 'E2' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end

        it 'piece is present on the board' do
          piece_maker.created?(color: color, type: type, location: location)

          expect(piece).to be_a(WhitePawn)
        end
      end
    end

    context "when color is 'black'" do
      let(:color) { 'black' }

      context "when the type is 'king'" do
        let(:type) { 'king' }
        let(:location) { 'E8' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end

        it 'piece is present on the board' do
          piece_maker.created?(color: color, type: type, location: location)

          expect(piece).to be_a(BlackKing)
        end
      end

      context "when the type is 'queen'" do
        let(:type) { 'queen' }
        let(:location) { 'D8' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end

        it 'piece is present on the board' do
          piece_maker.created?(color: color, type: type, location: location)

          expect(piece).to be_a(BlackQueen)
        end
      end

      context "when the type is 'bishop'" do
        let(:type) { 'bishop' }
        let(:location) { 'C8' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end

        it 'piece is present on the board' do
          piece_maker.created?(color: color, type: type, location: location)

          expect(piece).to be_a(BlackBishop)
        end
      end

      context "when the type is 'knight'" do
        let(:type) { 'knight' }
        let(:location) { 'B8' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end

        it 'piece is present on the board' do
          piece_maker.created?(color: color, type: type, location: location)

          expect(piece).to be_a(BlackKnight)
        end
      end

      context "when the type is 'rook'" do
        let(:type) { 'rook' }
        let(:location) { 'A8' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end

        it 'piece is present on the board' do
          piece_maker.created?(color: color, type: type, location: location)

          expect(piece).to be_a(BlackRook)
        end
      end

      context "when the type is 'pawn'" do
        let(:type) { 'pawn' }
        let(:location) { 'E7' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end

        it 'piece is present on the board' do
          piece_maker.created?(color: color, type: type, location: location)

          expect(piece).to be_a(BlackPawn)
        end
      end
    end
  end
end
