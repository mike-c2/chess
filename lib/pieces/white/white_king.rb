# frozen_string_literal: true

require_relative '../king'
require_relative '../../colors/white'
require_relative '../../positionals/position'

##
# Represents the White King in Chess.
class WhiteKing < King
  include White

  def initialize(position = nil, board = self.class.default_board, move_count = 0)
    super

    castling_position = Position.create_with_chess_notation('E1')

    @kingside_castle = KingsideCastle.new(self, castling_position, @board)
    @queenside_castle = QueensideCastle.new(self, castling_position, @board)
  end
end
