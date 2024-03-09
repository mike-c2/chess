# frozen_string_literal: true

require_relative '../board/universal_default_board'
require_relative 'colors/color'
require_relative 'piece_offsets'

##
# This represents an empty Chess piece.
# This is mostly an abstract class, the real pieces will
# inherit from this. An object of this class will be used
# to represent an empty space on the board.
class EmptyPiece
  attr_accessor :position
  attr_reader :board, :move_count, :piece_type, :offsets

  extend UniversalDefaultBoard
  include Color
  include PieceOffsets

  def initialize(position = nil, board = self.class.default_board)
    @board = board
    @move_count = 0
    @position = position
    @offsets = []
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
  # that is printed to the terminal
  def piece_str
    piece_type.to_s.capitalize
  end

  # For child classes, this would be the color and
  # piece_type, i.e. 'white king'
  def to_s
    "#{color} #{piece_type}".strip
  end

  private

  attr_writer :piece_type
end
