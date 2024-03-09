# frozen_string_literal: true

require_relative 'position'
require_relative '../board/universal_default_board'

##
# This represents a move in Chess.
#
# It consists of a start position and an end position.
# The static factory method must be used to create new
# objects (constructor is private); this ensures that
# the move is valid.  A valid move at this level means
# that the start and end are not the same.
#
# Instantiated objects of this class are immutable.
class Move
  attr_reader :positions, :board

  extend UniversalDefaultBoard

  def initialize(positions, board)
    @positions = positions
    @board = board
  end

  def ==(other)
    positions == other.positions
  end

  ##
  # This does not do any validation on what the move
  # actually is; any piece can move anywhere on the
  # board (accept to the same spot).  Trying to move
  # an empty square is ignored.
  def move
    start_square = positions.first
    end_square = positions.last

    piece = board.remove(start_square)
    return unless piece

    piece.position = end_square
    captured_piece = board.place(piece)

    log = "\nThe #{piece} has moved from #{start_square.chess_notation} to #{end_square.chess_notation}"
    log = "#{log}, and captured the #{captured_piece}" if captured_piece
    puts "#{log}."
  end

  private_class_method :new

  class << self
    def create(positions, board = default_board)
      return nil unless positions in [Position, Position]

      return nil if positions.first == positions.last

      new(positions, board)
    end
  end
end
