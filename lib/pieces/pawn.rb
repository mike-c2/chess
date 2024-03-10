# frozen_string_literal: true

require_relative 'empty_piece'
require_relative '../positionals/move'

##
# Represents the Pawn in Chess.
# This is an abstract class, with
# no color.
class Pawn < EmptyPiece
  def initialize(position = nil, board = self.class.default_board)
    super
    self.piece_type = 'pawn'
    @single_move_offset = []
    @double_move_offset = []
    @kill_offsets = []
    @double_move_row = -1
    @promotion_row = -1
  end

  def generate_possible_moves
    no_kill_moves + kill_moves
  end

  private

  def kill_moves
    possible_moves = []

    @kill_offsets.each do |offset|
      next_position = position.add_offset(offset)
      next unless next_position

      next unless @board.get(next_position)

      next_move = Move.create(position, next_position)
      possible_moves << next_move if next_move
    end

    possible_moves
  end

  def no_kill_moves
    possible_moves = []

    single_move = no_kill_move(@single_move_offset)
    possible_moves << single_move if single_move

    # If single move is not possible, then neither is double.
    # Double move can only happen on pawn's first move
    # Pawn must be in the correct starting row.
    if possible_moves.length.positive? && move_count.zero? && position.array_notation.first == @double_move_row
      double_move = no_kill_move(@double_move_offset)
      possible_moves << double_move if double_move
    end

    possible_moves
  end

  def no_kill_move(offset)
    next_position = position.add_offset(offset)
    return unless next_position

    return if @board.get(next_position)

    Move.create(position, next_position)
  end
end
