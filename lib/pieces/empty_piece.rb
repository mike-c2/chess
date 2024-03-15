# frozen_string_literal: true

require_relative '../board/universal_default_board'
require_relative '../colors/color'
require_relative 'piece_offsets'

##
# This represents an empty Chess piece.
# This is mostly an abstract class, the real pieces will
# inherit from this. An object of this class will be used
# to represent an empty space on the board.
class EmptyPiece
  attr_accessor :position
  attr_reader :move_count, :piece_type, :offsets

  extend UniversalDefaultBoard
  include Color
  include PieceOffsets

  def initialize(position = nil, board = self.class.default_board, move_count = 0)
    @board = board
    @position = position
    @move_count = move_count
    @offsets = []
  end

  def increment_move_count
    @move_count += 1
  end

  # These methods will be more defined in the subclasses
  def generate_possible_moves
    []
  end

  def generate_castling_moves
    []
  end

  def check?
    false
  end

  # These will be used by pawns
  def promote; end
  def enable_passant_vulnerable; end
  def disable_passant_vulnerable; end

  def passant_vulnerable?
    false
  end

  # Same as promote, but just promotes to 'queen'
  # without asking.
  # This is meant for the AI playing the game.
  def no_prompt_promote; end

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

  # Symbols are not used here because this is meant
  # more for serialization and JSON cannot handle
  # symbols.
  def to_h
    { 'color' => color,
      'piece_type' => piece_type,
      'position' => position.chess_notation,
      'move_count' => move_count }
  end

  private

  attr_writer :piece_type

  def generate_potential_move(offset)
    next_position = position.add_offset(offset)
    potential_move = Move.create(position, next_position, @board)
    return unless potential_move

    piece = @board.get(next_position)

    potential_move if piece.nil? || opponents_side?(piece)
  end
end
