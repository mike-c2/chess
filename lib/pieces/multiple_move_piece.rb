# frozen_string_literal: true

require_relative 'empty_piece'

##
# This represents a piece in Chess that
# moves one or more spaces at a time.
#
# For example: Queen, Bishop, and Rook.
class MultipleMovePiece < EmptyPiece
  def generate_possible_moves
    possible_moves = []

    @offsets.each do |offset|
      multiple_moves_at_a_time = generate_possible_multiple_moves(offset)
      possible_moves.concat(multiple_moves_at_a_time)
    end

    possible_moves
  end

  private

  def generate_possible_multiple_moves(offset)
    possible_moves = []

    total_offset = [0, 0]

    loop do
      total_offset = [total_offset.first + offset.first, total_offset.last + offset.last]

      next_move = generate_potential_move(total_offset)
      break unless next_move

      possible_moves << next_move

      # cannot jump over enemy pieces
      break if @board.get(next_move.ending_position)
    end

    possible_moves
  end
end
