# frozen_string_literal: true

require_relative 'empty_piece'

##
# This represents a piece in Chess that
# only moves one space at a time.
#
# For example, King and Knight.
class SingleMovePiece < EmptyPiece
  def generate_possible_moves
    possible_moves = []

    @offsets.each do |offset|
      next_move = generate_potential_move(offset)
      possible_moves << next_move if next_move
    end

    possible_moves
  end
end
