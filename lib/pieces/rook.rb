# frozen_string_literal: true

require_relative 'empty_piece'

##
# Represents the Rook in Chess.
# This is an abstract class, with
# no color.
class Rook < EmptyPiece
  def initialize(board = self.class.default_board)
    super
    self.piece_type = 'rook'
    @offsets = ROOK_OFFSETS
  end
end
