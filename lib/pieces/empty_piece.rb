# frozen_string_literal: true

require_relative '../universal_default_board'
require_relative 'colors/color'

##
# This represents an empty Chess piece.
# This is mostly an abstract class, the real pieces will
# inherit from this. An object of this class will be used
# to represent an empty space on the board.
class EmptyPiece
  attr_accessor :current_position
  attr_reader :board, :move_count, :piece_type

  extend UniversalDefaultBoard
  include Color

  def initialize(board = self.class.default_board)
    @board = board
    @move_count = 0
    @current_position = nil
  end

  def increment_move_count
    @move_count += 1
  end

  # These methods will be more defined in the subclasses
  def generate_possible_moves
    []
  end

  def check?
    false
  end

  # How the piece actually looks on the board
  def piece_str
    ''
  end

  # For child classes, this would be the color and
  # piece_type, i.e. 'white king'
  def to_s
    ''
  end
end
