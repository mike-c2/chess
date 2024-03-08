# frozen_string_literal: true

require_relative 'empty_piece'

##
# Represents the Pawn in Chess.
# This is an abstract class, with
# no color.
class Pawn < EmptyPiece
  def initialize(position = nil, board = self.class.default_board)
    super
    self.piece_type = 'pawn'
  end
end
