# frozen_string_literal: true

require_relative 'universal_default_board'

##
# This represents an empty Chess piece.
# This is mostly an abstract class, the real pieces will
# inherit from this. An object of this class will be used
# to represent an empty space on the board.
class EmptyPiece
  attr_accessor :current_position
  attr_reader :board, :move_counter

  extend UniversalDefaultBoard

  EMPTY = new
  WHITE = 'white'
  BLACK = 'black'
  WHITE_FONT_COLOR = "\e[37m"
  BLACK_FONT_COLOR = "\e[30m"

  def initialize(board = default_board)
    self.board = board
    self.current_position = nil
    self.move_counter = 0
  end

  def increment_counter; end

  # These methods will be more defined in the subclasses
  def generate_possible_moves
    []
  end

  def check?
    false
  end

  def same_color?(_other)
    false
  end

  def opponents_color?(_other)
    false
  end

  # How the piece actually looks on the board
  def piece_str
    ''
  end
end
