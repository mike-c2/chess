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
  attr_reader :starting_position, :ending_position

  extend UniversalDefaultBoard

  def initialize(starting_position, ending_position, board)
    @starting_position = starting_position
    @ending_position = ending_position
    @board = board
  end

  private_class_method :new

  def ==(other)
    [starting_position, ending_position] == [other.starting_position, other.ending_position]
  end

  ##
  # This does not do any validation on what the move
  # actually is; any piece can move anywhere on the
  # board (accept to the same spot).  Trying to move
  # to an empty square is ignored.
  def move
    piece = @board.remove(starting_position)
    return unless piece

    piece.increment_move_count
    piece.position = ending_position
    captured_piece = @board.place(piece)

    log = "\nThe #{piece} has moved from #{starting_position.chess_notation} to #{ending_position.chess_notation}"
    log = "#{log}, and captured the #{captured_piece}" if captured_piece
    puts "#{log}."
  end

  # This performs the actual move on the board,
  # check to see if it results in the side making
  # the move being in check, then undoes the move
  # on the board.
  def move_own_check?
    moving_piece = @board.remove(starting_position)
    moving_piece.position = ending_position
    captured_piece = @board.place(moving_piece)

    check = moving_piece.in_check?

    moving_piece.position = starting_position
    @board.place(moving_piece)

    captured_piece ? @board.place(captured_piece) : @board.remove(ending_position)

    check
  end

  class << self
    def create(starting_position, ending_position, board = default_board)
      return nil unless [starting_position, ending_position] in [Position, Position]

      return nil if starting_position == ending_position

      new(starting_position, ending_position, board)
    end
  end
end
