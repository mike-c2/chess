# frozen_string_literal: true

require_relative 'empty_piece'

##
# Represents the Queen in Chess.
# This is an abstract class, with
# no color.
class Queen < EmptyPiece
  def initialize(position = nil, board = self.class.default_board)
    super
    self.piece_type = 'queen'
    @offsets = QUEEN_OFFSETS
  end
end
