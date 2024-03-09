# frozen_string_literal: true

require_relative 'single_move_piece'

##
# Represents the King in Chess.
# This is an abstract class, with
# no color.
class King < SingleMovePiece
  def initialize(position = nil, board = self.class.default_board)
    super
    self.piece_type = 'king'
    @offsets = KING_OFFSETS
  end
end
