# frozen_string_literal: true

require_relative '../../../lib/board/board'
require_relative '../../../lib/positionals/position'
require_relative '../../../lib/pieces/all_colored_pieces'

describe Board do
  subject(:board) { described_class.new }

  describe '#initialize' do
    describe 'initial board' do
      it 'has no chess pieces' do
        all_pieces = board.all_pieces
        expect(all_pieces.length).to eq(0)
      end
    end
  end

  describe '#place' do
    context 'when placing a piece with no position' do
      let(:white_king) { WhiteKing.new(nil, board) }

      it 'nil is returned' do
        result = board.place(white_king)

        expect(result).to be_nil
      end

      it 'there is no piece on the board' do
        all_pieces = board.all_pieces
        expect(all_pieces.length).to eq(0)
      end
    end

    context 'when placing a piece that is neither black nor white' do
      let(:bishop) { Bishop.new(position, board) }
      let(:position) { Position.create_with_chess_notation(location) }
      let(:location) { 'B4' }

      it 'nil is returned' do
        result = board.place(bishop)

        expect(result).to be_nil
      end

      it 'there is no piece on the board' do
        all_pieces = board.all_pieces
        expect(all_pieces.length).to eq(0)
      end
    end

    context 'when placing a piece that is white' do
      let(:white_knight) { WhiteKnight.new(position, board) }
      let(:position) { Position.create_with_chess_notation(location) }
      let(:location) { 'C2' }

      it 'nil is returned' do
        result = board.place(white_knight)

        expect(result).to be_nil
      end

      it 'there is 1 piece on the board' do
        board.place(white_knight)
        all_pieces = board.all_pieces

        expect(all_pieces.length).to eq(1)
      end

      it 'the piece returned by all_pieces is the same that was placed' do
        board.place(white_knight)
        result = board.all_pieces.first

        expect(result).to be(white_knight)
      end

      it 'the piece returned by get is the same that was placed' do
        board.place(white_knight)
        result = board.get(position)

        expect(result).to be(white_knight)
      end
    end

    context 'when placing a piece that is black' do
      let(:black_rook) { BlackRook.new(position, board) }
      let(:position) { Position.create_with_chess_notation(location) }
      let(:location) { 'H7' }

      it 'nil is returned' do
        result = board.place(black_rook)

        expect(result).to be_nil
      end

      it 'there is 1 piece on the board' do
        board.place(black_rook)
        all_pieces = board.all_pieces

        expect(all_pieces.length).to eq(1)
      end

      it 'the piece returned by all_pieces is the same that was placed' do
        board.place(black_rook)
        result = board.all_pieces.first

        expect(result).to be(black_rook)
      end

      it 'the piece returned by get is the same that was placed' do
        board.place(black_rook)
        result = board.get(position)

        expect(result).to be(black_rook)
      end
    end

    context 'when a piece is placed on top of another piece' do
      let(:black_bishop) { BlackBishop.new(position, board) }
      let(:white_queen) { WhiteQueen.new(position, board) }
      let(:position) { Position.create_with_chess_notation('G1') }

      it 'first piece is returned' do
        board.place(black_bishop)
        result = board.place(white_queen)

        expect(result).to be(black_bishop)
      end

      it 'there is 1 piece on the board' do
        board.place(black_bishop)
        board.place(white_queen)
        all_pieces = board.all_pieces

        expect(all_pieces.length).to eq(1)
      end

      it 'the piece returned by all_pieces is the second piece placed' do
        board.place(black_bishop)
        board.place(white_queen)
        result = board.all_pieces.first

        expect(result).to be(white_queen)
      end

      it 'the piece returned by get is the second piece placed' do
        board.place(black_bishop)
        board.place(white_queen)
        result = board.get(position)

        expect(result).to be(white_queen)
      end
    end

    context 'when 2 pieces of the same color and type are placed on the board' do
      let(:first_black_pawn) { BlackPawn.new(first_position, board) }
      let(:first_position) { Position.create_with_chess_notation('B4') }

      let(:second_black_pawn) { BlackPawn.new(second_position, board) }
      let(:second_position) { Position.create_with_chess_notation('B5') }

      it 'there are 2 pieces on the board' do
        board.place(first_black_pawn)
        board.place(second_black_pawn)
        all_pieces = board.all_pieces

        expect(all_pieces.length).to eq(2)
      end

      it 'the 2 pieces on the board are not the same object' do
        board.place(first_black_pawn)
        board.place(second_black_pawn)

        first_result, second_result = board.all_pieces

        expect(first_result).to_not be(second_result)
      end

      it 'the first piece is present on the board' do
        board.place(first_black_pawn)
        board.place(second_black_pawn)

        all_pieces = board.all_pieces

        expect(all_pieces).to be_include(first_black_pawn)
      end

      it 'the second piece is present on the board' do
        board.place(first_black_pawn)
        board.place(second_black_pawn)

        all_pieces = board.all_pieces

        expect(all_pieces).to be_include(second_black_pawn)
      end
    end

    context 'when 3 pieces are placed on the board' do
      let(:white_pawn) { WhitePawn.new(first_position, board) }
      let(:first_position) { Position.create_with_chess_notation('A2') }

      let(:black_king) { BlackKing.new(second_position, board) }
      let(:second_position) { Position.create_with_chess_notation('C7') }

      let(:black_queen) { BlackQueen.new(third_position, board) }
      let(:third_position) { Position.create_with_chess_notation('B8') }

      it 'there are 3 pieces on the board' do
        board.place(white_pawn)
        board.place(black_king)
        board.place(black_queen)

        all_pieces = board.all_pieces

        expect(all_pieces.length).to eq(3)
      end
    end
  end

  describe '#get' do
    context 'when there are 3 pieces on the board' do
      let(:black_pawn) { BlackPawn.new(first_position, board) }
      let(:first_position) { Position.create_with_chess_notation('F4') }

      let(:white_bishop) { WhiteBishop.new(second_position, board) }
      let(:second_position) { Position.create_with_chess_notation('F5') }

      let(:black_knight) { BlackKnight.new(third_position, board) }
      let(:third_position) { Position.create_with_chess_notation('F6') }

      context 'when getting an empty square' do
        let(:empty_position) { Position.create_with_chess_notation('A1') }

        it 'nil is returned' do
          board.place(black_pawn)
          board.place(white_bishop)
          board.place(black_knight)
          result = board.get(empty_position)

          expect(result).to be_nil
        end

        it 'there are 3 pieces on the board' do
          board.place(black_pawn)
          board.place(white_bishop)
          board.place(black_knight)
          board.get(empty_position)
          all_pieces = board.all_pieces

          expect(all_pieces.length).to eq(3)
        end
      end

      context 'when getting the first piece' do
        it 'first piece is returned' do
          board.place(black_pawn)
          board.place(white_bishop)
          board.place(black_knight)
          result = board.get(first_position)

          expect(result).to be(black_pawn)
        end

        it 'there are 3 pieces on the board' do
          board.place(black_pawn)
          board.place(white_bishop)
          board.place(black_knight)
          board.get(first_position)
          all_pieces = board.all_pieces

          expect(all_pieces.length).to eq(3)
        end
      end

      context 'when getting the second piece' do
        it 'second piece is returned' do
          board.place(black_pawn)
          board.place(white_bishop)
          board.place(black_knight)
          result = board.get(second_position)

          expect(result).to be(white_bishop)
        end

        it 'there are 3 pieces on the board' do
          board.place(black_pawn)
          board.place(white_bishop)
          board.place(black_knight)
          board.get(second_position)
          all_pieces = board.all_pieces

          expect(all_pieces.length).to eq(3)
        end
      end

      context 'when getting the third piece' do
        it 'third piece is returned' do
          board.place(black_pawn)
          board.place(white_bishop)
          board.place(black_knight)
          result = board.get(third_position)

          expect(result).to be(black_knight)
        end

        it 'there are 3 pieces on the board' do
          board.place(black_pawn)
          board.place(white_bishop)
          board.place(black_knight)
          board.get(third_position)
          all_pieces = board.all_pieces

          expect(all_pieces.length).to eq(3)
        end
      end
    end
  end

  describe '#remove' do
    context 'when there are 3 pieces on the board' do
      let(:white_rook) { WhiteRook.new(first_position, board) }
      let(:first_position) { Position.create_with_chess_notation('F4') }

      let(:white_bishop) { WhiteBishop.new(second_position, board) }
      let(:second_position) { Position.create_with_chess_notation('F5') }

      let(:black_bishop) { BlackBishop.new(third_position, board) }
      let(:third_position) { Position.create_with_chess_notation('F6') }

      context 'when removing an empty square' do
        let(:empty_position) { Position.create_with_chess_notation('H8') }

        it 'nil is returned' do
          board.place(white_rook)
          board.place(white_bishop)
          board.place(black_bishop)
          result = board.remove(empty_position)

          expect(result).to be_nil
        end

        it 'there are 3 pieces on the board' do
          board.place(white_rook)
          board.place(white_bishop)
          board.place(black_bishop)
          board.remove(empty_position)
          all_pieces = board.all_pieces

          expect(all_pieces.length).to eq(3)
        end

        it 'first piece is on the board' do
          board.place(white_rook)
          board.place(white_bishop)
          board.place(black_bishop)
          board.remove(empty_position)
          result = board.get(first_position)

          expect(result).to be(white_rook)
        end

        it 'second piece is on the board' do
          board.place(white_rook)
          board.place(white_bishop)
          board.place(black_bishop)
          board.remove(empty_position)
          result = board.get(second_position)

          expect(result).to be(white_bishop)
        end

        it 'third piece is on the board' do
          board.place(white_rook)
          board.place(white_bishop)
          board.place(black_bishop)
          board.remove(empty_position)
          result = board.get(third_position)

          expect(result).to be(black_bishop)
        end
      end

      context 'when first piece is removed' do
        it 'returns the first piece' do
          board.place(white_rook)
          board.place(white_bishop)
          board.place(black_bishop)
          result = board.remove(first_position)

          expect(result).to be(white_rook)
        end

        it 'there are 2 pieces on the board' do
          board.place(white_rook)
          board.place(white_bishop)
          board.place(black_bishop)
          board.remove(first_position)
          all_pieces = board.all_pieces

          expect(all_pieces.length).to eq(2)
        end

        it 'second piece is on the board' do
          board.place(white_rook)
          board.place(white_bishop)
          board.place(black_bishop)
          board.remove(first_position)
          result = board.get(second_position)

          expect(result).to be(white_bishop)
        end

        it 'third piece is on the board' do
          board.place(white_rook)
          board.place(white_bishop)
          board.place(black_bishop)
          board.remove(first_position)
          result = board.get(third_position)

          expect(result).to be(black_bishop)
        end
      end

      context 'when the first 2 pieces are removed from the board' do
        it 'there is 1 piece on the board' do
          board.place(white_rook)
          board.place(white_bishop)
          board.place(black_bishop)
          board.remove(first_position)
          board.remove(second_position)
          all_pieces = board.all_pieces

          expect(all_pieces.length).to eq(1)
        end

        it 'third piece is on the board' do
          board.place(white_rook)
          board.place(white_bishop)
          board.place(black_bishop)
          board.remove(first_position)
          board.remove(second_position)
          result = board.get(third_position)

          expect(result).to be(black_bishop)
        end
      end

      context 'when all the pieces are removed from the board' do
        it 'there are 0 pieces on the board' do
          board.place(white_rook)
          board.place(white_bishop)
          board.place(black_bishop)
          board.remove(first_position)
          board.remove(second_position)
          board.remove(third_position)
          all_pieces = board.all_pieces

          expect(all_pieces.length).to eq(0)
        end
      end
    end
  end

  describe '#clear' do
    context 'when there are 3 pieces on the board' do
      let(:white_knight) { WhiteKnight.new(first_position, board) }
      let(:first_position) { Position.create_with_chess_notation('C1') }

      let(:white_pawn) { WhitePawn.new(second_position, board) }
      let(:second_position) { Position.create_with_chess_notation('C2') }

      let(:black_queen) { BlackQueen.new(third_position, board) }
      let(:third_position) { Position.create_with_chess_notation('D8') }

      it 'there are 0 pieces on the board' do
        board.place(white_knight)
        board.place(white_pawn)
        board.place(black_queen)
        board.clear
        all_pieces = board.all_pieces

        expect(all_pieces.length).to eq(0)
      end
    end
  end
end
