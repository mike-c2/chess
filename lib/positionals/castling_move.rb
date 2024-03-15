# frozen_string_literal: true

require_relative 'move'

##
# This class represents the Castling Move in Chess
class CastlingMove < Move
  def initialize(starting_position, ending_position, rook_starting_position, rook_ending_position, board)
    super(starting_position, ending_position, board)

    @rook_starting_position = rook_starting_position
    @rook_ending_position = rook_ending_position
  end

  private_class_method :new

  def move
    king = @board.remove(@starting_position)
    king.position = @ending_position

    rook = @board.remove(@rook_starting_position)
    rook.position = @rook_ending_position

    @board.place(king)
    @board.place(rook)

    king.increment_move_count
    rook.increment_move_count

    puts "The #{king} has performed a castling move, moving to #{@ending_position.chess_notation}."
    puts "Also, the #{rook} has moved to #{@rook_ending_position.chess_notation}."
  end

  # Castling move generation handles the check test
  def move_own_check?
    false
  end

  class << self
    def create(starting_position, ending_position, rook_starting_position, rook_ending_position, board = default_board)
      args = [starting_position, ending_position, rook_starting_position, rook_ending_position]
      return nil unless args in [Position, Position, Position, Position]

      return nil unless args.uniq(&:chess_notation).length == 4

      new(starting_position, ending_position, rook_starting_position, rook_ending_position, board)
    end
  end
end
