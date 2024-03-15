# frozen_string_literal: true

require_relative 'single_move_piece'
require_relative '../positionals/castling_move'

##
# Represents the King in Chess.
# This is an abstract class, with
# no color.
class King < SingleMovePiece
  def initialize(position = nil, board = self.class.default_board, move_count = 0)
    super
    self.piece_type = 'king'
    @offsets = KING_OFFSETS

    @kingside_castle = nil
    @queenside_castle = nil
  end

  def generate_castling_moves
    castling_moves = []

    kingside_castle_move = @kingside_castle.generate_move
    queenside_castle_move = @queenside_castle.generate_move

    castling_moves << kingside_castle_move if kingside_castle_move
    castling_moves << queenside_castle_move if queenside_castle_move

    castling_moves
  end
end
