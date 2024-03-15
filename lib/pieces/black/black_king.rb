# frozen_string_literal: true

require_relative '../king'
require_relative '../../colors/black'
require_relative '../../positionals/position'
require_relative '../castling/kingside_castle'
require_relative '../castling/queenside_castle'

##
# Represents the Black King in Chess.
class BlackKing < King
  include Black

  def initialize(position = nil, board = self.class.default_board, move_count = 0)
    super

    castling_position = Position.create_with_chess_notation('E8')

    @kingside_castle = KingsideCastle.new(self, castling_position, @board)
    @queenside_castle = QueensideCastle.new(self, castling_position, @board)
  end
end
