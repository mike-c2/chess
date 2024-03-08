# frozen_string_literal: true

require_relative 'empty_piece'

##
# Represents the Bishop in Chess.
# This is an abstract class, with
# no color.
class Bishop < EmptyPiece
  def initialize(position = nil, board = self.class.default_board)
    super
    self.piece_type = 'bishop'
    @offsets = BISHOP_OFFSETS
  end
end
