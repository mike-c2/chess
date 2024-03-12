# frozen_string_literal: true

require_relative 'multiple_move_piece'

##
# Represents the Queen in Chess.
# This is an abstract class, with
# no color.
class Queen < MultipleMovePiece
  def initialize(position = nil, board = self.class.default_board, move_count = 0)
    super
    self.piece_type = 'queen'
    @offsets = QUEEN_OFFSETS
  end
end
