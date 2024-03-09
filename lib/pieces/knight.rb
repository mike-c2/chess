# frozen_string_literal: true

require_relative 'single_move_piece'

##
# Represents the Knight in Chess.
# This is an abstract class, with
# no color.
class Knight < SingleMovePiece
  def initialize(position = nil, board = self.class.default_board)
    super
    self.piece_type = 'knight'
    @offsets = KNIGHT_OFFSETS
  end
end
