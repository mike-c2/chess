# frozen_string_literal: true

require_relative 'move'

##
# This class represents an En Passant Move in Chess
class EnPassantMove < Move
  # An En Passant move cannot be a Pre Passant Move
  # Hence there is no pre_passant_move parameter here.
  def initialize(starting_position, ending_position, capture_position, board)
    super(starting_position, ending_position, board)

    @capture_position = capture_position
  end

  private_class_method :new

  def move
    super.move

    captured_piece = @board.remove(@capture_position)
    puts "The #{captured_piece} was captured En Passant."
  end

  def move_own_check?
    moving_piece = @board.remove(starting_position)
    moving_piece.position = ending_position
    @board.place(moving_piece)
    captured_piece = @board.remove(@capture_position)

    check = moving_piece.in_check?

    moving_piece.position = starting_position
    @board.place(moving_piece)
    @board.place(captured_piece)

    check
  end

  class << self
    def create(starting_position, ending_position, capture_position, board = default_board)
      return nil unless [starting_position, ending_position, capture_position] in [Position, Position, Position]

      return nil if starting_position == ending_position

      return nil if starting_position == capture_position || ending_position == capture_position

      new(starting_position, ending_position, capture_position, board)
    end
  end
end
