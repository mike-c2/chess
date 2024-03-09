# frozen_string_literal: true

require_relative '../../../lib/board/piece_maker'
require_relative '../../../lib/positionals/position'
require_relative '../../../lib/pieces/all_colored_pieces'

describe PieceMaker do
  subject(:piece_maker) { described_class.new(board) }
  let(:board) { double('board') }
  let(:position) { double('position') }

  let(:white_king) { double('white king') }
  let(:white_queen) { double('white queen') }
  let(:white_bishop) { double('white bishop') }
  let(:white_knight) { double('white knight') }
  let(:white_rook) { double('white rook') }
  let(:white_pawn) { double('white pawn') }

  let(:black_king) { double('black king') }
  let(:black_queen) { double('black queen') }
  let(:black_bishop) { double('black bishop') }
  let(:black_knight) { double('black knight') }
  let(:black_rook) { double('black rook') }
  let(:black_pawn) { double('black pawn') }

  before do
    allow(Position).to receive(:create_with_chess_notation).and_return(position)
    allow(board).to receive(:place)

    allow(WhiteKing).to receive(:new).and_return(white_king)
    allow(WhiteQueen).to receive(:new).and_return(white_queen)
    allow(WhiteBishop).to receive(:new).and_return(white_bishop)
    allow(WhiteKnight).to receive(:new).and_return(white_knight)
    allow(WhiteRook).to receive(:new).and_return(white_rook)
    allow(WhitePawn).to receive(:new).and_return(white_pawn)

    allow(BlackKing).to receive(:new).and_return(black_king)
    allow(BlackQueen).to receive(:new).and_return(black_queen)
    allow(BlackBishop).to receive(:new).and_return(black_bishop)
    allow(BlackKnight).to receive(:new).and_return(black_knight)
    allow(BlackRook).to receive(:new).and_return(black_rook)
    allow(BlackPawn).to receive(:new).and_return(black_pawn)
  end

  describe '#created?' do
    let(:color) { 'white' }
    let(:type) { 'king' }
    let(:location) { 'E1' }

    context "when color is neither 'white' nor 'black'" do
      let(:color) { 'red' }

      it 'returns false' do
        is_expected.not_to be_created(color: color, type: type, location: location)
      end
    end

    context 'when location is not valid' do
      let(:location) { 'X10' }

      before do
        allow(Position).to receive(:create_with_chess_notation).and_return(nil)
      end

      it 'returns false' do
        is_expected.not_to be_created(color: color, type: type, location: location)
      end
    end

    context 'when type is not valid' do
      let(:type) { 'wizard' }

      it 'returns false' do
        is_expected.not_to be_created(color: color, type: type, location: location)
      end
    end

    context "when the color is 'white'" do
      let(:color) { 'white' }

      context "when the type is 'king'" do
        let(:type) { 'king' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end
      end

      context "when the type is 'queen'" do
        let(:type) { 'queen' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end
      end

      context "when the type is 'bishop'" do
        let(:type) { 'bishop' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end
      end

      context "when the type is 'knight'" do
        let(:type) { 'knight' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end
      end

      context "when the type is 'rook'" do
        let(:type) { 'rook' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end
      end

      context "when the type is 'pawn'" do
        let(:type) { 'pawn' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end
      end
    end

    context "when the color is 'black'" do
      let(:color) { 'black' }

      context "when the type is 'king'" do
        let(:type) { 'king' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end
      end

      context "when the type is 'queen'" do
        let(:type) { 'queen' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end
      end

      context "when the type is 'bishop'" do
        let(:type) { 'bishop' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end
      end

      context "when the type is 'knight'" do
        let(:type) { 'knight' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end
      end

      context "when the type is 'rook'" do
        let(:type) { 'rook' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end
      end

      context "when the type is 'pawn'" do
        let(:type) { 'pawn' }

        it 'returns true' do
          is_expected.to be_created(color: color, type: type, location: location)
        end
      end
    end
  end
end
