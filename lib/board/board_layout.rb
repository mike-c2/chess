# frozen_string_literal: true

require_relative 'piece_maker'
require_relative 'board'

##
# Sets up the chess pieces on the board to start a game.
#
# It comes with some pre-configured setups.
class BoardLayout
  @standard = { turn: 'white', pieces: [
    { color: 'white', type: 'rook', location: 'A1' },
    { color: 'white', type: 'knight', location: 'B1' },
    { color: 'white', type: 'bishop', location: 'C1' },
    { color: 'white', type: 'queen', location: 'D1' },
    { color: 'white', type: 'king', location: 'E1' },
    { color: 'white', type: 'bishop', location: 'F1' },
    { color: 'white', type: 'knight', location: 'G1' },
    { color: 'white', type: 'rook', location: 'H1' },

    { color: 'white', type: 'pawn', location: 'A2' },
    { color: 'white', type: 'pawn', location: 'B2' },
    { color: 'white', type: 'pawn', location: 'C2' },
    { color: 'white', type: 'pawn', location: 'D2' },
    { color: 'white', type: 'pawn', location: 'E2' },
    { color: 'white', type: 'pawn', location: 'F2' },
    { color: 'white', type: 'pawn', location: 'G2' },
    { color: 'white', type: 'pawn', location: 'H2' },

    { color: 'black', type: 'pawn', location: 'A7' },
    { color: 'black', type: 'pawn', location: 'B7' },
    { color: 'black', type: 'pawn', location: 'C7' },
    { color: 'black', type: 'pawn', location: 'D7' },
    { color: 'black', type: 'pawn', location: 'E7' },
    { color: 'black', type: 'pawn', location: 'F7' },
    { color: 'black', type: 'pawn', location: 'G7' },
    { color: 'black', type: 'pawn', location: 'H7' },

    { color: 'black', type: 'rook', location: 'A8' },
    { color: 'black', type: 'knight', location: 'B8' },
    { color: 'black', type: 'bishop', location: 'C8' },
    { color: 'black', type: 'queen', location: 'D8' },
    { color: 'black', type: 'king', location: 'E8' },
    { color: 'black', type: 'bishop', location: 'F8' },
    { color: 'black', type: 'knight', location: 'G8' },
    { color: 'black', type: 'rook', location: 'H8' }
  ] }

  @no_pawns = { turn: 'white', pieces: [
    { color: 'white', type: 'rook', location: 'A1' },
    { color: 'white', type: 'knight', location: 'B1' },
    { color: 'white', type: 'bishop', location: 'C1' },
    { color: 'white', type: 'queen', location: 'D1' },
    { color: 'white', type: 'king', location: 'E1' },
    { color: 'white', type: 'bishop', location: 'F1' },
    { color: 'white', type: 'knight', location: 'G1' },
    { color: 'white', type: 'rook', location: 'H1' },

    { color: 'black', type: 'rook', location: 'A8' },
    { color: 'black', type: 'knight', location: 'B8' },
    { color: 'black', type: 'bishop', location: 'C8' },
    { color: 'black', type: 'queen', location: 'D8' },
    { color: 'black', type: 'king', location: 'E8' },
    { color: 'black', type: 'bishop', location: 'F8' },
    { color: 'black', type: 'knight', location: 'G8' },
    { color: 'black', type: 'rook', location: 'H8' }
  ] }

  @kings_only = { turn: 'white', pieces: [
    { color: 'white', type: 'king', location: 'E1' },
    { color: 'black', type: 'king', location: 'E8' }
  ] }

  @white_queenside_rook = { turn: 'white', pieces: [
    { color: 'white', type: 'rook', location: 'A1' },
    { color: 'white', type: 'king', location: 'E1' },
    { color: 'black', type: 'king', location: 'E8' }
  ] }

  @white_kingside_rook = { turn: 'white', pieces: [
    { color: 'white', type: 'king', location: 'E1' },
    { color: 'white', type: 'rook', location: 'H1' },
    { color: 'black', type: 'king', location: 'E8' }
  ] }

  @black_queenside_rook = { turn: 'black', pieces: [
    { color: 'black', type: 'rook', location: 'A8' },
    { color: 'white', type: 'king', location: 'E1' },
    { color: 'black', type: 'king', location: 'E8' }
  ] }

  @black_kingside_rook = { turn: 'black', pieces: [
    { color: 'white', type: 'king', location: 'E1' },
    { color: 'black', type: 'rook', location: 'H8' },
    { color: 'black', type: 'king', location: 'E8' }
  ] }

  @setups = { standard: @standard,
              no_pawns: @no_pawns,
              kings_only: @kings_only,
              white_queenside_rook: @white_queenside_rook,
              white_kingside_rook: @white_kingside_rook,
              black_queenside_rook: @black_queenside_rook,
              black_kingside_rook: @black_kingside_rook }

  def initialize(board)
    @board = board
    @piece_maker = PieceMaker.new(board)
  end

  def setup(board_layout = 'standard')
    setup_key = board_layout.to_sym
    return unless self.class.setups.key?(setup_key)

    layout = self.class.setups[setup_key]

    layout[:pieces].each do |piece|
      @piece_maker.created?(**piece)
    end
  end

  class << self
    attr_reader :setups
  end
end
